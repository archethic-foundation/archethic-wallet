// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RPCRequest _$RPCRequestFromJson(Map<String, dynamic> json) {
  return _RPCRequest.fromJson(json);
}

/// @nodoc
mixin _$RPCRequest {
  String get method => throw _privateConstructorUsedError;
  Map<String, dynamic> get jsonParams => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RPCRequestCopyWith<RPCRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCRequestCopyWith<$Res> {
  factory $RPCRequestCopyWith(
          RPCRequest value, $Res Function(RPCRequest) then) =
      _$RPCRequestCopyWithImpl<$Res, RPCRequest>;
  @useResult
  $Res call({String method, Map<String, dynamic> jsonParams});
}

/// @nodoc
class _$RPCRequestCopyWithImpl<$Res, $Val extends RPCRequest>
    implements $RPCRequestCopyWith<$Res> {
  _$RPCRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? jsonParams = null,
  }) {
    return _then(_value.copyWith(
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      jsonParams: null == jsonParams
          ? _value.jsonParams
          : jsonParams // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RPCRequestCopyWith<$Res>
    implements $RPCRequestCopyWith<$Res> {
  factory _$$_RPCRequestCopyWith(
          _$_RPCRequest value, $Res Function(_$_RPCRequest) then) =
      __$$_RPCRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String method, Map<String, dynamic> jsonParams});
}

/// @nodoc
class __$$_RPCRequestCopyWithImpl<$Res>
    extends _$RPCRequestCopyWithImpl<$Res, _$_RPCRequest>
    implements _$$_RPCRequestCopyWith<$Res> {
  __$$_RPCRequestCopyWithImpl(
      _$_RPCRequest _value, $Res Function(_$_RPCRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? jsonParams = null,
  }) {
    return _then(_$_RPCRequest(
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      jsonParams: null == jsonParams
          ? _value._jsonParams
          : jsonParams // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RPCRequest extends _RPCRequest {
  const _$_RPCRequest(
      {required this.method, required final Map<String, dynamic> jsonParams})
      : _jsonParams = jsonParams,
        super._();

  factory _$_RPCRequest.fromJson(Map<String, dynamic> json) =>
      _$$_RPCRequestFromJson(json);

  @override
  final String method;
  final Map<String, dynamic> _jsonParams;
  @override
  Map<String, dynamic> get jsonParams {
    if (_jsonParams is EqualUnmodifiableMapView) return _jsonParams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_jsonParams);
  }

  @override
  String toString() {
    return 'RPCRequest(method: $method, jsonParams: $jsonParams)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCRequest &&
            (identical(other.method, method) || other.method == method) &&
            const DeepCollectionEquality()
                .equals(other._jsonParams, _jsonParams));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, method, const DeepCollectionEquality().hash(_jsonParams));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCRequestCopyWith<_$_RPCRequest> get copyWith =>
      __$$_RPCRequestCopyWithImpl<_$_RPCRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RPCRequestToJson(
      this,
    );
  }
}

abstract class _RPCRequest extends RPCRequest {
  const factory _RPCRequest(
      {required final String method,
      required final Map<String, dynamic> jsonParams}) = _$_RPCRequest;
  const _RPCRequest._() : super._();

  factory _RPCRequest.fromJson(Map<String, dynamic> json) =
      _$_RPCRequest.fromJson;

  @override
  String get method;
  @override
  Map<String, dynamic> get jsonParams;
  @override
  @JsonKey(ignore: true)
  _$$_RPCRequestCopyWith<_$_RPCRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
