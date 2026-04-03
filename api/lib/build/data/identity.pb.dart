// This is a generated file - do not edit.
//
// Generated from data/identity.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'identity.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'identity.pbenum.dart';

/// Persistent player authentication tokens.
class PlayerIdentity extends $pb.GeneratedMessage {
  factory PlayerIdentity({
    $core.String? username,
    $core.String? password,
  }) {
    final result = create();
    if (username != null) result.username = username;
    if (password != null) result.password = password;
    return result;
  }

  PlayerIdentity._();

  factory PlayerIdentity.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PlayerIdentity.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PlayerIdentity',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'username')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlayerIdentity clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlayerIdentity copyWith(void Function(PlayerIdentity) updates) =>
      super.copyWith((message) => updates(message as PlayerIdentity))
          as PlayerIdentity;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlayerIdentity create() => PlayerIdentity._();
  @$core.override
  PlayerIdentity createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PlayerIdentity getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PlayerIdentity>(create);
  static PlayerIdentity? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => $_clearField(2);
}

/// Session authentication token.
class AuthToken extends $pb.GeneratedMessage {
  factory AuthToken({
    $core.String? token,
    $core.bool? isApproved,
  }) {
    final result = create();
    if (token != null) result.token = token;
    if (isApproved != null) result.isApproved = isApproved;
    return result;
  }

  AuthToken._();

  factory AuthToken.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AuthToken.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuthToken',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOB(2, _omitFieldNames ? '' : 'isApproved')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthToken clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthToken copyWith(void Function(AuthToken) updates) =>
      super.copyWith((message) => updates(message as AuthToken)) as AuthToken;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuthToken create() => AuthToken._();
  @$core.override
  AuthToken createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AuthToken getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AuthToken>(create);
  static AuthToken? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isApproved => $_getBF(1);
  @$pb.TagNumber(2)
  set isApproved($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIsApproved() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsApproved() => $_clearField(2);
}

/// Service information for connecting to a micro-service.
class ServiceInfo extends $pb.GeneratedMessage {
  factory ServiceInfo({
    Services? serviceName,
    $core.int? servicePort,
  }) {
    final result = create();
    if (serviceName != null) result.serviceName = serviceName;
    if (servicePort != null) result.servicePort = servicePort;
    return result;
  }

  ServiceInfo._();

  factory ServiceInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ServiceInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServiceInfo',
      createEmptyInstance: create)
    ..aE<Services>(1, _omitFieldNames ? '' : 'serviceName',
        enumValues: Services.values)
    ..aI(2, _omitFieldNames ? '' : 'servicePort')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceInfo copyWith(void Function(ServiceInfo) updates) =>
      super.copyWith((message) => updates(message as ServiceInfo))
          as ServiceInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServiceInfo create() => ServiceInfo._();
  @$core.override
  ServiceInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ServiceInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ServiceInfo>(create);
  static ServiceInfo? _defaultInstance;

  @$pb.TagNumber(1)
  Services get serviceName => $_getN(0);
  @$pb.TagNumber(1)
  set serviceName(Services value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasServiceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get servicePort => $_getIZ(1);
  @$pb.TagNumber(2)
  set servicePort($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasServicePort() => $_has(1);
  @$pb.TagNumber(2)
  void clearServicePort() => $_clearField(2);
}

/// Request for `ServiceInfo` on a particular service.
class ServiceRequest extends $pb.GeneratedMessage {
  factory ServiceRequest({
    Services? serviceName,
  }) {
    final result = create();
    if (serviceName != null) result.serviceName = serviceName;
    return result;
  }

  ServiceRequest._();

  factory ServiceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ServiceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServiceRequest',
      createEmptyInstance: create)
    ..aE<Services>(1, _omitFieldNames ? '' : 'serviceName',
        enumValues: Services.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceRequest copyWith(void Function(ServiceRequest) updates) =>
      super.copyWith((message) => updates(message as ServiceRequest))
          as ServiceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServiceRequest create() => ServiceRequest._();
  @$core.override
  ServiceRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ServiceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ServiceRequest>(create);
  static ServiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Services get serviceName => $_getN(0);
  @$pb.TagNumber(1)
  set serviceName(Services value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasServiceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceName() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
