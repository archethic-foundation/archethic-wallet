// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'transaction_input_with_tx_address.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TransactionInputWithTxAddress _$TransactionInputWithTxAddressFromJson(
    Map<String, dynamic> json) {
  return _TransactionInputWithTxAddress.fromJson(json);
}

/// @nodoc
mixin _$TransactionInputWithTxAddress {
  /// Transaction address
  String get txAddress => throw _privateConstructorUsedError;

  /// Amount: asset amount
  int get amount => throw _privateConstructorUsedError;

  /// From: transaction which send the amount of assets
  String get from => throw _privateConstructorUsedError;

  /// token address: address of the token if the type is token
  String? get tokenAddress => throw _privateConstructorUsedError;

  /// Spent: determines if the input has been spent
  bool get spent => throw _privateConstructorUsedError;

  /// Timestamp: Date time when the inputs was generated
  int get timestamp => throw _privateConstructorUsedError;

  /// Type: UCO/Token/Call
  String? get type => throw _privateConstructorUsedError;

  /// Token id: It is the id for a token which is allocated when the token is minted.
  int? get tokenId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionInputWithTxAddressCopyWith<TransactionInputWithTxAddress>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionInputWithTxAddressCopyWith<$Res> {
  factory $TransactionInputWithTxAddressCopyWith(
          TransactionInputWithTxAddress value,
          $Res Function(TransactionInputWithTxAddress) then) =
      _$TransactionInputWithTxAddressCopyWithImpl<$Res,
          TransactionInputWithTxAddress>;
  @useResult
  $Res call(
      {String txAddress,
      int amount,
      String from,
      String? tokenAddress,
      bool spent,
      int timestamp,
      String? type,
      int? tokenId});
}

/// @nodoc
class _$TransactionInputWithTxAddressCopyWithImpl<$Res,
        $Val extends TransactionInputWithTxAddress>
    implements $TransactionInputWithTxAddressCopyWith<$Res> {
  _$TransactionInputWithTxAddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? txAddress = null,
    Object? amount = null,
    Object? from = null,
    Object? tokenAddress = freezed,
    Object? spent = null,
    Object? timestamp = null,
    Object? type = freezed,
    Object? tokenId = freezed,
  }) {
    return _then(_value.copyWith(
      txAddress: null == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddress: freezed == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      spent: null == spent
          ? _value.spent
          : spent // ignore: cast_nullable_to_non_nullable
              as bool,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenId: freezed == tokenId
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransactionInputWithTxAddressCopyWith<$Res>
    implements $TransactionInputWithTxAddressCopyWith<$Res> {
  factory _$$_TransactionInputWithTxAddressCopyWith(
          _$_TransactionInputWithTxAddress value,
          $Res Function(_$_TransactionInputWithTxAddress) then) =
      __$$_TransactionInputWithTxAddressCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String txAddress,
      int amount,
      String from,
      String? tokenAddress,
      bool spent,
      int timestamp,
      String? type,
      int? tokenId});
}

/// @nodoc
class __$$_TransactionInputWithTxAddressCopyWithImpl<$Res>
    extends _$TransactionInputWithTxAddressCopyWithImpl<$Res,
        _$_TransactionInputWithTxAddress>
    implements _$$_TransactionInputWithTxAddressCopyWith<$Res> {
  __$$_TransactionInputWithTxAddressCopyWithImpl(
      _$_TransactionInputWithTxAddress _value,
      $Res Function(_$_TransactionInputWithTxAddress) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? txAddress = null,
    Object? amount = null,
    Object? from = null,
    Object? tokenAddress = freezed,
    Object? spent = null,
    Object? timestamp = null,
    Object? type = freezed,
    Object? tokenId = freezed,
  }) {
    return _then(_$_TransactionInputWithTxAddress(
      txAddress: null == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddress: freezed == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      spent: null == spent
          ? _value.spent
          : spent // ignore: cast_nullable_to_non_nullable
              as bool,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenId: freezed == tokenId
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TransactionInputWithTxAddress extends _TransactionInputWithTxAddress {
  const _$_TransactionInputWithTxAddress(
      {this.txAddress = '',
      this.amount = 0,
      this.from = '',
      this.tokenAddress,
      this.spent = true,
      this.timestamp = 0,
      this.type,
      this.tokenId})
      : super._();

  factory _$_TransactionInputWithTxAddress.fromJson(
          Map<String, dynamic> json) =>
      _$$_TransactionInputWithTxAddressFromJson(json);

  /// Transaction address
  @override
  @JsonKey()
  final String txAddress;

  /// Amount: asset amount
  @override
  @JsonKey()
  final int amount;

  /// From: transaction which send the amount of assets
  @override
  @JsonKey()
  final String from;

  /// token address: address of the token if the type is token
  @override
  final String? tokenAddress;

  /// Spent: determines if the input has been spent
  @override
  @JsonKey()
  final bool spent;

  /// Timestamp: Date time when the inputs was generated
  @override
  @JsonKey()
  final int timestamp;

  /// Type: UCO/Token/Call
  @override
  final String? type;

  /// Token id: It is the id for a token which is allocated when the token is minted.
  @override
  final int? tokenId;

  @override
  String toString() {
    return 'TransactionInputWithTxAddress(txAddress: $txAddress, amount: $amount, from: $from, tokenAddress: $tokenAddress, spent: $spent, timestamp: $timestamp, type: $type, tokenId: $tokenId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionInputWithTxAddress &&
            (identical(other.txAddress, txAddress) ||
                other.txAddress == txAddress) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.tokenAddress, tokenAddress) ||
                other.tokenAddress == tokenAddress) &&
            (identical(other.spent, spent) || other.spent == spent) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.tokenId, tokenId) || other.tokenId == tokenId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, txAddress, amount, from,
      tokenAddress, spent, timestamp, type, tokenId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionInputWithTxAddressCopyWith<_$_TransactionInputWithTxAddress>
      get copyWith => __$$_TransactionInputWithTxAddressCopyWithImpl<
          _$_TransactionInputWithTxAddress>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransactionInputWithTxAddressToJson(
      this,
    );
  }
}

abstract class _TransactionInputWithTxAddress
    extends TransactionInputWithTxAddress {
  const factory _TransactionInputWithTxAddress(
      {final String txAddress,
      final int amount,
      final String from,
      final String? tokenAddress,
      final bool spent,
      final int timestamp,
      final String? type,
      final int? tokenId}) = _$_TransactionInputWithTxAddress;
  const _TransactionInputWithTxAddress._() : super._();

  factory _TransactionInputWithTxAddress.fromJson(Map<String, dynamic> json) =
      _$_TransactionInputWithTxAddress.fromJson;

  @override

  /// Transaction address
  String get txAddress;
  @override

  /// Amount: asset amount
  int get amount;
  @override

  /// From: transaction which send the amount of assets
  String get from;
  @override

  /// token address: address of the token if the type is token
  String? get tokenAddress;
  @override

  /// Spent: determines if the input has been spent
  bool get spent;
  @override

  /// Timestamp: Date time when the inputs was generated
  int get timestamp;
  @override

  /// Type: UCO/Token/Call
  String? get type;
  @override

  /// Token id: It is the id for a token which is allocated when the token is minted.
  int? get tokenId;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionInputWithTxAddressCopyWith<_$_TransactionInputWithTxAddress>
      get copyWith => throw _privateConstructorUsedError;
}
