// This is a generated file - do not edit.
//
// Generated from service/handler.proto.

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
import '../data/identity.pb.dart' as $0;

export 'handler.pb.dart';

/// Micro-Server for Sheet related data.
@$pb.GrpcServiceName('Handler')
class HandlerClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  HandlerClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.Empty> logIdentity(
    $0.PlayerIdentity request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$logIdentity, request, options: options);
  }

  /// Prove identity and get a session token.
  $grpc.ResponseFuture<$0.AuthToken> handshake(
    $0.PlayerIdentity request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$handshake, request, options: options);
  }

  /// Request connection information for a particular service.
  $grpc.ResponseFuture<$0.ServiceInfo> requestService(
    $0.ServiceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$requestService, request, options: options);
  }

  // method descriptors

  static final _$logIdentity = $grpc.ClientMethod<$0.PlayerIdentity, $1.Empty>(
      '/Handler/logIdentity',
      ($0.PlayerIdentity value) => value.writeToBuffer(),
      $1.Empty.fromBuffer);
  static final _$handshake =
      $grpc.ClientMethod<$0.PlayerIdentity, $0.AuthToken>(
          '/Handler/handshake',
          ($0.PlayerIdentity value) => value.writeToBuffer(),
          $0.AuthToken.fromBuffer);
  static final _$requestService =
      $grpc.ClientMethod<$0.ServiceRequest, $0.ServiceInfo>(
          '/Handler/requestService',
          ($0.ServiceRequest value) => value.writeToBuffer(),
          $0.ServiceInfo.fromBuffer);
}

@$pb.GrpcServiceName('Handler')
abstract class HandlerServiceBase extends $grpc.Service {
  $core.String get $name => 'Handler';

  HandlerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.PlayerIdentity, $1.Empty>(
        'logIdentity',
        logIdentity_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PlayerIdentity.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PlayerIdentity, $0.AuthToken>(
        'handshake',
        handshake_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PlayerIdentity.fromBuffer(value),
        ($0.AuthToken value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ServiceRequest, $0.ServiceInfo>(
        'requestService',
        requestService_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ServiceRequest.fromBuffer(value),
        ($0.ServiceInfo value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> logIdentity_Pre($grpc.ServiceCall $call,
      $async.Future<$0.PlayerIdentity> $request) async {
    return logIdentity($call, await $request);
  }

  $async.Future<$1.Empty> logIdentity(
      $grpc.ServiceCall call, $0.PlayerIdentity request);

  $async.Future<$0.AuthToken> handshake_Pre($grpc.ServiceCall $call,
      $async.Future<$0.PlayerIdentity> $request) async {
    return handshake($call, await $request);
  }

  $async.Future<$0.AuthToken> handshake(
      $grpc.ServiceCall call, $0.PlayerIdentity request);

  $async.Future<$0.ServiceInfo> requestService_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ServiceRequest> $request) async {
    return requestService($call, await $request);
  }

  $async.Future<$0.ServiceInfo> requestService(
      $grpc.ServiceCall call, $0.ServiceRequest request);
}
