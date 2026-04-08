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

class ApprovedAs extends $pb.ProtobufEnum {
  static const ApprovedAs APPROVED_AS_UNAPPROVED =
      ApprovedAs._(0, _omitEnumNames ? '' : 'APPROVED_AS_UNAPPROVED');
  static const ApprovedAs APPROVED_AS_PLAYER =
      ApprovedAs._(1, _omitEnumNames ? '' : 'APPROVED_AS_PLAYER');
  static const ApprovedAs APPROVED_AS_DM =
      ApprovedAs._(2, _omitEnumNames ? '' : 'APPROVED_AS_DM');

  static const $core.List<ApprovedAs> values = <ApprovedAs>[
    APPROVED_AS_UNAPPROVED,
    APPROVED_AS_PLAYER,
    APPROVED_AS_DM,
  ];

  static final $core.List<ApprovedAs?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static ApprovedAs? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ApprovedAs._(super.value, super.name);
}

/// Enumeration of available services.
class Services extends $pb.ProtobufEnum {
  static const Services UNKNOWN_SERVICE =
      Services._(0, _omitEnumNames ? '' : 'UNKNOWN_SERVICE');
  static const Services STAT_SERVICE =
      Services._(1, _omitEnumNames ? '' : 'STAT_SERVICE');
  static const Services MESSAGE_SERVICE =
      Services._(2, _omitEnumNames ? '' : 'MESSAGE_SERVICE');

  static const $core.List<Services> values = <Services>[
    UNKNOWN_SERVICE,
    STAT_SERVICE,
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
