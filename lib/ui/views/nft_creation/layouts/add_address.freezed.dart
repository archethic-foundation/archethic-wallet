// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_address.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddAddressParams _$AddAddressParamsFromJson(Map<String, dynamic> json) {
  return _AddAddressParams.fromJson(json);
}

/// @nodoc
mixin _$AddAddressParams {
  String get propertyName => throw _privateConstructorUsedError;
  String get propertyValue => throw _privateConstructorUsedError;
  bool get readOnly => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddAddressParamsCopyWith<AddAddressParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddAddressParamsCopyWith<$Res> {
  factory $AddAddressParamsCopyWith(
          AddAddressParams value, $Res Function(AddAddressParams) then) =
      _$AddAddressParamsCopyWithImpl<$Res, AddAddressParams>;
  @useResult
  $Res call({String propertyName, String propertyValue, bool readOnly});
}

/// @nodoc
class _$AddAddressParamsCopyWithImpl<$Res, $Val extends AddAddressParams>
    implements $AddAddressParamsCopyWith<$Res> {
  _$AddAddressParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? propertyName = null,
    Object? propertyValue = null,
    Object? readOnly = null,
  }) {
    return _then(_value.copyWith(
      propertyName: null == propertyName
          ? _value.propertyName
          : propertyName // ignore: cast_nullable_to_non_nullable
              as String,
      propertyValue: null == propertyValue
          ? _value.propertyValue
          : propertyValue // ignore: cast_nullable_to_non_nullable
              as String,
      readOnly: null == readOnly
          ? _value.readOnly
          : readOnly // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddAddressParamsImplCopyWith<$Res>
    implements $AddAddressParamsCopyWith<$Res> {
  factory _$$AddAddressParamsImplCopyWith(_$AddAddressParamsImpl value,
          $Res Function(_$AddAddressParamsImpl) then) =
      __$$AddAddressParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String propertyName, String propertyValue, bool readOnly});
}

/// @nodoc
class __$$AddAddressParamsImplCopyWithImpl<$Res>
    extends _$AddAddressParamsCopyWithImpl<$Res, _$AddAddressParamsImpl>
    implements _$$AddAddressParamsImplCopyWith<$Res> {
  __$$AddAddressParamsImplCopyWithImpl(_$AddAddressParamsImpl _value,
      $Res Function(_$AddAddressParamsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? propertyName = null,
    Object? propertyValue = null,
    Object? readOnly = null,
  }) {
    return _then(_$AddAddressParamsImpl(
      propertyName: null == propertyName
          ? _value.propertyName
          : propertyName // ignore: cast_nullable_to_non_nullable
              as String,
      propertyValue: null == propertyValue
          ? _value.propertyValue
          : propertyValue // ignore: cast_nullable_to_non_nullable
              as String,
      readOnly: null == readOnly
          ? _value.readOnly
          : readOnly // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddAddressParamsImpl extends _AddAddressParams {
  const _$AddAddressParamsImpl(
      {required this.propertyName,
      required this.propertyValue,
      required this.readOnly})
      : super._();

  factory _$AddAddressParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddAddressParamsImplFromJson(json);

  @override
  final String propertyName;
  @override
  final String propertyValue;
  @override
  final bool readOnly;

  @override
  String toString() {
    return 'AddAddressParams(propertyName: $propertyName, propertyValue: $propertyValue, readOnly: $readOnly)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddAddressParamsImpl &&
            (identical(other.propertyName, propertyName) ||
                other.propertyName == propertyName) &&
            (identical(other.propertyValue, propertyValue) ||
                other.propertyValue == propertyValue) &&
            (identical(other.readOnly, readOnly) ||
                other.readOnly == readOnly));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, propertyName, propertyValue, readOnly);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddAddressParamsImplCopyWith<_$AddAddressParamsImpl> get copyWith =>
      __$$AddAddressParamsImplCopyWithImpl<_$AddAddressParamsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddAddressParamsImplToJson(
      this,
    );
  }
}

abstract class _AddAddressParams extends AddAddressParams {
  const factory _AddAddressParams(
      {required final String propertyName,
      required final String propertyValue,
      required final bool readOnly}) = _$AddAddressParamsImpl;
  const _AddAddressParams._() : super._();

  factory _AddAddressParams.fromJson(Map<String, dynamic> json) =
      _$AddAddressParamsImpl.fromJson;

  @override
  String get propertyName;
  @override
  String get propertyValue;
  @override
  bool get readOnly;
  @override
  @JsonKey(ignore: true)
  _$$AddAddressParamsImplCopyWith<_$AddAddressParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
