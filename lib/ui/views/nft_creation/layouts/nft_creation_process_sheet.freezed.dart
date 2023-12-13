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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NftCreationSheetParams _$NftCreationSheetParamsFromJson(
    Map<String, dynamic> json) {
  return _NftCreationSheetParams.fromJson(json);
}

/// @nodoc
mixin _$NftCreationSheetParams {
  int get currentNftCategoryIndex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NftCreationSheetParamsCopyWith<NftCreationSheetParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NftCreationSheetParamsCopyWith<$Res> {
  factory $NftCreationSheetParamsCopyWith(NftCreationSheetParams value,
          $Res Function(NftCreationSheetParams) then) =
      _$NftCreationSheetParamsCopyWithImpl<$Res, NftCreationSheetParams>;
  @useResult
  $Res call({int currentNftCategoryIndex});
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentNftCategoryIndex = null,
  }) {
    return _then(_value.copyWith(
      currentNftCategoryIndex: null == currentNftCategoryIndex
          ? _value.currentNftCategoryIndex
          : currentNftCategoryIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NftCreationSheetParamsImplCopyWith<$Res>
    implements $NftCreationSheetParamsCopyWith<$Res> {
  factory _$$NftCreationSheetParamsImplCopyWith(
          _$NftCreationSheetParamsImpl value,
          $Res Function(_$NftCreationSheetParamsImpl) then) =
      __$$NftCreationSheetParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int currentNftCategoryIndex});
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentNftCategoryIndex = null,
  }) {
    return _then(_$NftCreationSheetParamsImpl(
      currentNftCategoryIndex: null == currentNftCategoryIndex
          ? _value.currentNftCategoryIndex
          : currentNftCategoryIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NftCreationSheetParamsImpl extends _NftCreationSheetParams
    with DiagnosticableTreeMixin {
  const _$NftCreationSheetParamsImpl({required this.currentNftCategoryIndex})
      : super._();

  factory _$NftCreationSheetParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NftCreationSheetParamsImplFromJson(json);

  @override
  final int currentNftCategoryIndex;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NftCreationSheetParams(currentNftCategoryIndex: $currentNftCategoryIndex)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NftCreationSheetParams'))
      ..add(DiagnosticsProperty(
          'currentNftCategoryIndex', currentNftCategoryIndex));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NftCreationSheetParamsImpl &&
            (identical(
                    other.currentNftCategoryIndex, currentNftCategoryIndex) ||
                other.currentNftCategoryIndex == currentNftCategoryIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, currentNftCategoryIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NftCreationSheetParamsImplCopyWith<_$NftCreationSheetParamsImpl>
      get copyWith => __$$NftCreationSheetParamsImplCopyWithImpl<
          _$NftCreationSheetParamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NftCreationSheetParamsImplToJson(
      this,
    );
  }
}

abstract class _NftCreationSheetParams extends NftCreationSheetParams {
  const factory _NftCreationSheetParams(
          {required final int currentNftCategoryIndex}) =
      _$NftCreationSheetParamsImpl;
  const _NftCreationSheetParams._() : super._();

  factory _NftCreationSheetParams.fromJson(Map<String, dynamic> json) =
      _$NftCreationSheetParamsImpl.fromJson;

  @override
  int get currentNftCategoryIndex;
  @override
  @JsonKey(ignore: true)
  _$$NftCreationSheetParamsImplCopyWith<_$NftCreationSheetParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
