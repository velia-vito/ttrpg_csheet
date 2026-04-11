// This is a generated file - do not edit.
//
// Generated from data/log_entry.proto.

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

@$core.Deprecated('Use logLevelDescriptor instead')
const LogLevel$json = {
  '1': 'LogLevel',
  '2': [
    {'1': 'INFO', '2': 0},
    {'1': 'WARNING', '2': 1},
    {'1': 'ERROR', '2': 2},
  ],
};

/// Descriptor for `LogLevel`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List logLevelDescriptor = $convert.base64Decode(
    'CghMb2dMZXZlbBIICgRJTkZPEAASCwoHV0FSTklORxABEgkKBUVSUk9SEAI=');

@$core.Deprecated('Use logEntryDescriptor instead')
const LogEntry$json = {
  '1': 'LogEntry',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'source', '3': 2, '4': 1, '5': 9, '10': 'source'},
    {'1': 'level', '3': 3, '4': 1, '5': 14, '6': '.LogLevel', '10': 'level'},
    {'1': 'isPriotiy', '3': 4, '4': 1, '5': 8, '10': 'isPriotiy'},
    {'1': 'timestamp', '3': 5, '4': 1, '5': 3, '10': 'timestamp'},
  ],
};

/// Descriptor for `LogEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logEntryDescriptor = $convert.base64Decode(
    'CghMb2dFbnRyeRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdlEhYKBnNvdXJjZRgCIAEoCVIGc2'
    '91cmNlEh8KBWxldmVsGAMgASgOMgkuTG9nTGV2ZWxSBWxldmVsEhwKCWlzUHJpb3RpeRgEIAEo'
    'CFIJaXNQcmlvdGl5EhwKCXRpbWVzdGFtcBgFIAEoA1IJdGltZXN0YW1w');
