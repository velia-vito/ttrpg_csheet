// This is a generated file - do not edit.
//
// Generated from data/log_entry.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class LogLevel extends $pb.ProtobufEnum {
  static const LogLevel INFO = LogLevel._(0, _omitEnumNames ? '' : 'INFO');
  static const LogLevel WARNING =
      LogLevel._(1, _omitEnumNames ? '' : 'WARNING');
  static const LogLevel ERROR = LogLevel._(2, _omitEnumNames ? '' : 'ERROR');

  static const $core.List<LogLevel> values = <LogLevel>[
    INFO,
    WARNING,
    ERROR,
  ];

  static final $core.List<LogLevel?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static LogLevel? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const LogLevel._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
