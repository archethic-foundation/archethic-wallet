// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DeeplinkRpcFailure _$DeeplinkRpcFailureFromJson(Map<String, dynamic> json) {
  return _DeeplinkRpcFailure.fromJson(json);
}

/// @nodoc
mixin _$DeeplinkRpcFailure {
  int get code => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeeplinkRpcFailureCopyWith<DeeplinkRpcFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeeplinkRpcFailureCopyWith<$Res> {
  factory $DeeplinkRpcFailureCopyWith(
          DeeplinkRpcFailure value, $Res Function(DeeplinkRpcFailure) then) =
      _$DeeplinkRpcFailureCopyWithImpl<$Res, DeeplinkRpcFailure>;
  @useResult
  $Res call({int code, String? message, dynamic data});
}

/// @nodoc
class _$DeeplinkRpcFailureCopyWithImpl<$Res, $Val extends DeeplinkRpcFailure>
    implements $DeeplinkRpcFailureCopyWith<$Res> {
  _$DeeplinkRpcFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DeeplinkRpcFailureCopyWith<$Res>
    implements $DeeplinkRpcFailureCopyWith<$Res> {
  factory _$$_DeeplinkRpcFailureCopyWith(_$_DeeplinkRpcFailure value,
          $Res Function(_$_DeeplinkRpcFailure) then) =
      __$$_DeeplinkRpcFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String? message, dynamic data});
}

/// @nodoc
class __$$_DeeplinkRpcFailureCopyWithImpl<$Res>
    extends _$DeeplinkRpcFailureCopyWithImpl<$Res, _$_DeeplinkRpcFailure>
    implements _$$_DeeplinkRpcFailureCopyWith<$Res> {
  __$$_DeeplinkRpcFailureCopyWithImpl(
      _$_DeeplinkRpcFailure _value, $Res Function(_$_DeeplinkRpcFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$_DeeplinkRpcFailure(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DeeplinkRpcFailure extends _DeeplinkRpcFailure {
  const _$_DeeplinkRpcFailure({required this.code, this.message, this.data})
      : super._();

  factory _$_DeeplinkRpcFailure.fromJson(Map<String, dynamic> json) =>
      _$$_DeeplinkRpcFailureFromJson(json);

  @override
  final int code;
  @override
  final String? message;
  @override
  final dynamic data;

  @override
  String toString() {
    return 'DeeplinkRpcFailure(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeeplinkRpcFailure &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, code, message, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeeplinkRpcFailureCopyWith<_$_DeeplinkRpcFailure> get copyWith =>
      __$$_DeeplinkRpcFailureCopyWithImpl<_$_DeeplinkRpcFailure>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DeeplinkRpcFailureToJson(
      this,
    );
  }
}

abstract class _DeeplinkRpcFailure extends DeeplinkRpcFailure {
  const factory _DeeplinkRpcFailure(
      {required final int code,
      final String? message,
      final dynamic data}) = _$_DeeplinkRpcFailure;
  const _DeeplinkRpcFailure._() : super._();

  factory _DeeplinkRpcFailure.fromJson(Map<String, dynamic> json) =
      _$_DeeplinkRpcFailure.fromJson;

  @override
  int get code;
  @override
  String? get message;
  @override
  dynamic get data;
  @override
  @JsonKey(ignore: true)
  _$$_DeeplinkRpcFailureCopyWith<_$_DeeplinkRpcFailure> get copyWith =>
      throw _privateConstructorUsedError;
}
