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
            String type,
            String? tokenAddress,
            int? tokenId,
            Map<String, dynamic> properties)
        token,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String seed, String accountSelectedName, String message,
            double amount, Address recipientAddress)?
        uco,
    TResult? Function(
            String seed,
            String accountSelectedName,
            String message,
            double amount,
            Address recipientAddress,
            String type,
            String? tokenAddress,
            int? tokenId,
            Map<String, dynamic> properties)?
        token,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String seed, String accountSelectedName, String message,
            double amount, Address recipientAddress)?
        uco,
    TResult Function(
            String seed,
            String accountSelectedName,
            String message,
            double amount,
            Address recipientAddress,
            String type,
            String? tokenAddress,
            int? tokenId,
            Map<String, dynamic> properties)?
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
    TResult? Function(_TransferUco value)? uco,
    TResult? Function(_TransferToken value)? token,
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
      _$TransferCopyWithImpl<$Res, Transfer>;
  @useResult
  $Res call(
      {String seed,
      String accountSelectedName,
      String message,
      double amount,
      Address recipientAddress});
}

/// @nodoc
class _$TransferCopyWithImpl<$Res, $Val extends Transfer>
    implements $TransferCopyWith<$Res> {
  _$TransferCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seed = null,
    Object? accountSelectedName = null,
    Object? message = null,
    Object? amount = null,
    Object? recipientAddress = null,
  }) {
    return _then(_value.copyWith(
      seed: null == seed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as String,
      accountSelectedName: null == accountSelectedName
          ? _value.accountSelectedName
          : accountSelectedName // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      recipientAddress: null == recipientAddress
          ? _value.recipientAddress
          : recipientAddress // ignore: cast_nullable_to_non_nullable
              as Address,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransferUcoCopyWith<$Res>
    implements $TransferCopyWith<$Res> {
  factory _$$_TransferUcoCopyWith(
          _$_TransferUco value, $Res Function(_$_TransferUco) then) =
      __$$_TransferUcoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String seed,
      String accountSelectedName,
      String message,
      double amount,
      Address recipientAddress});
}

/// @nodoc
class __$$_TransferUcoCopyWithImpl<$Res>
    extends _$TransferCopyWithImpl<$Res, _$_TransferUco>
    implements _$$_TransferUcoCopyWith<$Res> {
  __$$_TransferUcoCopyWithImpl(
      _$_TransferUco _value, $Res Function(_$_TransferUco) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seed = null,
    Object? accountSelectedName = null,
    Object? message = null,
    Object? amount = null,
    Object? recipientAddress = null,
  }) {
    return _then(_$_TransferUco(
      seed: null == seed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as String,
      accountSelectedName: null == accountSelectedName
          ? _value.accountSelectedName
          : accountSelectedName // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      recipientAddress: null == recipientAddress
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
            (identical(other.seed, seed) || other.seed == seed) &&
            (identical(other.accountSelectedName, accountSelectedName) ||
                other.accountSelectedName == accountSelectedName) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.recipientAddress, recipientAddress) ||
                other.recipientAddress == recipientAddress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, seed, accountSelectedName,
      message, amount, recipientAddress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
            String type,
            String? tokenAddress,
            int? tokenId,
            Map<String, dynamic> properties)
        token,
  }) {
    return uco(seed, accountSelectedName, message, amount, recipientAddress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String seed, String accountSelectedName, String message,
            double amount, Address recipientAddress)?
        uco,
    TResult? Function(
            String seed,
            String accountSelectedName,
            String message,
            double amount,
            Address recipientAddress,
            String type,
            String? tokenAddress,
            int? tokenId,
            Map<String, dynamic> properties)?
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
    TResult Function(
            String seed,
            String accountSelectedName,
            String message,
            double amount,
            Address recipientAddress,
            String type,
            String? tokenAddress,
            int? tokenId,
            Map<String, dynamic> properties)?
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
    TResult? Function(_TransferUco value)? uco,
    TResult? Function(_TransferToken value)? token,
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
  @useResult
  $Res call(
      {String seed,
      String accountSelectedName,
      String message,
      double amount,
      Address recipientAddress,
      String type,
      String? tokenAddress,
      int? tokenId,
      Map<String, dynamic> properties});
}

