// This is a generated file - do not edit.
//
// Generated from service/logger.proto.

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

import '../common.pb.dart' as $1;
import '../data/log_entry.pb.dart' as $0;

export 'logger.pb.dart';

@$pb.GrpcServiceName('Logger')
class LoggerClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  LoggerClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.Empty> log(
    $0.LogEntry request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$log, request, options: options);
  }

  // method descriptors

  static final _$log = $grpc.ClientMethod<$0.LogEntry, $1.Empty>('/Logger/log',
      ($0.LogEntry value) => value.writeToBuffer(), $1.Empty.fromBuffer);
}

@$pb.GrpcServiceName('Logger')
abstract class LoggerServiceBase extends $grpc.Service {
  $core.String get $name => 'Logger';

  LoggerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.LogEntry, $1.Empty>(
        'log',
        log_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LogEntry.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> log_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.LogEntry> $request) async {
    return log($call, await $request);
  }

  $async.Future<$1.Empty> log($grpc.ServiceCall call, $0.LogEntry request);
}
