// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_pool_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetPoolListResponse _$GetPoolListResponseFromJson(Map<String, dynamic> json) {
  return _GetPoolListResponse.fromJson(json);
}

/// @nodoc
mixin _$GetPoolListResponse {
  String get address =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'lp_token_address')
  String get lpTokenAddress => throw _privateConstructorUsedError;
  String get tokens => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetPoolListResponseCopyWith<GetPoolListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetPoolListResponseCopyWith<$Res> {
  factory $GetPoolListResponseCopyWith(
          GetPoolListResponse value, $Res Function(GetPoolListResponse) then) =
      _$GetPoolListResponseCopyWithImpl<$Res, GetPoolListResponse>;
  @useResult
  $Res call(
      {String address,
      @JsonKey(name: 'lp_token_address') String lpTokenAddress,
      String tokens});
}

/// @nodoc
class _$GetPoolListResponseCopyWithImpl<$Res, $Val extends GetPoolListResponse>
    implements $GetPoolListResponseCopyWith<$Res> {
  _$GetPoolListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? lpTokenAddress = null,
    Object? tokens = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      lpTokenAddress: null == lpTokenAddress
          ? _value.lpTokenAddress
          : lpTokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      tokens: null == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetPoolListResponseImplCopyWith<$Res>
    implements $GetPoolListResponseCopyWith<$Res> {
  factory _$$GetPoolListResponseImplCopyWith(_$GetPoolListResponseImpl value,
          $Res Function(_$GetPoolListResponseImpl) then) =
      __$$GetPoolListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String address,
      @JsonKey(name: 'lp_token_address') String lpTokenAddress,
      String tokens});
}

/// @nodoc
class __$$GetPoolListResponseImplCopyWithImpl<$Res>
    extends _$GetPoolListResponseCopyWithImpl<$Res, _$GetPoolListResponseImpl>
    implements _$$GetPoolListResponseImplCopyWith<$Res> {
  __$$GetPoolListResponseImplCopyWithImpl(_$GetPoolListResponseImpl _value,
      $Res Function(_$GetPoolListResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? lpTokenAddress = null,
    Object? tokens = null,
  }) {
    return _then(_$GetPoolListResponseImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      lpTokenAddress: null == lpTokenAddress
          ? _value.lpTokenAddress
          : lpTokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      tokens: null == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetPoolListResponseImpl implements _GetPoolListResponse {
  const _$GetPoolListResponseImpl(
      {required this.address,
      @JsonKey(name: 'lp_token_address') required this.lpTokenAddress,
      required this.tokens});

  factory _$GetPoolListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetPoolListResponseImplFromJson(json);

  @override
  final String address;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'lp_token_address')
  final String lpTokenAddress;
  @override
  final String tokens;

  @override
  String toString() {
    return 'GetPoolListResponse(address: $address, lpTokenAddress: $lpTokenAddress, tokens: $tokens)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPoolListResponseImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.lpTokenAddress, lpTokenAddress) ||
                other.lpTokenAddress == lpTokenAddress) &&
            (identical(other.tokens, tokens) || other.tokens == tokens));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, address, lpTokenAddress, tokens);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPoolListResponseImplCopyWith<_$GetPoolListResponseImpl> get copyWith =>
      __$$GetPoolListResponseImplCopyWithImpl<_$GetPoolListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetPoolListResponseImplToJson(
      this,
    );
  }
}

abstract class _GetPoolListResponse implements GetPoolListResponse {
  const factory _GetPoolListResponse(
      {required final String address,
      @JsonKey(name: 'lp_token_address') required final String lpTokenAddress,
      required final String tokens}) = _$GetPoolListResponseImpl;

  factory _GetPoolListResponse.fromJson(Map<String, dynamic> json) =
      _$GetPoolListResponseImpl.fromJson;

  @override
  String get address;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'lp_token_address')
  String get lpTokenAddress;
  @override
  String get tokens;
  @override
  @JsonKey(ignore: true)
  _$$GetPoolListResponseImplCopyWith<_$GetPoolListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
