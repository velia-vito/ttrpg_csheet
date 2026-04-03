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

/// Enumeration of available services.
class Services extends $pb.ProtobufEnum {
  static const Services UNSPECIFIED_SERVICE =
      Services._(0, _omitEnumNames ? '' : 'UNSPECIFIED_SERVICE');
  static const Services SHEET_SERVICE =
      Services._(1, _omitEnumNames ? '' : 'SHEET_SERVICE');
  static const Services MESSAGE_SERVICE =
      Services._(2, _omitEnumNames ? '' : 'MESSAGE_SERVICE');

  static const $core.List<Services> values = <Services>[
    UNSPECIFIED_SERVICE,
    SHEET_SERVICE,
    MESSAGE_SERVICE,
  ];

  static final $core.List<Services?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static Services? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Services._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