/// @nodoc
class __$$_TransferTokenCopyWithImpl<$Res>
    extends _$TransferCopyWithImpl<$Res, _$_TransferToken>
    implements _$$_TransferTokenCopyWith<$Res> {
  __$$_TransferTokenCopyWithImpl(
      _$_TransferToken _value, $Res Function(_$_TransferToken) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seed = null,
    Object? accountSelectedName = null,
    Object? message = null,
    Object? amount = null,
    Object? recipientAddress = null,
    Object? type = null,
    Object? tokenAddress = freezed,
    Object? tokenId = freezed,
    Object? properties = null,
  }) {
    return _then(_$_TransferToken(
      seed: null == seed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as String,
      accountSelectedName: null == accountSelectedName
          ? _value.accountSelectedName
          : accountSelectedName // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      recipientAddress: null == recipientAddress
          ? _value.recipientAddress
          : recipientAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddress: freezed == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenId: freezed == tokenId
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as int?,
      properties: null == properties
          ? _value._properties
          : properties // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
      required this.type,
      required this.tokenAddress,
      required this.tokenId,
      required final Map<String, dynamic> properties})
      : _properties = properties,
        super._();

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
  final String type;
  @override
  final String? tokenAddress;
  @override
  final int? tokenId;
  final Map<String, dynamic> _properties;
  @override
  Map<String, dynamic> get properties {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_properties);
  }

  @override
  String toString() {
    return 'Transfer.token(seed: $seed, accountSelectedName: $accountSelectedName, message: $message, amount: $amount, recipientAddress: $recipientAddress, type: $type, tokenAddress: $tokenAddress, tokenId: $tokenId, properties: $properties)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransferToken &&
            (identical(other.seed, seed) || other.seed == seed) &&
            (identical(other.accountSelectedName, accountSelectedName) ||
                other.accountSelectedName == accountSelectedName) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.recipientAddress, recipientAddress) ||
                other.recipientAddress == recipientAddress) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.tokenAddress, tokenAddress) ||
                other.tokenAddress == tokenAddress) &&
            (identical(other.tokenId, tokenId) || other.tokenId == tokenId) &&
            const DeepCollectionEquality()
                .equals(other._properties, _properties));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      seed,
      accountSelectedName,
      message,
      amount,
      recipientAddress,
      type,
      tokenAddress,
      tokenId,
      const DeepCollectionEquality().hash(_properties));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
            String type,
            String? tokenAddress,
            int? tokenId,
            Map<String, dynamic> properties)
        token,
  }) {
    return token(seed, accountSelectedName, message, amount, recipientAddress,
        type, tokenAddress, tokenId, properties);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String seed, String accountSelectedName, String message,
            double amount, Address recipientAddress)?
        uco,
    TResult? Function(
            String seed,
            String accountSelectedName,
            String message,
            double amount,
            Address recipientAddress,
            String type,
            String? tokenAddress,
            int? tokenId,
            Map<String, dynamic> properties)?
        token,
  }) {
    return token?.call(seed, accountSelectedName, message, amount,
        recipientAddress, type, tokenAddress, tokenId, properties);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String seed, String accountSelectedName, String message,
            double amount, Address recipientAddress)?
        uco,
    TResult Function(
            String seed,
            String accountSelectedName,
            String message,
            double amount,
            Address recipientAddress,
            String type,
            String? tokenAddress,
            int? tokenId,
            Map<String, dynamic> properties)?
        token,
    required TResult orElse(),
  }) {
    if (token != null) {
      return token(seed, accountSelectedName, message, amount, recipientAddress,
          type, tokenAddress, tokenId, properties);
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
    TResult? Function(_TransferUco value)? uco,
    TResult? Function(_TransferToken value)? token,
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
      required final String type,
      required final String? tokenAddress,
      required final int? tokenId,
      required final Map<String, dynamic> properties}) = _$_TransferToken;
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
  String get type;
  String? get tokenAddress;
  int? get tokenId;
  Map<String, dynamic> get properties;
  @override
  @JsonKey(ignore: true)
  _$$_TransferTokenCopyWith<_$_TransferToken> get copyWith =>
      throw _privateConstructorUsedError;
}
