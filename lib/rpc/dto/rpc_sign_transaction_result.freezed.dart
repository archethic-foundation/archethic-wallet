// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rpc_sign_transaction_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RpcSignTransactionResult _$RpcSignTransactionResultFromJson(
    Map<String, dynamic> json) {
  return _RpcSignTransactionResult.fromJson(json);
}

/// @nodoc
mixin _$RpcSignTransactionResult {
  String get transactionAddress => throw _privateConstructorUsedError;
  int get nbConfirmations => throw _privateConstructorUsedError;
  int get maxConfirmations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RpcSignTransactionResultCopyWith<RpcSignTransactionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RpcSignTransactionResultCopyWith<$Res> {
  factory $RpcSignTransactionResultCopyWith(RpcSignTransactionResult value,
          $Res Function(RpcSignTransactionResult) then) =
      _$RpcSignTransactionResultCopyWithImpl<$Res, RpcSignTransactionResult>;
  @useResult
  $Res call(
      {String transactionAddress, int nbConfirmations, int maxConfirmations});
}

/// @nodoc
class _$RpcSignTransactionResultCopyWithImpl<$Res,
        $Val extends RpcSignTransactionResult>
    implements $RpcSignTransactionResultCopyWith<$Res> {
  _$RpcSignTransactionResultCopyWithImpl(this._value, this._then);

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
abstract class _$$_RpcSignTransactionResultCopyWith<$Res>
    implements $RpcSignTransactionResultCopyWith<$Res> {
  factory _$$_RpcSignTransactionResultCopyWith(
          _$_RpcSignTransactionResult value,
          $Res Function(_$_RpcSignTransactionResult) then) =
      __$$_RpcSignTransactionResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String transactionAddress, int nbConfirmations, int maxConfirmations});
}

/// @nodoc
class __$$_RpcSignTransactionResultCopyWithImpl<$Res>
    extends _$RpcSignTransactionResultCopyWithImpl<$Res,
        _$_RpcSignTransactionResult>
    implements _$$_RpcSignTransactionResultCopyWith<$Res> {
  __$$_RpcSignTransactionResultCopyWithImpl(_$_RpcSignTransactionResult _value,
      $Res Function(_$_RpcSignTransactionResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionAddress = null,
    Object? nbConfirmations = null,
    Object? maxConfirmations = null,
  }) {
    return _then(_$_RpcSignTransactionResult(
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
class _$_RpcSignTransactionResult extends _RpcSignTransactionResult {
  const _$_RpcSignTransactionResult(
      {required this.transactionAddress,
      required this.nbConfirmations,
      required this.maxConfirmations})
      : super._();

  factory _$_RpcSignTransactionResult.fromJson(Map<String, dynamic> json) =>
      _$$_RpcSignTransactionResultFromJson(json);

  @override
  final String transactionAddress;
  @override
  final int nbConfirmations;
  @override
  final int maxConfirmations;

  @override
  String toString() {
    return 'RpcSignTransactionResult(transactionAddress: $transactionAddress, nbConfirmations: $nbConfirmations, maxConfirmations: $maxConfirmations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RpcSignTransactionResult &&
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
  _$$_RpcSignTransactionResultCopyWith<_$_RpcSignTransactionResult>
      get copyWith => __$$_RpcSignTransactionResultCopyWithImpl<
          _$_RpcSignTransactionResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RpcSignTransactionResultToJson(
      this,
    );
  }
}

abstract class _RpcSignTransactionResult extends RpcSignTransactionResult {
  const factory _RpcSignTransactionResult(
      {required final String transactionAddress,
      required final int nbConfirmations,
      required final int maxConfirmations}) = _$_RpcSignTransactionResult;
  const _RpcSignTransactionResult._() : super._();

  factory _RpcSignTransactionResult.fromJson(Map<String, dynamic> json) =
      _$_RpcSignTransactionResult.fromJson;

  @override
  String get transactionAddress;
  @override
  int get nbConfirmations;
  @override
  int get maxConfirmations;
  @override
  @JsonKey(ignore: true)
  _$$_RpcSignTransactionResultCopyWith<_$_RpcSignTransactionResult>
      get copyWith => throw _privateConstructorUsedError;
}
