// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nft_creation_process_sheet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NftCreationSheetParams _$NftCreationSheetParamsFromJson(
    Map<String, dynamic> json) {
  return _NftCreationSheetParams.fromJson(json);
}

/// @nodoc
mixin _$NftCreationSheetParams {
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NftCreationSheetParamsCopyWith<$Res> {
  factory $NftCreationSheetParamsCopyWith(NftCreationSheetParams value,
          $Res Function(NftCreationSheetParams) then) =
      _$NftCreationSheetParamsCopyWithImpl<$Res, NftCreationSheetParams>;
}

/// @nodoc
class _$NftCreationSheetParamsCopyWithImpl<$Res,
        $Val extends NftCreationSheetParams>
    implements $NftCreationSheetParamsCopyWith<$Res> {
  _$NftCreationSheetParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$NftCreationSheetParamsImplCopyWith<$Res> {
  factory _$$NftCreationSheetParamsImplCopyWith(
          _$NftCreationSheetParamsImpl value,
          $Res Function(_$NftCreationSheetParamsImpl) then) =
      __$$NftCreationSheetParamsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NftCreationSheetParamsImplCopyWithImpl<$Res>
    extends _$NftCreationSheetParamsCopyWithImpl<$Res,
        _$NftCreationSheetParamsImpl>
    implements _$$NftCreationSheetParamsImplCopyWith<$Res> {
  __$$NftCreationSheetParamsImplCopyWithImpl(
      _$NftCreationSheetParamsImpl _value,
      $Res Function(_$NftCreationSheetParamsImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$NftCreationSheetParamsImpl extends _NftCreationSheetParams
    with DiagnosticableTreeMixin {
  const _$NftCreationSheetParamsImpl() : super._();

  factory _$NftCreationSheetParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NftCreationSheetParamsImplFromJson(json);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NftCreationSheetParams()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'NftCreationSheetParams'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NftCreationSheetParamsImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return _$$NftCreationSheetParamsImplToJson(
      this,
    );
  }
}

abstract class _NftCreationSheetParams extends NftCreationSheetParams {
  const factory _NftCreationSheetParams() = _$NftCreationSheetParamsImpl;
  const _NftCreationSheetParams._() : super._();

  factory _NftCreationSheetParams.fromJson(Map<String, dynamic> json) =
      _$NftCreationSheetParamsImpl.fromJson;
}
