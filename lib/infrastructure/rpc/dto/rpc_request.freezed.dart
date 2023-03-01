// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rpc_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RpcRequestOrigin _$RpcRequestOriginFromJson(Map<String, dynamic> json) {
  return _RpcRequestOrigin.fromJson(json);
}

/// @nodoc
mixin _$RpcRequestOrigin {
  String get name => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get logo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RpcRequestOriginCopyWith<RpcRequestOrigin> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RpcRequestOriginCopyWith<$Res> {
  factory $RpcRequestOriginCopyWith(
          RpcRequestOrigin value, $Res Function(RpcRequestOrigin) then) =
      _$RpcRequestOriginCopyWithImpl<$Res, RpcRequestOrigin>;
  @useResult
  $Res call({String name, String? url, String? logo});
}

/// @nodoc
class _$RpcRequestOriginCopyWithImpl<$Res, $Val extends RpcRequestOrigin>
    implements $RpcRequestOriginCopyWith<$Res> {
  _$RpcRequestOriginCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = freezed,
    Object? logo = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RpcRequestOriginCopyWith<$Res>
    implements $RpcRequestOriginCopyWith<$Res> {
  factory _$$_RpcRequestOriginCopyWith(
          _$_RpcRequestOrigin value, $Res Function(_$_RpcRequestOrigin) then) =
      __$$_RpcRequestOriginCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? url, String? logo});
}

/// @nodoc
class __$$_RpcRequestOriginCopyWithImpl<$Res>
    extends _$RpcRequestOriginCopyWithImpl<$Res, _$_RpcRequestOrigin>
    implements _$$_RpcRequestOriginCopyWith<$Res> {
  __$$_RpcRequestOriginCopyWithImpl(
      _$_RpcRequestOrigin _value, $Res Function(_$_RpcRequestOrigin) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = freezed,
    Object? logo = freezed,
  }) {
    return _then(_$_RpcRequestOrigin(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RpcRequestOrigin extends _RpcRequestOrigin {
  const _$_RpcRequestOrigin({required this.name, this.url, this.logo})
      : super._();

  factory _$_RpcRequestOrigin.fromJson(Map<String, dynamic> json) =>
      _$$_RpcRequestOriginFromJson(json);

  @override
  final String name;
  @override
  final String? url;
  @override
  final String? logo;

  @override
  String toString() {
    return 'RpcRequestOrigin(name: $name, url: $url, logo: $logo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RpcRequestOrigin &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.logo, logo) || other.logo == logo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, url, logo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RpcRequestOriginCopyWith<_$_RpcRequestOrigin> get copyWith =>
      __$$_RpcRequestOriginCopyWithImpl<_$_RpcRequestOrigin>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RpcRequestOriginToJson(
      this,
    );
  }
}

abstract class _RpcRequestOrigin extends RpcRequestOrigin {
  const factory _RpcRequestOrigin(
      {required final String name,
      final String? url,
      final String? logo}) = _$_RpcRequestOrigin;
  const _RpcRequestOrigin._() : super._();

  factory _RpcRequestOrigin.fromJson(Map<String, dynamic> json) =
      _$_RpcRequestOrigin.fromJson;

  @override
  String get name;
  @override
  String? get url;
  @override
  String? get logo;
  @override
  @JsonKey(ignore: true)
  _$$_RpcRequestOriginCopyWith<_$_RpcRequestOrigin> get copyWith =>
      throw _privateConstructorUsedError;
}

RpcRequest _$RpcRequestFromJson(Map<String, dynamic> json) {
  return _RpcRequest.fromJson(json);
}

/// @nodoc
mixin _$RpcRequest {
  RpcRequestOrigin get origin => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError; // Rpc protocol version
  Map<String, dynamic> get payload => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RpcRequestCopyWith<RpcRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RpcRequestCopyWith<$Res> {
  factory $RpcRequestCopyWith(
          RpcRequest value, $Res Function(RpcRequest) then) =
      _$RpcRequestCopyWithImpl<$Res, RpcRequest>;
  @useResult
  $Res call(
      {RpcRequestOrigin origin, int version, Map<String, dynamic> payload});

  $RpcRequestOriginCopyWith<$Res> get origin;
}

/// @nodoc
class _$RpcRequestCopyWithImpl<$Res, $Val extends RpcRequest>
    implements $RpcRequestCopyWith<$Res> {
  _$RpcRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? version = null,
    Object? payload = null,
  }) {
    return _then(_value.copyWith(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as RpcRequestOrigin,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RpcRequestOriginCopyWith<$Res> get origin {
    return $RpcRequestOriginCopyWith<$Res>(_value.origin, (value) {
      return _then(_value.copyWith(origin: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RpcRequestCopyWith<$Res>
    implements $RpcRequestCopyWith<$Res> {
  factory _$$_RpcRequestCopyWith(
          _$_RpcRequest value, $Res Function(_$_RpcRequest) then) =
      __$$_RpcRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RpcRequestOrigin origin, int version, Map<String, dynamic> payload});

  @override
  $RpcRequestOriginCopyWith<$Res> get origin;
}

/// @nodoc
class __$$_RpcRequestCopyWithImpl<$Res>
    extends _$RpcRequestCopyWithImpl<$Res, _$_RpcRequest>
    implements _$$_RpcRequestCopyWith<$Res> {
  __$$_RpcRequestCopyWithImpl(
      _$_RpcRequest _value, $Res Function(_$_RpcRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? version = null,
    Object? payload = null,
  }) {
    return _then(_$_RpcRequest(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as RpcRequestOrigin,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      payload: null == payload
          ? _value._payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RpcRequest extends _RpcRequest {
  const _$_RpcRequest(
      {required this.origin,
      required this.version,
      required final Map<String, dynamic> payload})
      : _payload = payload,
        super._();

  factory _$_RpcRequest.fromJson(Map<String, dynamic> json) =>
      _$$_RpcRequestFromJson(json);

  @override
  final RpcRequestOrigin origin;
  @override
  final int version;
// Rpc protocol version
  final Map<String, dynamic> _payload;
// Rpc protocol version
  @override
  Map<String, dynamic> get payload {
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_payload);
  }

  @override
  String toString() {
    return 'RpcRequest(origin: $origin, version: $version, payload: $payload)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RpcRequest &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.version, version) || other.version == version) &&
            const DeepCollectionEquality().equals(other._payload, _payload));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, origin, version,
      const DeepCollectionEquality().hash(_payload));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RpcRequestCopyWith<_$_RpcRequest> get copyWith =>
      __$$_RpcRequestCopyWithImpl<_$_RpcRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RpcRequestToJson(
      this,
    );
  }
}

abstract class _RpcRequest extends RpcRequest {
  const factory _RpcRequest(
      {required final RpcRequestOrigin origin,
      required final int version,
      required final Map<String, dynamic> payload}) = _$_RpcRequest;
  const _RpcRequest._() : super._();

  factory _RpcRequest.fromJson(Map<String, dynamic> json) =
      _$_RpcRequest.fromJson;

  @override
  RpcRequestOrigin get origin;
  @override
  int get version;
  @override // Rpc protocol version
  Map<String, dynamic> get payload;
  @override
  @JsonKey(ignore: true)
  _$$_RpcRequestCopyWith<_$_RpcRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
