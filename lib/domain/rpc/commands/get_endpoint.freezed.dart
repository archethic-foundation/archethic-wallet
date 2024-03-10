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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
abstract class _$$RPCGetEndpointCommandDataImplCopyWith<$Res> {
  factory _$$RPCGetEndpointCommandDataImplCopyWith(
          _$RPCGetEndpointCommandDataImpl value,
          $Res Function(_$RPCGetEndpointCommandDataImpl) then) =
      __$$RPCGetEndpointCommandDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RPCGetEndpointCommandDataImplCopyWithImpl<$Res>
    extends _$RPCGetEndpointCommandDataCopyWithImpl<$Res,
        _$RPCGetEndpointCommandDataImpl>
    implements _$$RPCGetEndpointCommandDataImplCopyWith<$Res> {
  __$$RPCGetEndpointCommandDataImplCopyWithImpl(
      _$RPCGetEndpointCommandDataImpl _value,
      $Res Function(_$RPCGetEndpointCommandDataImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RPCGetEndpointCommandDataImpl extends _RPCGetEndpointCommandData {
  const _$RPCGetEndpointCommandDataImpl() : super._();

  @override
  String toString() {
    return 'RPCGetEndpointCommandData()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RPCGetEndpointCommandDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _RPCGetEndpointCommandData extends RPCGetEndpointCommandData {
  const factory _RPCGetEndpointCommandData() = _$RPCGetEndpointCommandDataImpl;
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
abstract class _$$RPCGetEndpointResultDataImplCopyWith<$Res>
    implements $RPCGetEndpointResultDataCopyWith<$Res> {
  factory _$$RPCGetEndpointResultDataImplCopyWith(
          _$RPCGetEndpointResultDataImpl value,
          $Res Function(_$RPCGetEndpointResultDataImpl) then) =
      __$$RPCGetEndpointResultDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String endpoint});
}

/// @nodoc
class __$$RPCGetEndpointResultDataImplCopyWithImpl<$Res>
    extends _$RPCGetEndpointResultDataCopyWithImpl<$Res,
        _$RPCGetEndpointResultDataImpl>
    implements _$$RPCGetEndpointResultDataImplCopyWith<$Res> {
  __$$RPCGetEndpointResultDataImplCopyWithImpl(
      _$RPCGetEndpointResultDataImpl _value,
      $Res Function(_$RPCGetEndpointResultDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? endpoint = null,
  }) {
    return _then(_$RPCGetEndpointResultDataImpl(
      endpoint: null == endpoint
          ? _value.endpoint
          : endpoint // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RPCGetEndpointResultDataImpl extends _RPCGetEndpointResultData {
  const _$RPCGetEndpointResultDataImpl({required this.endpoint}) : super._();

  @override
  final String endpoint;

  @override
  String toString() {
    return 'RPCGetEndpointResultData(endpoint: $endpoint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RPCGetEndpointResultDataImpl &&
            (identical(other.endpoint, endpoint) ||
                other.endpoint == endpoint));
  }

  @override
  int get hashCode => Object.hash(runtimeType, endpoint);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RPCGetEndpointResultDataImplCopyWith<_$RPCGetEndpointResultDataImpl>
      get copyWith => __$$RPCGetEndpointResultDataImplCopyWithImpl<
          _$RPCGetEndpointResultDataImpl>(this, _$identity);
}

abstract class _RPCGetEndpointResultData extends RPCGetEndpointResultData {
  const factory _RPCGetEndpointResultData({required final String endpoint}) =
      _$RPCGetEndpointResultDataImpl;
  const _RPCGetEndpointResultData._() : super._();

  @override
  String get endpoint;
  @override
  @JsonKey(ignore: true)
  _$$RPCGetEndpointResultDataImplCopyWith<_$RPCGetEndpointResultDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
