import 'package:api/build/data/identity.pb.dart';
import 'package:server/common/config_manager.dart';
import 'package:server/common/logger.dart';

/// Source-of-truth for player identity. Call [initialize] before use.
class IdentityStore with DiskBak {
  /// Map of all player identities (approved and unapproved), keyed by username.
  final _idStore = <String, Identity>{};

  /// Singleton instance of [IdentityStore].
  static final IdentityStore _instance = IdentityStore._();

  var _isInitialized = false;

  final _logger = Logger();

  /// All identities, approved and unapproved.
  List<Identity> get allIdentities => _idStore.values.toList();

  /// All approved identities.
  List<Identity> get approvedIdentities => _idStore.values.where((id) => id.isApproved).toList();

  @override
  String get configIdentifier => 'identities';

  /// All unapproved identities.
  List<Identity> get unapprovedIdentities => _idStore.values.where((id) => !id.isApproved).toList();

  /// Return the singleton instance of [IdentityStore].
  factory IdentityStore() => _instance;

  /// Private constructor.
  IdentityStore._();

  /// Load identities from disk into the store.
  ///
  /// ### Notes
  /// - No-op if already initialized.
  ///
  /// ### Logs
  /// - `warning` already initialized
  /// - `info` no config file found; starting with empty store
  /// - `info` loaded N identities from disk
  Future<void> initialize() async {
    if (_isInitialized) {
      _logger.log(
        'IdentityStore already initialized; skipping.',
        'IdentityStore/initialize',
        LogLevel.warning,
      );

      return;
    }

    final found = await ConfigManager().load(this);

    if (!found) {
      _logger.log(
        'No identities file found; starting with empty store.',
        'IdentityStore/initialize',
        LogLevel.info,
      );
    } else {
      _logger.log(
        'Loaded ${_idStore.length} identities from disk.',
        'IdentityStore/initialize',
        LogLevel.info,
      );
    }

    _isInitialized = true;
  }

  @override
  dynamic toJson() => _idStore.values.map((id) => id.toJson()).toList();

  @override
  void updateFromJson(dynamic json) {
    _idStore
      ..clear()
      ..addEntries(
        (json as List)
            .cast<Map<String, dynamic>>()
            .map(Identity.fromJson)
            .map((id) => MapEntry(id.username, id)),
      );
  }

  /// Add a new identity to the store.
  ///
  /// ### Notes
  /// - Returns the created [Identity], or null if the username already exists.
  ///
  /// ### Logs
  /// - `info` identity added
  /// - `warning` username already exists
  Identity? addIdentity({required String username, required String identityToken}) {
    if (_idStore.containsKey(username)) {
      _logger.log(
        'Identity for username: $username already exists; Identity not created.',
        'IdentityStore/addIdentity',
        LogLevel.warning,
      );

      return null;
    }

    final identity = Identity._(username, identityToken, ApprovedAs.APPROVED_AS_UNAPPROVED);
    _idStore[username] = identity;
    saveToDisk();

    _logger.log(
      'Added new identity for username: $username',
      'IdentityStore/addIdentity',
      LogLevel.info,
    );

    return identity;
  }

  /// Approve an identity.
  ///
  /// ### Logs
  /// - `info` identity approved
  /// - `warning` identity not found
  void approveIdentity(Identity identity, [bool asDM = false]) {
    final stored = _lookup(identity, 'Approval');
    if (stored == null) return;

    stored._approvedAs = asDM ? ApprovedAs.APPROVED_AS_DM : ApprovedAs.APPROVED_AS_PLAYER;
    saveToDisk();

    _logger.log(
      'Approved identity for username: ${identity.username}',
      'IdentityStore/approveIdentity',
      LogLevel.info,
    );
  }

  /// Delete an identity from the store.
  ///
  /// ### Logs
  /// - `info` identity deleted
  /// - `warning` identity not found
  void deleteIdentity(Identity identity) {
    if (_lookup(identity, 'Deletion') == null) return;

    _idStore.remove(identity.username);
    saveToDisk();

    _logger.log(
      'Deleted identity for username: ${identity.username}',
      'IdentityStore/deleteIdentity',
      LogLevel.info,
    );
  }

  /// Disapprove an identity.
  ///
  /// ### Logs
  /// - `info` identity disapproved
  /// - `warning` identity not found
  void disapproveIdentity(Identity identity) {
    final stored = _lookup(identity, 'Disapproval');
    if (stored == null) return;

    stored._approvedAs = ApprovedAs.APPROVED_AS_UNAPPROVED;
    saveToDisk();

    _logger.log(
      'Disapproved identity for username: ${identity.username}',
      'IdentityStore/disapproveIdentity',
      LogLevel.info,
    );
  }

  /// Get the [Identity] for a given username, or null if not found.
  Identity? getIdentity({required String username}) => _idStore[username];

  /// Store a session token against an identity.
  ///
  /// ### Logs
  /// - `info` session token stored
  /// - `warning` identity not found
  /// - `warning` identity not approved
  void logSessionToken(Identity identity, String sessionToken) {
    final stored = _lookup(identity, 'Session token logging');
    if (stored == null) return;

    if (!stored.isApproved) {
      _logger.log(
        'Identity for username: ${identity.username} not approved; Session token logging failed.',
        'IdentityStore/logSessionToken',
        LogLevel.warning,
      );

      return;
    }

    stored._sessionToken = sessionToken;
    _logger.log(
      'Logged session token for username: ${identity.username}',
      'IdentityStore/logSessionToken',
      LogLevel.info,
    );
  }

  /// Save identities to disk via [ConfigManager].
  ///
  /// ### Notes
  /// - Call without `await` for fire-and-forget.
  void saveToDisk() => ConfigManager().save(this);

  /// Return the stored [Identity] for [identity], or null if not found.
  ///
  /// Logs a warning on miss using [operation] as context.
  Identity? _lookup(Identity identity, String operation) {
    final stored = _idStore[identity.username];

    if (stored == null) {
      _logger.log(
        'Identity for username: ${identity.username} not found; $operation failed.',
        'IdentityStore/_lookup',
        LogLevel.warning,
      );
    }

    return stored;
  }
}

/// Represents a player's identity.
class Identity {
  ApprovedAs _approvedAs = ApprovedAs.APPROVED_AS_UNAPPROVED;

  String _sessionToken = '';

  /// Whether this identity has been approved to access the server.
  bool get isApproved => _approvedAs != ApprovedAs.APPROVED_AS_UNAPPROVED;

  /// bcrypt hash of `username::password`.
  final String identityToken;

  /// Player username; must be unique across all identities.
  final String username;

  /// Whether this identity has been approved to access the server.
  ApprovedAs get approvedAs => _approvedAs;

  /// Session token for the current session; empty if not authenticated.
  String get sessionToken => _sessionToken;

  /// Private constructor — only [IdentityStore] creates instances.
  Identity._(this.username, this.identityToken, this._approvedAs);

  /// Deserialize an [Identity] from a JSON map.
  factory Identity.fromJson(Map<String, dynamic> json) {
    final approvedAs = ApprovedAs.values.firstWhere(
      (e) => e.name == json['approvedAs'] as String,
      orElse: () => ApprovedAs.APPROVED_AS_UNAPPROVED,
    );

    return Identity._(json['username'] as String, json['identityToken'] as String, approvedAs);
  }

  /// Serialize this [Identity] to a JSON map.
  ///
  /// ### Notes
  /// - Session tokens are ephemeral and are not persisted.
  Map<String, dynamic> toJson() => {
    'username': username,
    'identityToken': identityToken,
    'approvedAs': _approvedAs.name,
  };
}
