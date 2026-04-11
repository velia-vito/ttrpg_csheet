// This is a generated file - do not edit.
//
// Generated from data/dice.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class DiceSet extends $pb.GeneratedMessage {
  factory DiceSet({
    $core.int? count,
    $core.int? sides,
  }) {
    final result = create();
    if (count != null) result.count = count;
    if (sides != null) result.sides = sides;
    return result;
  }

  DiceSet._();

  factory DiceSet.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DiceSet.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DiceSet',
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'count')
    ..aI(2, _omitFieldNames ? '' : 'sides')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DiceSet clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DiceSet copyWith(void Function(DiceSet) updates) =>
      super.copyWith((message) => updates(message as DiceSet)) as DiceSet;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DiceSet create() => DiceSet._();
  @$core.override
  DiceSet createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DiceSet getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DiceSet>(create);
  static DiceSet? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get count => $_getIZ(0);
  @$pb.TagNumber(1)
  set count($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearCount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get sides => $_getIZ(1);
  @$pb.TagNumber(2)
  set sides($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSides() => $_has(1);
  @$pb.TagNumber(2)
  void clearSides() => $_clearField(2);
}

class DiceDefinition extends $pb.GeneratedMessage {
  factory DiceDefinition({
    $core.Iterable<DiceSet>? diceSets,
  }) {
    final result = create();
    if (diceSets != null) result.diceSets.addAll(diceSets);
    return result;
  }

  DiceDefinition._();

  factory DiceDefinition.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DiceDefinition.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DiceDefinition',
      createEmptyInstance: create)
    ..pPM<DiceSet>(1, _omitFieldNames ? '' : 'diceSets',
        subBuilder: DiceSet.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DiceDefinition clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DiceDefinition copyWith(void Function(DiceDefinition) updates) =>
      super.copyWith((message) => updates(message as DiceDefinition))
          as DiceDefinition;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DiceDefinition create() => DiceDefinition._();
  @$core.override
  DiceDefinition createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DiceDefinition getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DiceDefinition>(create);
  static DiceDefinition? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<DiceSet> get diceSets => $_getList(0);
}

class RollResult extends $pb.GeneratedMessage {
  factory RollResult({
    $core.Iterable<$core.int>? individualRolls,
  }) {
    final result = create();
    if (individualRolls != null) result.individualRolls.addAll(individualRolls);
    return result;
  }

  RollResult._();

  factory RollResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RollResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RollResult',
      createEmptyInstance: create)
    ..p<$core.int>(
        1, _omitFieldNames ? '' : 'individualRolls', $pb.PbFieldType.K3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RollResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RollResult copyWith(void Function(RollResult) updates) =>
      super.copyWith((message) => updates(message as RollResult)) as RollResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RollResult create() => RollResult._();
  @$core.override
  RollResult createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RollResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RollResult>(create);
  static RollResult? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.int> get individualRolls => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
