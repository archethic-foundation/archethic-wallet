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

DeeplinkRpcRequest _$DeeplinkRpcRequestFromJson(Map<String, dynamic> json) {
  return _DeeplinkRpcRequest.fromJson(json);
}

/// @nodoc
mixin _$DeeplinkRpcRequest {
  String get id => throw _privateConstructorUsedError;
  String get replyUrl => throw _privateConstructorUsedError;
  dynamic get params => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeeplinkRpcRequestCopyWith<DeeplinkRpcRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeeplinkRpcRequestCopyWith<$Res> {
  factory $DeeplinkRpcRequestCopyWith(
          DeeplinkRpcRequest value, $Res Function(DeeplinkRpcRequest) then) =
      _$DeeplinkRpcRequestCopyWithImpl<$Res, DeeplinkRpcRequest>;
  @useResult
  $Res call({String id, String replyUrl, dynamic params});
}

/// @nodoc
class _$DeeplinkRpcRequestCopyWithImpl<$Res, $Val extends DeeplinkRpcRequest>
    implements $DeeplinkRpcRequestCopyWith<$Res> {
  _$DeeplinkRpcRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? replyUrl = null,
    Object? params = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      replyUrl: null == replyUrl
          ? _value.replyUrl
          : replyUrl // ignore: cast_nullable_to_non_nullable
              as String,
      params: freezed == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DeeplinkRpcRequestCopyWith<$Res>
    implements $DeeplinkRpcRequestCopyWith<$Res> {
  factory _$$_DeeplinkRpcRequestCopyWith(_$_DeeplinkRpcRequest value,
          $Res Function(_$_DeeplinkRpcRequest) then) =
      __$$_DeeplinkRpcRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String replyUrl, dynamic params});
}

/// @nodoc
class __$$_DeeplinkRpcRequestCopyWithImpl<$Res>
    extends _$DeeplinkRpcRequestCopyWithImpl<$Res, _$_DeeplinkRpcRequest>
    implements _$$_DeeplinkRpcRequestCopyWith<$Res> {
  __$$_DeeplinkRpcRequestCopyWithImpl(
      _$_DeeplinkRpcRequest _value, $Res Function(_$_DeeplinkRpcRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? replyUrl = null,
    Object? params = freezed,
  }) {
    return _then(_$_DeeplinkRpcRequest(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      replyUrl: null == replyUrl
          ? _value.replyUrl
          : replyUrl // ignore: cast_nullable_to_non_nullable
              as String,
      params: freezed == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DeeplinkRpcRequest extends _DeeplinkRpcRequest {
  const _$_DeeplinkRpcRequest(
      {required this.id, required this.replyUrl, this.params})
      : super._();

  factory _$_DeeplinkRpcRequest.fromJson(Map<String, dynamic> json) =>
      _$$_DeeplinkRpcRequestFromJson(json);

  @override
  final String id;
  @override
  final String replyUrl;
  @override
  final dynamic params;

  @override
  String toString() {
    return 'DeeplinkRpcRequest(id: $id, replyUrl: $replyUrl, params: $params)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeeplinkRpcRequest &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.replyUrl, replyUrl) ||
                other.replyUrl == replyUrl) &&
            const DeepCollectionEquality().equals(other.params, params));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, replyUrl, const DeepCollectionEquality().hash(params));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeeplinkRpcRequestCopyWith<_$_DeeplinkRpcRequest> get copyWith =>
      __$$_DeeplinkRpcRequestCopyWithImpl<_$_DeeplinkRpcRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DeeplinkRpcRequestToJson(
      this,
    );
  }
}

abstract class _DeeplinkRpcRequest extends DeeplinkRpcRequest {
  const factory _DeeplinkRpcRequest(
      {required final String id,
      required final String replyUrl,
      final dynamic params}) = _$_DeeplinkRpcRequest;
  const _DeeplinkRpcRequest._() : super._();

  factory _DeeplinkRpcRequest.fromJson(Map<String, dynamic> json) =
      _$_DeeplinkRpcRequest.fromJson;

  @override
  String get id;
  @override
  String get replyUrl;
  @override
  dynamic get params;
  @override
  @JsonKey(ignore: true)
  _$$_DeeplinkRpcRequestCopyWith<_$_DeeplinkRpcRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
