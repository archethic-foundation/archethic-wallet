// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ContactDetailsRouteParams _$ContactDetailsRouteParamsFromJson(
    Map<String, dynamic> json) {
  return _ContactDetailsRouteParams.fromJson(json);
}

/// @nodoc
mixin _$ContactDetailsRouteParams {
  String get contactAddress => throw _privateConstructorUsedError;
  bool? get readOnly => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContactDetailsRouteParamsCopyWith<ContactDetailsRouteParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactDetailsRouteParamsCopyWith<$Res> {
  factory $ContactDetailsRouteParamsCopyWith(ContactDetailsRouteParams value,
          $Res Function(ContactDetailsRouteParams) then) =
      _$ContactDetailsRouteParamsCopyWithImpl<$Res, ContactDetailsRouteParams>;
  @useResult
  $Res call({String contactAddress, bool? readOnly});
}

/// @nodoc
class _$ContactDetailsRouteParamsCopyWithImpl<$Res,
        $Val extends ContactDetailsRouteParams>
    implements $ContactDetailsRouteParamsCopyWith<$Res> {
  _$ContactDetailsRouteParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contactAddress = null,
    Object? readOnly = freezed,
  }) {
    return _then(_value.copyWith(
      contactAddress: null == contactAddress
          ? _value.contactAddress
          : contactAddress // ignore: cast_nullable_to_non_nullable
              as String,
      readOnly: freezed == readOnly
          ? _value.readOnly
          : readOnly // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContactDetailsRouteParamsImplCopyWith<$Res>
    implements $ContactDetailsRouteParamsCopyWith<$Res> {
  factory _$$ContactDetailsRouteParamsImplCopyWith(
          _$ContactDetailsRouteParamsImpl value,
          $Res Function(_$ContactDetailsRouteParamsImpl) then) =
      __$$ContactDetailsRouteParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String contactAddress, bool? readOnly});
}

/// @nodoc
class __$$ContactDetailsRouteParamsImplCopyWithImpl<$Res>
    extends _$ContactDetailsRouteParamsCopyWithImpl<$Res,
        _$ContactDetailsRouteParamsImpl>
    implements _$$ContactDetailsRouteParamsImplCopyWith<$Res> {
  __$$ContactDetailsRouteParamsImplCopyWithImpl(
      _$ContactDetailsRouteParamsImpl _value,
      $Res Function(_$ContactDetailsRouteParamsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contactAddress = null,
    Object? readOnly = freezed,
  }) {
    return _then(_$ContactDetailsRouteParamsImpl(
      contactAddress: null == contactAddress
          ? _value.contactAddress
          : contactAddress // ignore: cast_nullable_to_non_nullable
              as String,
      readOnly: freezed == readOnly
          ? _value.readOnly
          : readOnly // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContactDetailsRouteParamsImpl extends _ContactDetailsRouteParams {
  const _$ContactDetailsRouteParamsImpl(
      {required this.contactAddress, this.readOnly})
      : super._();

  factory _$ContactDetailsRouteParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContactDetailsRouteParamsImplFromJson(json);

  @override
  final String contactAddress;
  @override
  final bool? readOnly;

  @override
  String toString() {
    return 'ContactDetailsRouteParams(contactAddress: $contactAddress, readOnly: $readOnly)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactDetailsRouteParamsImpl &&
            (identical(other.contactAddress, contactAddress) ||
                other.contactAddress == contactAddress) &&
            (identical(other.readOnly, readOnly) ||
                other.readOnly == readOnly));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, contactAddress, readOnly);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactDetailsRouteParamsImplCopyWith<_$ContactDetailsRouteParamsImpl>
      get copyWith => __$$ContactDetailsRouteParamsImplCopyWithImpl<
          _$ContactDetailsRouteParamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContactDetailsRouteParamsImplToJson(
      this,
    );
  }
}

abstract class _ContactDetailsRouteParams extends ContactDetailsRouteParams {
  const factory _ContactDetailsRouteParams(
      {required final String contactAddress,
      final bool? readOnly}) = _$ContactDetailsRouteParamsImpl;
  const _ContactDetailsRouteParams._() : super._();

  factory _ContactDetailsRouteParams.fromJson(Map<String, dynamic> json) =
      _$ContactDetailsRouteParamsImpl.fromJson;

  @override
  String get contactAddress;
  @override
  bool? get readOnly;
  @override
  @JsonKey(ignore: true)
  _$$ContactDetailsRouteParamsImplCopyWith<_$ContactDetailsRouteParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
