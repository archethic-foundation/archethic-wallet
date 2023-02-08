// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_transfer_wallet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TokenTransferWallet _$TokenTransferWalletFromJson(Map<String, dynamic> json) {
  return _TokenTransferWallet.fromJson(json);
}

/// @nodoc
mixin _$TokenTransferWallet {
  int? get amount => throw _privateConstructorUsedError;
  String? get to => throw _privateConstructorUsedError;
  String? get tokenAddress => throw _privateConstructorUsedError;
  int? get tokenId => throw _privateConstructorUsedError;
  String? get toContactName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokenTransferWalletCopyWith<TokenTransferWallet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenTransferWalletCopyWith<$Res> {
  factory $TokenTransferWalletCopyWith(
          TokenTransferWallet value, $Res Function(TokenTransferWallet) then) =
      _$TokenTransferWalletCopyWithImpl<$Res, TokenTransferWallet>;
  @useResult
  $Res call(
      {int? amount,
      String? to,
      String? tokenAddress,
      int? tokenId,
      String? toContactName});
}

/// @nodoc
class _$TokenTransferWalletCopyWithImpl<$Res, $Val extends TokenTransferWallet>
    implements $TokenTransferWalletCopyWith<$Res> {
  _$TokenTransferWalletCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? to = freezed,
    Object? tokenAddress = freezed,
    Object? tokenId = freezed,
    Object? toContactName = freezed,
  }) {
    return _then(_value.copyWith(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenAddress: freezed == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenId: freezed == tokenId
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as int?,
      toContactName: freezed == toContactName
          ? _value.toContactName
          : toContactName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TokenTransferWalletCopyWith<$Res>
    implements $TokenTransferWalletCopyWith<$Res> {
  factory _$$_TokenTransferWalletCopyWith(_$_TokenTransferWallet value,
          $Res Function(_$_TokenTransferWallet) then) =
      __$$_TokenTransferWalletCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? amount,
      String? to,
      String? tokenAddress,
      int? tokenId,
      String? toContactName});
}

/// @nodoc
class __$$_TokenTransferWalletCopyWithImpl<$Res>
    extends _$TokenTransferWalletCopyWithImpl<$Res, _$_TokenTransferWallet>
    implements _$$_TokenTransferWalletCopyWith<$Res> {
  __$$_TokenTransferWalletCopyWithImpl(_$_TokenTransferWallet _value,
      $Res Function(_$_TokenTransferWallet) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? to = freezed,
    Object? tokenAddress = freezed,
    Object? tokenId = freezed,
    Object? toContactName = freezed,
  }) {
    return _then(_$_TokenTransferWallet(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenAddress: freezed == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenId: freezed == tokenId
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as int?,
      toContactName: freezed == toContactName
          ? _value.toContactName
          : toContactName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TokenTransferWallet extends _TokenTransferWallet {
  const _$_TokenTransferWallet(
      {this.amount,
      this.to,
      this.tokenAddress,
      this.tokenId,
      this.toContactName})
      : super._();

  factory _$_TokenTransferWallet.fromJson(Map<String, dynamic> json) =>
      _$$_TokenTransferWalletFromJson(json);

  @override
  final int? amount;
  @override
  final String? to;
  @override
  final String? tokenAddress;
  @override
  final int? tokenId;
  @override
  final String? toContactName;

  @override
  String toString() {
    return 'TokenTransferWallet(amount: $amount, to: $to, tokenAddress: $tokenAddress, tokenId: $tokenId, toContactName: $toContactName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TokenTransferWallet &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.tokenAddress, tokenAddress) ||
                other.tokenAddress == tokenAddress) &&
            (identical(other.tokenId, tokenId) || other.tokenId == tokenId) &&
            (identical(other.toContactName, toContactName) ||
                other.toContactName == toContactName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, amount, to, tokenAddress, tokenId, toContactName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TokenTransferWalletCopyWith<_$_TokenTransferWallet> get copyWith =>
      __$$_TokenTransferWalletCopyWithImpl<_$_TokenTransferWallet>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TokenTransferWalletToJson(
      this,
    );
  }
}

abstract class _TokenTransferWallet extends TokenTransferWallet {
  const factory _TokenTransferWallet(
      {final int? amount,
      final String? to,
      final String? tokenAddress,
      final int? tokenId,
      final String? toContactName}) = _$_TokenTransferWallet;
  const _TokenTransferWallet._() : super._();

  factory _TokenTransferWallet.fromJson(Map<String, dynamic> json) =
      _$_TokenTransferWallet.fromJson;

  @override
  int? get amount;
  @override
  String? get to;
  @override
  String? get tokenAddress;
  @override
  int? get tokenId;
  @override
  String? get toContactName;
  @override
  @JsonKey(ignore: true)
  _$$_TokenTransferWalletCopyWith<_$_TokenTransferWallet> get copyWith =>
      throw _privateConstructorUsedError;
}
