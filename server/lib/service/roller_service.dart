import 'dart:math';

import 'package:api/build/data/dice.pb.dart';
import 'package:api/build/data/log_entry.pb.dart';
import 'package:api/build/service/roller.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:server/common/identity_store.dart';
import 'package:server/service/logger_service.dart';

/// Singleton gRPC service for cryptographically secure dice rolls.
class RollerService extends RollerServiceBase {
  static final RollerService _instance = RollerService._();

  final _logger = Logger();
  final _rng = Random.secure();
  final _store = IdentityStore();

  /// Return the singleton instance of [RollerService].
  factory RollerService() => _instance;

  /// Private constructor.
  RollerService._();

  @override
  Future<RollResult> roll(ServiceCall call, DiceDefinition request) async {
    final sessionToken = call.clientMetadata?['session-token'];

    if (sessionToken == null || sessionToken.isEmpty) {
      _logger.logLocally(
        'Roll request missing session token.',
        'RollerService/roll',
        LogLevel.ERROR,
        true,
      );

      throw GrpcError.unauthenticated('missing session-token metadata');
    }

    final identity = _store.getIdentityBySession(sessionToken: sessionToken);

    if (identity == null) {
      _logger.logLocally(
        'Roll request with invalid session token.',
        'RollerService/roll',
        LogLevel.ERROR,
        true,
      );

      throw GrpcError.unauthenticated('invalid session token');
    }

    final username = identity.username;
    final rolls = <int>[];

    for (final diceSet in request.diceSets) {
      if (diceSet.sides <= 0) {
        _logger.logLocally(
          '$username rolled invalid die: ${diceSet.count}d${diceSet.sides} (sides must be > 0)',
          'RollerService/roll',
          LogLevel.ERROR,
          true,
        );

        throw GrpcError.invalidArgument('sides must be > 0');
      }

      for (var i = 0; i < diceSet.count; i++) {
        rolls.add(_rng.nextInt(diceSet.sides) + 1);
      }
    }

    _logger.logLocally(
      '$username rolled ${rolls.length} dice → $rolls (total: ${rolls.fold<int>(0, (a, b) => a + b)})',
      'RollerService/roll',
      LogLevel.INFO,
    );

    return RollResult(individualRolls: rolls);
  }
}
