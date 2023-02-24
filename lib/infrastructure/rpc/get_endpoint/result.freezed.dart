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

RpcGetEndpointResult _$RpcGetEndpointResultFromJson(Map<String, dynamic> json) {
  return _RpcGetEndpointResult.fromJson(json);
}

/// @nodoc
mixin _$RpcGetEndpointResult {
  String get endpointUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RpcGetEndpointResultCopyWith<RpcGetEndpointResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RpcGetEndpointResultCopyWith<$Res> {
  factory $RpcGetEndpointResultCopyWith(RpcGetEndpointResult value,
          $Res Function(RpcGetEndpointResult) then) =
      _$RpcGetEndpointResultCopyWithImpl<$Res, RpcGetEndpointResult>;
  @useResult
  $Res call({String endpointUrl});
}

/// @nodoc
class _$RpcGetEndpointResultCopyWithImpl<$Res,
        $Val extends RpcGetEndpointResult>
    implements $RpcGetEndpointResultCopyWith<$Res> {
  _$RpcGetEndpointResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? endpointUrl = null,
  }) {
    return _then(_value.copyWith(
      endpointUrl: null == endpointUrl
          ? _value.endpointUrl
          : endpointUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RpcGetEndpointResultCopyWith<$Res>
    implements $RpcGetEndpointResultCopyWith<$Res> {
  factory _$$_RpcGetEndpointResultCopyWith(_$_RpcGetEndpointResult value,
          $Res Function(_$_RpcGetEndpointResult) then) =
      __$$_RpcGetEndpointResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String endpointUrl});
}

/// @nodoc
class __$$_RpcGetEndpointResultCopyWithImpl<$Res>
    extends _$RpcGetEndpointResultCopyWithImpl<$Res, _$_RpcGetEndpointResult>
    implements _$$_RpcGetEndpointResultCopyWith<$Res> {
  __$$_RpcGetEndpointResultCopyWithImpl(_$_RpcGetEndpointResult _value,
      $Res Function(_$_RpcGetEndpointResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? endpointUrl = null,
  }) {
    return _then(_$_RpcGetEndpointResult(
      endpointUrl: null == endpointUrl
          ? _value.endpointUrl
          : endpointUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RpcGetEndpointResult extends _RpcGetEndpointResult {
  const _$_RpcGetEndpointResult({required this.endpointUrl}) : super._();

  factory _$_RpcGetEndpointResult.fromJson(Map<String, dynamic> json) =>
      _$$_RpcGetEndpointResultFromJson(json);

  @override
  final String endpointUrl;

  @override
  String toString() {
    return 'RpcGetEndpointResult(endpointUrl: $endpointUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RpcGetEndpointResult &&
            (identical(other.endpointUrl, endpointUrl) ||
                other.endpointUrl == endpointUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, endpointUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RpcGetEndpointResultCopyWith<_$_RpcGetEndpointResult> get copyWith =>
      __$$_RpcGetEndpointResultCopyWithImpl<_$_RpcGetEndpointResult>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RpcGetEndpointResultToJson(
      this,
    );
  }
}

abstract class _RpcGetEndpointResult extends RpcGetEndpointResult {
  const factory _RpcGetEndpointResult({required final String endpointUrl}) =
      _$_RpcGetEndpointResult;
  const _RpcGetEndpointResult._() : super._();

  factory _RpcGetEndpointResult.fromJson(Map<String, dynamic> json) =
      _$_RpcGetEndpointResult.fromJson;

  @override
  String get endpointUrl;
  @override
  @JsonKey(ignore: true)
  _$$_RpcGetEndpointResultCopyWith<_$_RpcGetEndpointResult> get copyWith =>
      throw _privateConstructorUsedError;
}
