// This is a generated file - do not edit.
//
// Generated from data/dice.proto.

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

@$core.Deprecated('Use diceSetDescriptor instead')
const DiceSet$json = {
  '1': 'DiceSet',
  '2': [
    {'1': 'count', '3': 1, '4': 1, '5': 5, '10': 'count'},
    {'1': 'sides', '3': 2, '4': 1, '5': 5, '10': 'sides'},
  ],
};

/// Descriptor for `DiceSet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List diceSetDescriptor = $convert.base64Decode(
    'CgdEaWNlU2V0EhQKBWNvdW50GAEgASgFUgVjb3VudBIUCgVzaWRlcxgCIAEoBVIFc2lkZXM=');

@$core.Deprecated('Use diceDefinitionDescriptor instead')
const DiceDefinition$json = {
  '1': 'DiceDefinition',
  '2': [
    {
      '1': 'dice_sets',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.DiceSet',
      '10': 'diceSets'
    },
  ],
};

/// Descriptor for `DiceDefinition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List diceDefinitionDescriptor = $convert.base64Decode(
    'Cg5EaWNlRGVmaW5pdGlvbhIlCglkaWNlX3NldHMYASADKAsyCC5EaWNlU2V0UghkaWNlU2V0cw'
    '==');

@$core.Deprecated('Use rollResultDescriptor instead')
const RollResult$json = {
  '1': 'RollResult',
  '2': [
    {'1': 'individual_rolls', '3': 1, '4': 3, '5': 5, '10': 'individualRolls'},
  ],
};

/// Descriptor for `RollResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rollResultDescriptor = $convert.base64Decode(
    'CgpSb2xsUmVzdWx0EikKEGluZGl2aWR1YWxfcm9sbHMYASADKAVSD2luZGl2aWR1YWxSb2xscw'
    '==');
