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
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String seed, String accountSelectedName,
            String message, double amount, Address recipientAddress)
        uco,
    required TResult Function(
            String seed,
            String accountSelectedName,
            String message,
            double amount,
            Address recipientAddress,
            String? tokenAddress)
        token,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String seed, String accountSelectedName, String message,
            double amount, Address recipientAddress)?
        uco,
    TResult Function(String seed, String accountSelectedName, String message,
            double amount, Address recipientAddress, String? tokenAddress)?
        token,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String seed, String accountSelectedName, String message,
            double amount, Address recipientAddress)?
        uco,
    TResult Function(String seed, String accountSelectedName, String message,
            double amount, Address recipientAddress, String? tokenAddress)?
        token,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransferUco value) uco,
    required TResult Function(_TransferToken value) token,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_TransferUco value)? uco,
    TResult Function(_TransferToken value)? token,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransferUco value)? uco,
    TResult Function(_TransferToken value)? token,
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
      Address recipientAddress});
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
    ));
  }
}

/// @nodoc
abstract class _$$_TransferUcoCopyWith<$Res>
    implements $TransferCopyWith<$Res> {
  factory _$$_TransferUcoCopyWith(
          _$_TransferUco value, $Res Function(_$_TransferUco) then) =
      __$$_TransferUcoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String seed,
      String accountSelectedName,
      String message,
      double amount,
      Address recipientAddress});
}

/// @nodoc
class __$$_TransferUcoCopyWithImpl<$Res> extends _$TransferCopyWithImpl<$Res>
    implements _$$_TransferUcoCopyWith<$Res> {
  __$$_TransferUcoCopyWithImpl(
      _$_TransferUco _value, $Res Function(_$_TransferUco) _then)
      : super(_value, (v) => _then(v as _$_TransferUco));

  @override
  _$_TransferUco get _value => super._value as _$_TransferUco;

  @override
  $Res call({
    Object? seed = freezed,
    Object? accountSelectedName = freezed,
    Object? message = freezed,
    Object? amount = freezed,
    Object? recipientAddress = freezed,
  }) {
    return _then(_$_TransferUco(
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
    ));
  }
}

/// @nodoc

class _$_TransferUco extends _TransferUco {
  const _$_TransferUco(
      {required this.seed,
      required this.accountSelectedName,
      required this.message,
      required this.amount,
      required this.recipientAddress})
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
  String toString() {
    return 'Transfer.uco(seed: $seed, accountSelectedName: $accountSelectedName, message: $message, amount: $amount, recipientAddress: $recipientAddress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransferUco &&
            const DeepCollectionEquality().equals(other.seed, seed) &&
            const DeepCollectionEquality()
                .equals(other.accountSelectedName, accountSelectedName) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality()
                .equals(other.recipientAddress, recipientAddress));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(seed),
      const DeepCollectionEquality().hash(accountSelectedName),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(amount),
      const DeepCollectionEquality().hash(recipientAddress));

  @JsonKey(ignore: true)
  @override
  _$$_TransferUcoCopyWith<_$_TransferUco> get copyWith =>
      __$$_TransferUcoCopyWithImpl<_$_TransferUco>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String seed, String accountSelectedName,
            String message, double amount, Address recipientAddress)
        uco,
    required TResult Function(
            String seed,
            String accountSelectedName,
            String message,
            double amount,
            Address recipientAddress,
            String? tokenAddress)
        token,
  }) {
    return uco(seed, accountSelectedName, message, amount, recipientAddress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String seed, String accountSelectedName, String message,
            double amount, Address recipientAddress)?
        uco,
    TResult Function(String seed, String accountSelectedName, String message,
            double amount, Address recipientAddress, String? tokenAddress)?
        token,
  }) {
    return uco?.call(
        seed, accountSelectedName, message, amount, recipientAddress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String seed, String accountSelectedName, String message,
            double amount, Address recipientAddress)?
        uco,
    TResult Function(String seed, String accountSelectedName, String message,
            double amount, Address recipientAddress, String? tokenAddress)?
        token,
    required TResult orElse(),
  }) {
    if (uco != null) {
      return uco(seed, accountSelectedName, message, amount, recipientAddress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransferUco value) uco,
    required TResult Function(_TransferToken value) token,
  }) {
    return uco(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_TransferUco value)? uco,
    TResult Function(_TransferToken value)? token,
  }) {
    return uco?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransferUco value)? uco,
    TResult Function(_TransferToken value)? token,
    required TResult orElse(),
  }) {
    if (uco != null) {
      return uco(this);
    }
    return orElse();
  }
}

