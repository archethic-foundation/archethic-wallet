// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RPCFailure {
  int get code => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCFailureCopyWith<RPCFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCFailureCopyWith<$Res> {
  factory $RPCFailureCopyWith(
          RPCFailure value, $Res Function(RPCFailure) then) =
      _$RPCFailureCopyWithImpl<$Res, RPCFailure>;
  @useResult
  $Res call({int code, String? message, Map<String, dynamic>? data});
}

/// @nodoc
class _$RPCFailureCopyWithImpl<$Res, $Val extends RPCFailure>
    implements $RPCFailureCopyWith<$Res> {
  _$RPCFailureCopyWithImpl(this._value, this._then);

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
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RPCFailureCopyWith<$Res>
    implements $RPCFailureCopyWith<$Res> {
  factory _$$_RPCFailureCopyWith(
          _$_RPCFailure value, $Res Function(_$_RPCFailure) then) =
      __$$_RPCFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String? message, Map<String, dynamic>? data});
}

/// @nodoc
class __$$_RPCFailureCopyWithImpl<$Res>
    extends _$RPCFailureCopyWithImpl<$Res, _$_RPCFailure>
    implements _$$_RPCFailureCopyWith<$Res> {
  __$$_RPCFailureCopyWithImpl(
      _$_RPCFailure _value, $Res Function(_$_RPCFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$_RPCFailure(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$_RPCFailure extends _RPCFailure {
  const _$_RPCFailure(
      {required this.code, this.message, final Map<String, dynamic>? data})
      : _data = data,
        super._();

  @override
  final int code;
  @override
  final String? message;
  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'RPCFailure(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCFailure &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, code, message, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCFailureCopyWith<_$_RPCFailure> get copyWith =>
      __$$_RPCFailureCopyWithImpl<_$_RPCFailure>(this, _$identity);
}

abstract class _RPCFailure extends RPCFailure {
  const factory _RPCFailure(
      {required final int code,
      final String? message,
      final Map<String, dynamic>? data}) = _$_RPCFailure;
  const _RPCFailure._() : super._();

  @override
  int get code;
  @override
  String? get message;
  @override
  Map<String, dynamic>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_RPCFailureCopyWith<_$_RPCFailure> get copyWith =>
      throw _privateConstructorUsedError;
}
