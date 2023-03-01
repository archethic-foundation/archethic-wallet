// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rpc_send_transaction_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RpcSendTransactionResult _$RpcSendTransactionResultFromJson(
    Map<String, dynamic> json) {
  return _RpcSendTransactionResult.fromJson(json);
}

/// @nodoc
mixin _$RpcSendTransactionResult {
  String get transactionAddress => throw _privateConstructorUsedError;
  int get nbConfirmations => throw _privateConstructorUsedError;
  int get maxConfirmations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RpcSendTransactionResultCopyWith<RpcSendTransactionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RpcSendTransactionResultCopyWith<$Res> {
  factory $RpcSendTransactionResultCopyWith(RpcSendTransactionResult value,
          $Res Function(RpcSendTransactionResult) then) =
      _$RpcSendTransactionResultCopyWithImpl<$Res, RpcSendTransactionResult>;
  @useResult
  $Res call(
      {String transactionAddress, int nbConfirmations, int maxConfirmations});
}

/// @nodoc
class _$RpcSendTransactionResultCopyWithImpl<$Res,
        $Val extends RpcSendTransactionResult>
    implements $RpcSendTransactionResultCopyWith<$Res> {
  _$RpcSendTransactionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionAddress = null,
    Object? nbConfirmations = null,
    Object? maxConfirmations = null,
  }) {
    return _then(_value.copyWith(
      transactionAddress: null == transactionAddress
          ? _value.transactionAddress
          : transactionAddress // ignore: cast_nullable_to_non_nullable
              as String,
      nbConfirmations: null == nbConfirmations
          ? _value.nbConfirmations
          : nbConfirmations // ignore: cast_nullable_to_non_nullable
              as int,
      maxConfirmations: null == maxConfirmations
          ? _value.maxConfirmations
          : maxConfirmations // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RpcSendTransactionResultCopyWith<$Res>
    implements $RpcSendTransactionResultCopyWith<$Res> {
  factory _$$_RpcSendTransactionResultCopyWith(
          _$_RpcSendTransactionResult value,
          $Res Function(_$_RpcSendTransactionResult) then) =
      __$$_RpcSendTransactionResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String transactionAddress, int nbConfirmations, int maxConfirmations});
}

/// @nodoc
class __$$_RpcSendTransactionResultCopyWithImpl<$Res>
    extends _$RpcSendTransactionResultCopyWithImpl<$Res,
        _$_RpcSendTransactionResult>
    implements _$$_RpcSendTransactionResultCopyWith<$Res> {
  __$$_RpcSendTransactionResultCopyWithImpl(_$_RpcSendTransactionResult _value,
      $Res Function(_$_RpcSendTransactionResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionAddress = null,
    Object? nbConfirmations = null,
    Object? maxConfirmations = null,
  }) {
    return _then(_$_RpcSendTransactionResult(
      transactionAddress: null == transactionAddress
          ? _value.transactionAddress
          : transactionAddress // ignore: cast_nullable_to_non_nullable
              as String,
      nbConfirmations: null == nbConfirmations
          ? _value.nbConfirmations
          : nbConfirmations // ignore: cast_nullable_to_non_nullable
              as int,
      maxConfirmations: null == maxConfirmations
          ? _value.maxConfirmations
          : maxConfirmations // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RpcSendTransactionResult extends _RpcSendTransactionResult {
  const _$_RpcSendTransactionResult(
      {required this.transactionAddress,
      required this.nbConfirmations,
      required this.maxConfirmations})
      : super._();

  factory _$_RpcSendTransactionResult.fromJson(Map<String, dynamic> json) =>
      _$$_RpcSendTransactionResultFromJson(json);

  @override
  final String transactionAddress;
  @override
  final int nbConfirmations;
  @override
  final int maxConfirmations;

  @override
  String toString() {
    return 'RpcSendTransactionResult(transactionAddress: $transactionAddress, nbConfirmations: $nbConfirmations, maxConfirmations: $maxConfirmations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RpcSendTransactionResult &&
            (identical(other.transactionAddress, transactionAddress) ||
                other.transactionAddress == transactionAddress) &&
            (identical(other.nbConfirmations, nbConfirmations) ||
                other.nbConfirmations == nbConfirmations) &&
            (identical(other.maxConfirmations, maxConfirmations) ||
                other.maxConfirmations == maxConfirmations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, transactionAddress, nbConfirmations, maxConfirmations);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RpcSendTransactionResultCopyWith<_$_RpcSendTransactionResult>
      get copyWith => __$$_RpcSendTransactionResultCopyWithImpl<
          _$_RpcSendTransactionResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RpcSendTransactionResultToJson(
      this,
    );
  }
}

abstract class _RpcSendTransactionResult extends RpcSendTransactionResult {
  const factory _RpcSendTransactionResult(
      {required final String transactionAddress,
      required final int nbConfirmations,
      required final int maxConfirmations}) = _$_RpcSendTransactionResult;
  const _RpcSendTransactionResult._() : super._();

  factory _RpcSendTransactionResult.fromJson(Map<String, dynamic> json) =
      _$_RpcSendTransactionResult.fromJson;

  @override
  String get transactionAddress;
  @override
  int get nbConfirmations;
  @override
  int get maxConfirmations;
  @override
  @JsonKey(ignore: true)
  _$$_RpcSendTransactionResultCopyWith<_$_RpcSendTransactionResult>
      get copyWith => throw _privateConstructorUsedError;
}