abstract class _TransferUco extends Transfer {
  const factory _TransferUco(
      {required final String seed,
      required final String accountSelectedName,
      required final String message,
      required final double amount,
      required final Address recipientAddress}) = _$_TransferUco;
  const _TransferUco._() : super._();

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
  @JsonKey(ignore: true)
  _$$_TransferUcoCopyWith<_$_TransferUco> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_TransferTokenCopyWith<$Res>
    implements $TransferCopyWith<$Res> {
  factory _$$_TransferTokenCopyWith(
          _$_TransferToken value, $Res Function(_$_TransferToken) then) =
      __$$_TransferTokenCopyWithImpl<$Res>;
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
class __$$_TransferTokenCopyWithImpl<$Res> extends _$TransferCopyWithImpl<$Res>
    implements _$$_TransferTokenCopyWith<$Res> {
  __$$_TransferTokenCopyWithImpl(
      _$_TransferToken _value, $Res Function(_$_TransferToken) _then)
      : super(_value, (v) => _then(v as _$_TransferToken));

  @override
  _$_TransferToken get _value => super._value as _$_TransferToken;

  @override
  $Res call({
    Object? seed = freezed,
    Object? accountSelectedName = freezed,
    Object? message = freezed,
    Object? amount = freezed,
    Object? recipientAddress = freezed,
    Object? tokenAddress = freezed,
  }) {
    return _then(_$_TransferToken(
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

class _$_TransferToken extends _TransferToken {
  const _$_TransferToken(
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
// expressed in token
  @override
  final Address recipientAddress;
  @override
  final String? tokenAddress;

  @override
  String toString() {
    return 'Transfer.token(seed: $seed, accountSelectedName: $accountSelectedName, message: $message, amount: $amount, recipientAddress: $recipientAddress, tokenAddress: $tokenAddress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransferToken &&
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
  _$$_TransferTokenCopyWith<_$_TransferToken> get copyWith =>
      __$$_TransferTokenCopyWithImpl<_$_TransferToken>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String seed, String accountSelectedName,
            String message, double amount, Address recipientAddress)
        uco,
    required TResult Function(
            String seed,
            String accountSelectedName,
            String message,
            double amount,
            Address recipientAddress,
            String? tokenAddress)
        token,
  }) {
    return token(seed, accountSelectedName, message, amount, recipientAddress,
        tokenAddress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String seed, String accountSelectedName, String message,
            double amount, Address recipientAddress)?
        uco,
    TResult Function(String seed, String accountSelectedName, String message,
            double amount, Address recipientAddress, String? tokenAddress)?
        token,
  }) {
    return token?.call(seed, accountSelectedName, message, amount,
        recipientAddress, tokenAddress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String seed, String accountSelectedName, String message,
            double amount, Address recipientAddress)?
        uco,
    TResult Function(String seed, String accountSelectedName, String message,
            double amount, Address recipientAddress, String? tokenAddress)?
        token,
    required TResult orElse(),
  }) {
    if (token != null) {
      return token(seed, accountSelectedName, message, amount, recipientAddress,
          tokenAddress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransferUco value) uco,
    required TResult Function(_TransferToken value) token,
  }) {
    return token(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_TransferUco value)? uco,
    TResult Function(_TransferToken value)? token,
  }) {
    return token?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransferUco value)? uco,
    TResult Function(_TransferToken value)? token,
    required TResult orElse(),
  }) {
    if (token != null) {
      return token(this);
    }
    return orElse();
  }
}

abstract class _TransferToken extends Transfer {
  const factory _TransferToken(
      {required final String seed,
      required final String accountSelectedName,
      required final String message,
      required final double amount,
      required final Address recipientAddress,
      final String? tokenAddress}) = _$_TransferToken;
  const _TransferToken._() : super._();

  @override
  String get seed;
  @override
  String get accountSelectedName;
  @override
  String get message;
  @override
  double get amount;
  @override // expressed in token
  Address get recipientAddress;
  String? get tokenAddress;
  @override
  @JsonKey(ignore: true)
  _$$_TransferTokenCopyWith<_$_TransferToken> get copyWith =>
      throw _privateConstructorUsedError;
}
