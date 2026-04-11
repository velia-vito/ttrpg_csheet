// This is a generated file - do not edit.
//
// Generated from service/roller.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import '../data/dice.pb.dart' as $0;

export 'roller.pb.dart';

@$pb.GrpcServiceName('Roller')
class RollerClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  RollerClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.RollResult> roll(
    $0.DiceDefinition request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$roll, request, options: options);
  }

  // method descriptors

  static final _$roll = $grpc.ClientMethod<$0.DiceDefinition, $0.RollResult>(
      '/Roller/roll',
      ($0.DiceDefinition value) => value.writeToBuffer(),
      $0.RollResult.fromBuffer);
}

@$pb.GrpcServiceName('Roller')
abstract class RollerServiceBase extends $grpc.Service {
  $core.String get $name => 'Roller';

  RollerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.DiceDefinition, $0.RollResult>(
        'roll',
        roll_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DiceDefinition.fromBuffer(value),
        ($0.RollResult value) => value.writeToBuffer()));
  }

  $async.Future<$0.RollResult> roll_Pre($grpc.ServiceCall $call,
      $async.Future<$0.DiceDefinition> $request) async {
    return roll($call, await $request);
  }

  $async.Future<$0.RollResult> roll(
      $grpc.ServiceCall call, $0.DiceDefinition request);
}
