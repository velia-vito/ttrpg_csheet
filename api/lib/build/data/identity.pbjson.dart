// This is a generated file - do not edit.
//
// Generated from data/identity.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use approvedAsDescriptor instead')
const ApprovedAs$json = {
  '1': 'ApprovedAs',
  '2': [
    {'1': 'APPROVED_AS_UNAPPROVED', '2': 0},
    {'1': 'APPROVED_AS_PLAYER', '2': 1},
    {'1': 'APPROVED_AS_DM', '2': 2},
  ],
};

/// Descriptor for `ApprovedAs`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List approvedAsDescriptor = $convert.base64Decode(
    'CgpBcHByb3ZlZEFzEhoKFkFQUFJPVkVEX0FTX1VOQVBQUk9WRUQQABIWChJBUFBST1ZFRF9BU1'
    '9QTEFZRVIQARISCg5BUFBST1ZFRF9BU19ETRAC');

@$core.Deprecated('Use servicesDescriptor instead')
const Services$json = {
  '1': 'Services',
  '2': [
    {'1': 'UNKNOWN_SERVICE', '2': 0},
    {'1': 'ROLLER_SERVICE', '2': 1},
    {'1': 'LOG_SERVICE', '2': 2},
  ],
};

/// Descriptor for `Services`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List servicesDescriptor = $convert.base64Decode(
    'CghTZXJ2aWNlcxITCg9VTktOT1dOX1NFUlZJQ0UQABISCg5ST0xMRVJfU0VSVklDRRABEg8KC0'
    'xPR19TRVJWSUNFEAI=');

@$core.Deprecated('Use playerIdentityDescriptor instead')
const PlayerIdentity$json = {
  '1': 'PlayerIdentity',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `PlayerIdentity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerIdentityDescriptor = $convert.base64Decode(
    'Cg5QbGF5ZXJJZGVudGl0eRIaCgh1c2VybmFtZRgBIAEoCVIIdXNlcm5hbWUSGgoIcGFzc3dvcm'
    'QYAiABKAlSCHBhc3N3b3Jk');

@$core.Deprecated('Use authTokenDescriptor instead')
const AuthToken$json = {
  '1': 'AuthToken',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'token', '17': true},
    {
      '1': 'is_approved',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.ApprovedAs',
      '10': 'isApproved'
    },
  ],
  '8': [
    {'1': '_token'},
  ],
};

/// Descriptor for `AuthToken`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authTokenDescriptor = $convert.base64Decode(
    'CglBdXRoVG9rZW4SGQoFdG9rZW4YASABKAlIAFIFdG9rZW6IAQESLAoLaXNfYXBwcm92ZWQYAi'
    'ABKA4yCy5BcHByb3ZlZEFzUgppc0FwcHJvdmVkQggKBl90b2tlbg==');

@$core.Deprecated('Use serviceInfoDescriptor instead')
const ServiceInfo$json = {
  '1': 'ServiceInfo',
  '2': [
    {
      '1': 'service_name',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.Services',
      '10': 'serviceName'
    },
    {'1': 'service_port', '3': 2, '4': 1, '5': 5, '10': 'servicePort'},
  ],
};

/// Descriptor for `ServiceInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serviceInfoDescriptor = $convert.base64Decode(
    'CgtTZXJ2aWNlSW5mbxIsCgxzZXJ2aWNlX25hbWUYASABKA4yCS5TZXJ2aWNlc1ILc2VydmljZU'
    '5hbWUSIQoMc2VydmljZV9wb3J0GAIgASgFUgtzZXJ2aWNlUG9ydA==');

@$core.Deprecated('Use serviceRequestDescriptor instead')
const ServiceRequest$json = {
  '1': 'ServiceRequest',
  '2': [
    {
      '1': 'service_name',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.Services',
      '10': 'serviceName'
    },
  ],
};

/// Descriptor for `ServiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serviceRequestDescriptor = $convert.base64Decode(
    'Cg5TZXJ2aWNlUmVxdWVzdBIsCgxzZXJ2aWNlX25hbWUYASABKA4yCS5TZXJ2aWNlc1ILc2Vydm'
    'ljZU5hbWU=');
