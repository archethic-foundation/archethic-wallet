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

RpcRequestOriginDTO _$RpcRequestOriginDTOFromJson(Map<String, dynamic> json) {
  return _RpcRequestOrigin.fromJson(json);
}

/// @nodoc
mixin _$RpcRequestOriginDTO {
  String get name => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get logo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RpcRequestOriginDTOCopyWith<RpcRequestOriginDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RpcRequestOriginDTOCopyWith<$Res> {
  factory $RpcRequestOriginDTOCopyWith(
          RpcRequestOriginDTO value, $Res Function(RpcRequestOriginDTO) then) =
      _$RpcRequestOriginDTOCopyWithImpl<$Res, RpcRequestOriginDTO>;
  @useResult
  $Res call({String name, String? url, String? logo});
}

/// @nodoc
class _$RpcRequestOriginDTOCopyWithImpl<$Res, $Val extends RpcRequestOriginDTO>
    implements $RpcRequestOriginDTOCopyWith<$Res> {
  _$RpcRequestOriginDTOCopyWithImpl(this._value, this._then);

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
abstract class _$$RpcRequestOriginImplCopyWith<$Res>
    implements $RpcRequestOriginDTOCopyWith<$Res> {
  factory _$$RpcRequestOriginImplCopyWith(_$RpcRequestOriginImpl value,
          $Res Function(_$RpcRequestOriginImpl) then) =
      __$$RpcRequestOriginImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? url, String? logo});
}

/// @nodoc
class __$$RpcRequestOriginImplCopyWithImpl<$Res>
    extends _$RpcRequestOriginDTOCopyWithImpl<$Res, _$RpcRequestOriginImpl>
    implements _$$RpcRequestOriginImplCopyWith<$Res> {
  __$$RpcRequestOriginImplCopyWithImpl(_$RpcRequestOriginImpl _value,
      $Res Function(_$RpcRequestOriginImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = freezed,
    Object? logo = freezed,
  }) {
    return _then(_$RpcRequestOriginImpl(
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
class _$RpcRequestOriginImpl extends _RpcRequestOrigin {
  const _$RpcRequestOriginImpl({required this.name, this.url, this.logo})
      : super._();

  factory _$RpcRequestOriginImpl.fromJson(Map<String, dynamic> json) =>
      _$$RpcRequestOriginImplFromJson(json);

  @override
  final String name;
  @override
  final String? url;
  @override
  final String? logo;

  @override
  String toString() {
    return 'RpcRequestOriginDTO(name: $name, url: $url, logo: $logo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RpcRequestOriginImpl &&
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
  _$$RpcRequestOriginImplCopyWith<_$RpcRequestOriginImpl> get copyWith =>
      __$$RpcRequestOriginImplCopyWithImpl<_$RpcRequestOriginImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RpcRequestOriginImplToJson(
      this,
    );
  }
}

abstract class _RpcRequestOrigin extends RpcRequestOriginDTO {
  const factory _RpcRequestOrigin(
      {required final String name,
      final String? url,
      final String? logo}) = _$RpcRequestOriginImpl;
  const _RpcRequestOrigin._() : super._();

  factory _RpcRequestOrigin.fromJson(Map<String, dynamic> json) =
      _$RpcRequestOriginImpl.fromJson;

  @override
  String get name;
  @override
  String? get url;
  @override
  String? get logo;
  @override
  @JsonKey(ignore: true)
  _$$RpcRequestOriginImplCopyWith<_$RpcRequestOriginImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RPCRequestDTO _$RPCRequestDTOFromJson(Map<String, dynamic> json) {
  return _RpcRequest.fromJson(json);
}

/// @nodoc
mixin _$RPCRequestDTO {
  RpcRequestOriginDTO get origin => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError; // Rpc protocol version
  Map<String, dynamic> get payload => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RPCRequestDTOCopyWith<RPCRequestDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCRequestDTOCopyWith<$Res> {
  factory $RPCRequestDTOCopyWith(
          RPCRequestDTO value, $Res Function(RPCRequestDTO) then) =
      _$RPCRequestDTOCopyWithImpl<$Res, RPCRequestDTO>;
  @useResult
  $Res call(
      {RpcRequestOriginDTO origin, int version, Map<String, dynamic> payload});

  $RpcRequestOriginDTOCopyWith<$Res> get origin;
}

/// @nodoc
class _$RPCRequestDTOCopyWithImpl<$Res, $Val extends RPCRequestDTO>
    implements $RPCRequestDTOCopyWith<$Res> {
  _$RPCRequestDTOCopyWithImpl(this._value, this._then);

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
              as RpcRequestOriginDTO,
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
  $RpcRequestOriginDTOCopyWith<$Res> get origin {
    return $RpcRequestOriginDTOCopyWith<$Res>(_value.origin, (value) {
      return _then(_value.copyWith(origin: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RpcRequestImplCopyWith<$Res>
    implements $RPCRequestDTOCopyWith<$Res> {
  factory _$$RpcRequestImplCopyWith(
          _$RpcRequestImpl value, $Res Function(_$RpcRequestImpl) then) =
      __$$RpcRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RpcRequestOriginDTO origin, int version, Map<String, dynamic> payload});

  @override
  $RpcRequestOriginDTOCopyWith<$Res> get origin;
}

/// @nodoc
class __$$RpcRequestImplCopyWithImpl<$Res>
    extends _$RPCRequestDTOCopyWithImpl<$Res, _$RpcRequestImpl>
    implements _$$RpcRequestImplCopyWith<$Res> {
  __$$RpcRequestImplCopyWithImpl(
      _$RpcRequestImpl _value, $Res Function(_$RpcRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? version = null,
    Object? payload = null,
  }) {
    return _then(_$RpcRequestImpl(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as RpcRequestOriginDTO,
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
class _$RpcRequestImpl extends _RpcRequest {
  const _$RpcRequestImpl(
      {required this.origin,
      required this.version,
      required final Map<String, dynamic> payload})
      : _payload = payload,
        super._();

  factory _$RpcRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$RpcRequestImplFromJson(json);

  @override
  final RpcRequestOriginDTO origin;
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
    return 'RPCRequestDTO(origin: $origin, version: $version, payload: $payload)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RpcRequestImpl &&
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
  _$$RpcRequestImplCopyWith<_$RpcRequestImpl> get copyWith =>
      __$$RpcRequestImplCopyWithImpl<_$RpcRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RpcRequestImplToJson(
      this,
    );
  }
}

abstract class _RpcRequest extends RPCRequestDTO {
  const factory _RpcRequest(
      {required final RpcRequestOriginDTO origin,
      required final int version,
      required final Map<String, dynamic> payload}) = _$RpcRequestImpl;
  const _RpcRequest._() : super._();

  factory _RpcRequest.fromJson(Map<String, dynamic> json) =
      _$RpcRequestImpl.fromJson;

  @override
  RpcRequestOriginDTO get origin;
  @override
  int get version;
  @override // Rpc protocol version
  Map<String, dynamic> get payload;
  @override
  @JsonKey(ignore: true)
  _$$RpcRequestImplCopyWith<_$RpcRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
