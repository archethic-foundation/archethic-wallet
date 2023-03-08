// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_endpoint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RPCGetEndpointCommandData {}

/// @nodoc
abstract class $RPCGetEndpointCommandDataCopyWith<$Res> {
  factory $RPCGetEndpointCommandDataCopyWith(RPCGetEndpointCommandData value,
          $Res Function(RPCGetEndpointCommandData) then) =
      _$RPCGetEndpointCommandDataCopyWithImpl<$Res, RPCGetEndpointCommandData>;
}

/// @nodoc
class _$RPCGetEndpointCommandDataCopyWithImpl<$Res,
        $Val extends RPCGetEndpointCommandData>
    implements $RPCGetEndpointCommandDataCopyWith<$Res> {
  _$RPCGetEndpointCommandDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_RPCGetEndpointCommandDataCopyWith<$Res> {
  factory _$$_RPCGetEndpointCommandDataCopyWith(
          _$_RPCGetEndpointCommandData value,
          $Res Function(_$_RPCGetEndpointCommandData) then) =
      __$$_RPCGetEndpointCommandDataCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_RPCGetEndpointCommandDataCopyWithImpl<$Res>
    extends _$RPCGetEndpointCommandDataCopyWithImpl<$Res,
        _$_RPCGetEndpointCommandData>
    implements _$$_RPCGetEndpointCommandDataCopyWith<$Res> {
  __$$_RPCGetEndpointCommandDataCopyWithImpl(
      _$_RPCGetEndpointCommandData _value,
      $Res Function(_$_RPCGetEndpointCommandData) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_RPCGetEndpointCommandData extends _RPCGetEndpointCommandData {
  const _$_RPCGetEndpointCommandData() : super._();

  @override
  String toString() {
    return 'RPCGetEndpointCommandData()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCGetEndpointCommandData);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _RPCGetEndpointCommandData extends RPCGetEndpointCommandData {
  const factory _RPCGetEndpointCommandData() = _$_RPCGetEndpointCommandData;
  const _RPCGetEndpointCommandData._() : super._();
}

/// @nodoc
mixin _$RPCGetEndpointResultData {
  String get endpoint => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCGetEndpointResultDataCopyWith<RPCGetEndpointResultData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCGetEndpointResultDataCopyWith<$Res> {
  factory $RPCGetEndpointResultDataCopyWith(RPCGetEndpointResultData value,
          $Res Function(RPCGetEndpointResultData) then) =
      _$RPCGetEndpointResultDataCopyWithImpl<$Res, RPCGetEndpointResultData>;
  @useResult
  $Res call({String endpoint});
}

/// @nodoc
class _$RPCGetEndpointResultDataCopyWithImpl<$Res,
        $Val extends RPCGetEndpointResultData>
    implements $RPCGetEndpointResultDataCopyWith<$Res> {
  _$RPCGetEndpointResultDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? endpoint = null,
  }) {
    return _then(_value.copyWith(
      endpoint: null == endpoint
          ? _value.endpoint
          : endpoint // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RPCGetEndpointResultDataCopyWith<$Res>
    implements $RPCGetEndpointResultDataCopyWith<$Res> {
  factory _$$_RPCGetEndpointResultDataCopyWith(
          _$_RPCGetEndpointResultData value,
          $Res Function(_$_RPCGetEndpointResultData) then) =
      __$$_RPCGetEndpointResultDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String endpoint});
}

/// @nodoc
class __$$_RPCGetEndpointResultDataCopyWithImpl<$Res>
    extends _$RPCGetEndpointResultDataCopyWithImpl<$Res,
        _$_RPCGetEndpointResultData>
    implements _$$_RPCGetEndpointResultDataCopyWith<$Res> {
  __$$_RPCGetEndpointResultDataCopyWithImpl(_$_RPCGetEndpointResultData _value,
      $Res Function(_$_RPCGetEndpointResultData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? endpoint = null,
  }) {
    return _then(_$_RPCGetEndpointResultData(
      endpoint: null == endpoint
          ? _value.endpoint
          : endpoint // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RPCGetEndpointResultData extends _RPCGetEndpointResultData {
  const _$_RPCGetEndpointResultData({required this.endpoint}) : super._();

  @override
  final String endpoint;

  @override
  String toString() {
    return 'RPCGetEndpointResultData(endpoint: $endpoint)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCGetEndpointResultData &&
            (identical(other.endpoint, endpoint) ||
                other.endpoint == endpoint));
  }

  @override
  int get hashCode => Object.hash(runtimeType, endpoint);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCGetEndpointResultDataCopyWith<_$_RPCGetEndpointResultData>
      get copyWith => __$$_RPCGetEndpointResultDataCopyWithImpl<
          _$_RPCGetEndpointResultData>(this, _$identity);
}

abstract class _RPCGetEndpointResultData extends RPCGetEndpointResultData {
  const factory _RPCGetEndpointResultData({required final String endpoint}) =
      _$_RPCGetEndpointResultData;
  const _RPCGetEndpointResultData._() : super._();

  @override
  String get endpoint;
  @override
  @JsonKey(ignore: true)
  _$$_RPCGetEndpointResultDataCopyWith<_$_RPCGetEndpointResultData>
      get copyWith => throw _privateConstructorUsedError;
}
