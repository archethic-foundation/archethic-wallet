// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'transfer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Transfer {
  String get seed => throw _privateConstructorUsedError;
  String get accountSelectedName => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError; // expressed in UCO
  Address get recipientAddress => throw _privateConstructorUsedError;
  String? get tokenAddress => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String seed,
            String accountSelectedName,
            String message,
            double amount,
            Address recipientAddress,
            String? tokenAddress)
        uco,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String seed, String accountSelectedName, String message,
            double amount, Address recipientAddress, String? tokenAddress)?
        uco,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String seed, String accountSelectedName, String message,
            double amount, Address recipientAddress, String? tokenAddress)?
        uco,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Transfer value) uco,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Transfer value)? uco,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Transfer value)? uco,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransferCopyWith<Transfer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferCopyWith<$Res> {
  factory $TransferCopyWith(Transfer value, $Res Function(Transfer) then) =
      _$TransferCopyWithImpl<$Res>;
  $Res call(
      {String seed,
      String accountSelectedName,
      String message,
      double amount,
      Address recipientAddress,
      String? tokenAddress});
}

/// @nodoc
class _$TransferCopyWithImpl<$Res> implements $TransferCopyWith<$Res> {
  _$TransferCopyWithImpl(this._value, this._then);

  final Transfer _value;
  // ignore: unused_field
  final $Res Function(Transfer) _then;

  @override
  $Res call({
    Object? seed = freezed,
    Object? accountSelectedName = freezed,
    Object? message = freezed,
    Object? amount = freezed,
    Object? recipientAddress = freezed,
    Object? tokenAddress = freezed,
  }) {
    return _then(_value.copyWith(
      seed: seed == freezed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as String,
      accountSelectedName: accountSelectedName == freezed
          ? _value.accountSelectedName
          : accountSelectedName // ignore: cast_nullable_to_non_nullable
              as String,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      recipientAddress: recipientAddress == freezed
          ? _value.recipientAddress
          : recipientAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      tokenAddress: tokenAddress == freezed
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_TransferCopyWith<$Res> implements $TransferCopyWith<$Res> {
  factory _$$_TransferCopyWith(
          _$_Transfer value, $Res Function(_$_Transfer) then) =
      __$$_TransferCopyWithImpl<$Res>;
  @override
  $Res call(
      {String seed,
      String accountSelectedName,
      String message,
      double amount,
      Address recipientAddress,
      String? tokenAddress});
}

/// @nodoc
class __$$_TransferCopyWithImpl<$Res> extends _$TransferCopyWithImpl<$Res>
    implements _$$_TransferCopyWith<$Res> {
  __$$_TransferCopyWithImpl(
      _$_Transfer _value, $Res Function(_$_Transfer) _then)
      : super(_value, (v) => _then(v as _$_Transfer));

  @override
  _$_Transfer get _value => super._value as _$_Transfer;

  @override
  $Res call({
    Object? seed = freezed,
    Object? accountSelectedName = freezed,
    Object? message = freezed,
    Object? amount = freezed,
    Object? recipientAddress = freezed,
    Object? tokenAddress = freezed,
  }) {
    return _then(_$_Transfer(
      seed: seed == freezed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as String,
      accountSelectedName: accountSelectedName == freezed
          ? _value.accountSelectedName
          : accountSelectedName // ignore: cast_nullable_to_non_nullable
              as String,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      recipientAddress: recipientAddress == freezed
          ? _value.recipientAddress
          : recipientAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      tokenAddress: tokenAddress == freezed
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_Transfer extends _Transfer {
  const _$_Transfer(
      {required this.seed,
      required this.accountSelectedName,
      required this.message,
      required this.amount,
      required this.recipientAddress,
      this.tokenAddress})
      : super._();

  @override
  final String seed;
  @override
  final String accountSelectedName;
  @override
  final String message;
  @override
  final double amount;
// expressed in UCO
  @override
  final Address recipientAddress;
  @override
  final String? tokenAddress;

  @override
  String toString() {
    return 'Transfer.uco(seed: $seed, accountSelectedName: $accountSelectedName, message: $message, amount: $amount, recipientAddress: $recipientAddress, tokenAddress: $tokenAddress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Transfer &&
            const DeepCollectionEquality().equals(other.seed, seed) &&
            const DeepCollectionEquality()
                .equals(other.accountSelectedName, accountSelectedName) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality()
                .equals(other.recipientAddress, recipientAddress) &&
            const DeepCollectionEquality()
                .equals(other.tokenAddress, tokenAddress));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(seed),
      const DeepCollectionEquality().hash(accountSelectedName),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(amount),
      const DeepCollectionEquality().hash(recipientAddress),
      const DeepCollectionEquality().hash(tokenAddress));

  @JsonKey(ignore: true)
  @override
  _$$_TransferCopyWith<_$_Transfer> get copyWith =>
      __$$_TransferCopyWithImpl<_$_Transfer>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String seed,
            String accountSelectedName,
            String message,
            double amount,
            Address recipientAddress,
            String? tokenAddress)
        uco,
  }) {
    return uco(seed, accountSelectedName, message, amount, recipientAddress,
        tokenAddress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String seed, String accountSelectedName, String message,
            double amount, Address recipientAddress, String? tokenAddress)?
        uco,
  }) {
    return uco?.call(seed, accountSelectedName, message, amount,
        recipientAddress, tokenAddress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String seed, String accountSelectedName, String message,
            double amount, Address recipientAddress, String? tokenAddress)?
        uco,
    required TResult orElse(),
  }) {
    if (uco != null) {
      return uco(seed, accountSelectedName, message, amount, recipientAddress,
          tokenAddress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Transfer value) uco,
  }) {
    return uco(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Transfer value)? uco,
  }) {
    return uco?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Transfer value)? uco,
    required TResult orElse(),
  }) {
    if (uco != null) {
      return uco(this);
    }
    return orElse();
  }
}

abstract class _Transfer extends Transfer {
  const factory _Transfer(
      {required final String seed,
      required final String accountSelectedName,
      required final String message,
      required final double amount,
      required final Address recipientAddress,
      final String? tokenAddress}) = _$_Transfer;
  const _Transfer._() : super._();

  @override
  String get seed;
  @override
  String get accountSelectedName;
  @override
  String get message;
  @override
  double get amount;
  @override // expressed in UCO
  Address get recipientAddress;
  @override
  String? get tokenAddress;
  @override
  @JsonKey(ignore: true)
  _$$_TransferCopyWith<_$_Transfer> get copyWith =>
      throw _privateConstructorUsedError;
}
