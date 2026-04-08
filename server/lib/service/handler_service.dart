import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:api/build/common.pb.dart';
import 'package:api/build/data/identity.pb.dart';
import 'package:api/build/service/handler.pbgrpc.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:grpc/grpc.dart';
import 'package:server/common/config_manager.dart';
import 'package:server/common/identity_store.dart';
import 'package:server/common/logger.dart';

/// gRPC service implementation for handling client requests. Call [initialize] before use.
class HandlerService extends HandlerServiceBase with DiskBak {
  /// Configuration manager for loading service settings.
  final ConfigManager _config = ConfigManager();

  /// Flag to track whether the service has been initialized.
  var _isInitialized = false;

  /// Logger instance for this service.
  final _logger = Logger();

  /// Services List
  final _services = <Services, int>{};

  /// Identity store for managing player credentials and session tokens.
  final _store = IdentityStore();

  @override
  /// Unique identifier for this service's configuration in the [ConfigManager].
  String get configIdentifier => 'services';

  /// Initialize the handler service and load the identity store from disk.
  ///
  /// ### Errors
  /// - `StateError` if the services config file is not found or fails to load
  ///
  /// ### Logs
  /// - `info` services config loaded successfully
  /// - `error` services config failed to load
  Future<void> initialize() async {
    final results = await Future.wait([_store.initialize(), _config.load(this)]);
    final configSuccess = results[1] as bool;

    if (configSuccess) {
      _logger.log(
        'HandlerService loaded services config.',
        'HandlerService/initialize',
        LogLevel.info,
      );
    } else {
      _logger.log(
        'HandlerService services config not found.',
        'HandlerService/initialize',
        LogLevel.error,
        true,
      );

      for (var service in Services.values) {
        _services[service] = 0;
      }

      await _config.save(this);

      _logger.log(
        'Created services config with default values.',
        'HandlerService/initialize',
        LogLevel.info,
      );

      throw StateError('HandlerService services config not found.');
    }

    _isInitialized = true;
  }

  @override
  /// Verify a player's credentials and return a session token.
  ///
  /// ### Errors
  /// - `StateError` called before [initialize]
  ///
  /// ### Logs
  /// - `info` handshake request received
  /// - `info` authentication successful
  /// - `warning` credentials did not match any identity
  /// - `warning` identity not yet approved
  Future<AuthToken> handshake(ServiceCall call, PlayerIdentity playerId) async {
    if (!_isInitialized) {
      _logger.log(
        'Handshake called before HandlerService initialized.',
        'HandlerService/handshake',
        LogLevel.error,
        true,
      );
      throw StateError('handshake called before HandlerService initialized');
    }

    _logger.log(
      'Handshake request received for username: ${playerId.username}',
      'HandlerService/handshake',
      LogLevel.info,
    );

    // Look up stored identity and verify the bcrypt hash.
    final identity = _store.getIdentity(username: playerId.username);

    if (identity == null || !BCrypt.checkpw(playerId.password, identity.identityToken)) {
      _logger.log(
        'Authentication failed for username: ${playerId.username}',
        'HandlerService/handshake',
        LogLevel.warning,
      );

      return AuthToken(token: '', isApproved: ApprovedAs.APPROVED_AS_UNAPPROVED);
    }

    if (!identity.isApproved) {
      _logger.log(
        'Identity not approved for username: ${playerId.username}',
        'HandlerService/handshake',
        LogLevel.warning,
      );

      return AuthToken(token: '', isApproved: ApprovedAs.APPROVED_AS_UNAPPROVED);
    }

    // Issue and store a session token.
    final authToken = genToken();
    _store.logSessionToken(identity, authToken);

    _logger.log(
      'Authentication successful for username: ${playerId.username}',
      'HandlerService/handshake',
      LogLevel.info,
    );

    return AuthToken(token: authToken, isApproved: identity.approvedAs);
  }

  @override
  /// Register a new player identity.
  ///
  /// ### Errors
  /// - `StateError` called before [initialize]
  ///
  /// ### Logs
  /// - `info` identity added (via [IdentityStore])
  /// - `warning` username already exists (via [IdentityStore])
  Future<Empty> logIdentity(ServiceCall call, PlayerIdentity playerId) async {
    if (!_isInitialized) {
      _logger.log(
        'logIdentity called before HandlerService initialized.',
        'HandlerService/logIdentity',
        LogLevel.error,
        true,
      );
      throw StateError('logIdentity called before HandlerService initialized.');
    }

    // Hash password and register it.
    final identityToken = BCrypt.hashpw(playerId.password, BCrypt.gensalt());

    _store.addIdentity(username: playerId.username, identityToken: identityToken);

    return Empty();
  }

  @override
  /// Return connection info for a requested micro-service.
  Future<ServiceInfo> requestService(ServiceCall call, ServiceRequest serviceRequest) async {
    final service = serviceRequest.serviceName;
    final port = _services[service] ?? 0;

    return ServiceInfo(serviceName: service, servicePort: port);
  }

  @override
  toJson() {
    return Map.fromEntries(_services.entries.map((entry) => MapEntry(entry.key.name, entry.value)));
  }

  @override
  void updateFromJson(json) {
    _services
      ..clear()
      ..addAll(
        (json as Map<String, dynamic>).map(
          (key, value) => MapEntry(Services.values.firstWhere((s) => s.name == key), value as int),
        ),
      );
  }

  /// Generate a cryptographically secure random token encoded as URL-safe base64.
  ///
  /// ### Args
  /// - `tokenLength` number of random bytes before encoding (default: 64)
  String genToken({int tokenLength = 64}) {
    final randomEngine = Random.secure();
    final tokenBytes = Uint8List(tokenLength);

    for (var i = 0; i < tokenLength; i++) {
      tokenBytes[i] = randomEngine.nextInt(256);
    }

    return base64UrlEncode(tokenBytes);
  }
}
