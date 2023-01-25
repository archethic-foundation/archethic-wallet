// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TransactionTokenTransfer {
  int get amount => throw _privateConstructorUsedError;
  String get to => throw _privateConstructorUsedError;
  String get tokenAddress => throw _privateConstructorUsedError;
  int get tokenId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransactionTokenTransferCopyWith<TransactionTokenTransfer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionTokenTransferCopyWith<$Res> {
  factory $TransactionTokenTransferCopyWith(TransactionTokenTransfer value,
          $Res Function(TransactionTokenTransfer) then) =
      _$TransactionTokenTransferCopyWithImpl<$Res, TransactionTokenTransfer>;
  @useResult
  $Res call({int amount, String to, String tokenAddress, int tokenId});
}

/// @nodoc
class _$TransactionTokenTransferCopyWithImpl<$Res,
        $Val extends TransactionTokenTransfer>
    implements $TransactionTokenTransferCopyWith<$Res> {
  _$TransactionTokenTransferCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? to = null,
    Object? tokenAddress = null,
    Object? tokenId = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      tokenId: null == tokenId
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransactionTokenTransferCopyWith<$Res>
    implements $TransactionTokenTransferCopyWith<$Res> {
  factory _$$_TransactionTokenTransferCopyWith(
          _$_TransactionTokenTransfer value,
          $Res Function(_$_TransactionTokenTransfer) then) =
      __$$_TransactionTokenTransferCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int amount, String to, String tokenAddress, int tokenId});
}

/// @nodoc
class __$$_TransactionTokenTransferCopyWithImpl<$Res>
    extends _$TransactionTokenTransferCopyWithImpl<$Res,
        _$_TransactionTokenTransfer>
    implements _$$_TransactionTokenTransferCopyWith<$Res> {
  __$$_TransactionTokenTransferCopyWithImpl(_$_TransactionTokenTransfer _value,
      $Res Function(_$_TransactionTokenTransfer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? to = null,
    Object? tokenAddress = null,
    Object? tokenId = null,
  }) {
    return _then(_$_TransactionTokenTransfer(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      tokenId: null == tokenId
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_TransactionTokenTransfer extends _TransactionTokenTransfer {
  const _$_TransactionTokenTransfer(
      {required this.amount,
      required this.to,
      required this.tokenAddress,
      required this.tokenId})
      : super._();

  @override
  final int amount;
  @override
  final String to;
  @override
  final String tokenAddress;
  @override
  final int tokenId;

  @override
  String toString() {
    return 'TransactionTokenTransfer(amount: $amount, to: $to, tokenAddress: $tokenAddress, tokenId: $tokenId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionTokenTransfer &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.tokenAddress, tokenAddress) ||
                other.tokenAddress == tokenAddress) &&
            (identical(other.tokenId, tokenId) || other.tokenId == tokenId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, amount, to, tokenAddress, tokenId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionTokenTransferCopyWith<_$_TransactionTokenTransfer>
      get copyWith => __$$_TransactionTokenTransferCopyWithImpl<
          _$_TransactionTokenTransfer>(this, _$identity);
}

abstract class _TransactionTokenTransfer extends TransactionTokenTransfer {
  const factory _TransactionTokenTransfer(
      {required final int amount,
      required final String to,
      required final String tokenAddress,
      required final int tokenId}) = _$_TransactionTokenTransfer;
  const _TransactionTokenTransfer._() : super._();

  @override
  int get amount;
  @override
  String get to;
  @override
  String get tokenAddress;
  @override
  int get tokenId;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionTokenTransferCopyWith<_$_TransactionTokenTransfer>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TransactionTokenLedger {
  List<TransactionTokenTransfer> get transfers =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransactionTokenLedgerCopyWith<TransactionTokenLedger> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionTokenLedgerCopyWith<$Res> {
  factory $TransactionTokenLedgerCopyWith(TransactionTokenLedger value,
          $Res Function(TransactionTokenLedger) then) =
      _$TransactionTokenLedgerCopyWithImpl<$Res, TransactionTokenLedger>;
  @useResult
  $Res call({List<TransactionTokenTransfer> transfers});
}

/// @nodoc
class _$TransactionTokenLedgerCopyWithImpl<$Res,
        $Val extends TransactionTokenLedger>
    implements $TransactionTokenLedgerCopyWith<$Res> {
  _$TransactionTokenLedgerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transfers = null,
  }) {
    return _then(_value.copyWith(
      transfers: null == transfers
          ? _value.transfers
          : transfers // ignore: cast_nullable_to_non_nullable
              as List<TransactionTokenTransfer>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransactionTokenLedgerCopyWith<$Res>
    implements $TransactionTokenLedgerCopyWith<$Res> {
  factory _$$_TransactionTokenLedgerCopyWith(_$_TransactionTokenLedger value,
          $Res Function(_$_TransactionTokenLedger) then) =
      __$$_TransactionTokenLedgerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TransactionTokenTransfer> transfers});
}

/// @nodoc
class __$$_TransactionTokenLedgerCopyWithImpl<$Res>
    extends _$TransactionTokenLedgerCopyWithImpl<$Res,
        _$_TransactionTokenLedger>
    implements _$$_TransactionTokenLedgerCopyWith<$Res> {
  __$$_TransactionTokenLedgerCopyWithImpl(_$_TransactionTokenLedger _value,
      $Res Function(_$_TransactionTokenLedger) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transfers = null,
  }) {
    return _then(_$_TransactionTokenLedger(
      transfers: null == transfers
          ? _value._transfers
          : transfers // ignore: cast_nullable_to_non_nullable
              as List<TransactionTokenTransfer>,
    ));
  }
}

/// @nodoc

class _$_TransactionTokenLedger extends _TransactionTokenLedger {
  const _$_TransactionTokenLedger(
      {required final List<TransactionTokenTransfer> transfers})
      : _transfers = transfers,
        super._();

  final List<TransactionTokenTransfer> _transfers;
  @override
  List<TransactionTokenTransfer> get transfers {
    if (_transfers is EqualUnmodifiableListView) return _transfers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transfers);
  }

  @override
  String toString() {
    return 'TransactionTokenLedger(transfers: $transfers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionTokenLedger &&
            const DeepCollectionEquality()
                .equals(other._transfers, _transfers));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_transfers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionTokenLedgerCopyWith<_$_TransactionTokenLedger> get copyWith =>
      __$$_TransactionTokenLedgerCopyWithImpl<_$_TransactionTokenLedger>(
          this, _$identity);
}

abstract class _TransactionTokenLedger extends TransactionTokenLedger {
  const factory _TransactionTokenLedger(
          {required final List<TransactionTokenTransfer> transfers}) =
      _$_TransactionTokenLedger;
  const _TransactionTokenLedger._() : super._();

  @override
  List<TransactionTokenTransfer> get transfers;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionTokenLedgerCopyWith<_$_TransactionTokenLedger> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TransactionUcoTransfer {
  int get amount => throw _privateConstructorUsedError;
  String get to => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransactionUcoTransferCopyWith<TransactionUcoTransfer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionUcoTransferCopyWith<$Res> {
  factory $TransactionUcoTransferCopyWith(TransactionUcoTransfer value,
          $Res Function(TransactionUcoTransfer) then) =
      _$TransactionUcoTransferCopyWithImpl<$Res, TransactionUcoTransfer>;
  @useResult
  $Res call({int amount, String to});
}

/// @nodoc
class _$TransactionUcoTransferCopyWithImpl<$Res,
        $Val extends TransactionUcoTransfer>
    implements $TransactionUcoTransferCopyWith<$Res> {
  _$TransactionUcoTransferCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? to = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransactionUcoTransferCopyWith<$Res>
    implements $TransactionUcoTransferCopyWith<$Res> {
  factory _$$_TransactionUcoTransferCopyWith(_$_TransactionUcoTransfer value,
          $Res Function(_$_TransactionUcoTransfer) then) =
      __$$_TransactionUcoTransferCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int amount, String to});
}

/// @nodoc
class __$$_TransactionUcoTransferCopyWithImpl<$Res>
    extends _$TransactionUcoTransferCopyWithImpl<$Res,
        _$_TransactionUcoTransfer>
    implements _$$_TransactionUcoTransferCopyWith<$Res> {
  __$$_TransactionUcoTransferCopyWithImpl(_$_TransactionUcoTransfer _value,
      $Res Function(_$_TransactionUcoTransfer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? to = null,
  }) {
    return _then(_$_TransactionUcoTransfer(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_TransactionUcoTransfer extends _TransactionUcoTransfer {
  const _$_TransactionUcoTransfer({required this.amount, required this.to})
      : super._();

  @override
  final int amount;
  @override
  final String to;

  @override
  String toString() {
    return 'TransactionUcoTransfer(amount: $amount, to: $to)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionUcoTransfer &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.to, to) || other.to == to));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amount, to);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionUcoTransferCopyWith<_$_TransactionUcoTransfer> get copyWith =>
      __$$_TransactionUcoTransferCopyWithImpl<_$_TransactionUcoTransfer>(
          this, _$identity);
}

abstract class _TransactionUcoTransfer extends TransactionUcoTransfer {
  const factory _TransactionUcoTransfer(
      {required final int amount,
      required final String to}) = _$_TransactionUcoTransfer;
  const _TransactionUcoTransfer._() : super._();

  @override
  int get amount;
  @override
  String get to;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionUcoTransferCopyWith<_$_TransactionUcoTransfer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TransactionUCOLedger {
  List<TransactionUcoTransfer> get transfers =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransactionUCOLedgerCopyWith<TransactionUCOLedger> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionUCOLedgerCopyWith<$Res> {
  factory $TransactionUCOLedgerCopyWith(TransactionUCOLedger value,
          $Res Function(TransactionUCOLedger) then) =
      _$TransactionUCOLedgerCopyWithImpl<$Res, TransactionUCOLedger>;
  @useResult
  $Res call({List<TransactionUcoTransfer> transfers});
}

/// @nodoc
class _$TransactionUCOLedgerCopyWithImpl<$Res,
        $Val extends TransactionUCOLedger>
    implements $TransactionUCOLedgerCopyWith<$Res> {
  _$TransactionUCOLedgerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transfers = null,
  }) {
    return _then(_value.copyWith(
      transfers: null == transfers
          ? _value.transfers
          : transfers // ignore: cast_nullable_to_non_nullable
              as List<TransactionUcoTransfer>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransactionUCOLedgerCopyWith<$Res>
    implements $TransactionUCOLedgerCopyWith<$Res> {
  factory _$$_TransactionUCOLedgerCopyWith(_$_TransactionUCOLedger value,
          $Res Function(_$_TransactionUCOLedger) then) =
      __$$_TransactionUCOLedgerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TransactionUcoTransfer> transfers});
}

/// @nodoc
class __$$_TransactionUCOLedgerCopyWithImpl<$Res>
    extends _$TransactionUCOLedgerCopyWithImpl<$Res, _$_TransactionUCOLedger>
    implements _$$_TransactionUCOLedgerCopyWith<$Res> {
  __$$_TransactionUCOLedgerCopyWithImpl(_$_TransactionUCOLedger _value,
      $Res Function(_$_TransactionUCOLedger) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transfers = null,
  }) {
    return _then(_$_TransactionUCOLedger(
      transfers: null == transfers
          ? _value._transfers
          : transfers // ignore: cast_nullable_to_non_nullable
              as List<TransactionUcoTransfer>,
    ));
  }
}

/// @nodoc

class _$_TransactionUCOLedger extends _TransactionUCOLedger {
  const _$_TransactionUCOLedger(
      {required final List<TransactionUcoTransfer> transfers})
      : _transfers = transfers,
        super._();

  final List<TransactionUcoTransfer> _transfers;
  @override
  List<TransactionUcoTransfer> get transfers {
    if (_transfers is EqualUnmodifiableListView) return _transfers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transfers);
  }

  @override
  String toString() {
    return 'TransactionUCOLedger(transfers: $transfers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionUCOLedger &&
            const DeepCollectionEquality()
                .equals(other._transfers, _transfers));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_transfers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionUCOLedgerCopyWith<_$_TransactionUCOLedger> get copyWith =>
      __$$_TransactionUCOLedgerCopyWithImpl<_$_TransactionUCOLedger>(
          this, _$identity);
}

abstract class _TransactionUCOLedger extends TransactionUCOLedger {
  const factory _TransactionUCOLedger(
          {required final List<TransactionUcoTransfer> transfers}) =
      _$_TransactionUCOLedger;
  const _TransactionUCOLedger._() : super._();

  @override
  List<TransactionUcoTransfer> get transfers;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionUCOLedgerCopyWith<_$_TransactionUCOLedger> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TransactionLedger {
  TransactionTokenLedger? get token => throw _privateConstructorUsedError;
  TransactionUCOLedger? get uco => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransactionLedgerCopyWith<TransactionLedger> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionLedgerCopyWith<$Res> {
  factory $TransactionLedgerCopyWith(
          TransactionLedger value, $Res Function(TransactionLedger) then) =
      _$TransactionLedgerCopyWithImpl<$Res, TransactionLedger>;
  @useResult
  $Res call({TransactionTokenLedger? token, TransactionUCOLedger? uco});

  $TransactionTokenLedgerCopyWith<$Res>? get token;
  $TransactionUCOLedgerCopyWith<$Res>? get uco;
}

/// @nodoc
class _$TransactionLedgerCopyWithImpl<$Res, $Val extends TransactionLedger>
    implements $TransactionLedgerCopyWith<$Res> {
  _$TransactionLedgerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? uco = freezed,
  }) {
    return _then(_value.copyWith(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as TransactionTokenLedger?,
      uco: freezed == uco
          ? _value.uco
          : uco // ignore: cast_nullable_to_non_nullable
              as TransactionUCOLedger?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TransactionTokenLedgerCopyWith<$Res>? get token {
    if (_value.token == null) {
      return null;
    }

    return $TransactionTokenLedgerCopyWith<$Res>(_value.token!, (value) {
      return _then(_value.copyWith(token: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TransactionUCOLedgerCopyWith<$Res>? get uco {
    if (_value.uco == null) {
      return null;
    }

    return $TransactionUCOLedgerCopyWith<$Res>(_value.uco!, (value) {
      return _then(_value.copyWith(uco: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TransactionLedgerCopyWith<$Res>
    implements $TransactionLedgerCopyWith<$Res> {
  factory _$$_TransactionLedgerCopyWith(_$_TransactionLedger value,
          $Res Function(_$_TransactionLedger) then) =
      __$$_TransactionLedgerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TransactionTokenLedger? token, TransactionUCOLedger? uco});

  @override
  $TransactionTokenLedgerCopyWith<$Res>? get token;
  @override
  $TransactionUCOLedgerCopyWith<$Res>? get uco;
}

/// @nodoc
class __$$_TransactionLedgerCopyWithImpl<$Res>
    extends _$TransactionLedgerCopyWithImpl<$Res, _$_TransactionLedger>
    implements _$$_TransactionLedgerCopyWith<$Res> {
  __$$_TransactionLedgerCopyWithImpl(
      _$_TransactionLedger _value, $Res Function(_$_TransactionLedger) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? uco = freezed,
  }) {
    return _then(_$_TransactionLedger(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as TransactionTokenLedger?,
      uco: freezed == uco
          ? _value.uco
          : uco // ignore: cast_nullable_to_non_nullable
              as TransactionUCOLedger?,
    ));
  }
}

/// @nodoc

class _$_TransactionLedger extends _TransactionLedger {
  const _$_TransactionLedger({this.token, this.uco}) : super._();

  @override
  final TransactionTokenLedger? token;
  @override
  final TransactionUCOLedger? uco;

  @override
  String toString() {
    return 'TransactionLedger(token: $token, uco: $uco)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionLedger &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.uco, uco) || other.uco == uco));
  }

  @override
  int get hashCode => Object.hash(runtimeType, token, uco);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionLedgerCopyWith<_$_TransactionLedger> get copyWith =>
      __$$_TransactionLedgerCopyWithImpl<_$_TransactionLedger>(
          this, _$identity);
}

abstract class _TransactionLedger extends TransactionLedger {
  const factory _TransactionLedger(
      {final TransactionTokenLedger? token,
      final TransactionUCOLedger? uco}) = _$_TransactionLedger;
  const _TransactionLedger._() : super._();

  @override
  TransactionTokenLedger? get token;
  @override
  TransactionUCOLedger? get uco;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionLedgerCopyWith<_$_TransactionLedger> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TransactionAuthorizedKey {
  String get publicKey => throw _privateConstructorUsedError;
  String get encryptedSecretKey => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransactionAuthorizedKeyCopyWith<TransactionAuthorizedKey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionAuthorizedKeyCopyWith<$Res> {
  factory $TransactionAuthorizedKeyCopyWith(TransactionAuthorizedKey value,
          $Res Function(TransactionAuthorizedKey) then) =
      _$TransactionAuthorizedKeyCopyWithImpl<$Res, TransactionAuthorizedKey>;
  @useResult
  $Res call({String publicKey, String encryptedSecretKey});
}

/// @nodoc
class _$TransactionAuthorizedKeyCopyWithImpl<$Res,
        $Val extends TransactionAuthorizedKey>
    implements $TransactionAuthorizedKeyCopyWith<$Res> {
  _$TransactionAuthorizedKeyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
    Object? encryptedSecretKey = null,
  }) {
    return _then(_value.copyWith(
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
      encryptedSecretKey: null == encryptedSecretKey
          ? _value.encryptedSecretKey
          : encryptedSecretKey // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransactionAuthorizedKeyCopyWith<$Res>
    implements $TransactionAuthorizedKeyCopyWith<$Res> {
  factory _$$_TransactionAuthorizedKeyCopyWith(
          _$_TransactionAuthorizedKey value,
          $Res Function(_$_TransactionAuthorizedKey) then) =
      __$$_TransactionAuthorizedKeyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String publicKey, String encryptedSecretKey});
}

/// @nodoc
class __$$_TransactionAuthorizedKeyCopyWithImpl<$Res>
    extends _$TransactionAuthorizedKeyCopyWithImpl<$Res,
        _$_TransactionAuthorizedKey>
    implements _$$_TransactionAuthorizedKeyCopyWith<$Res> {
  __$$_TransactionAuthorizedKeyCopyWithImpl(_$_TransactionAuthorizedKey _value,
      $Res Function(_$_TransactionAuthorizedKey) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
    Object? encryptedSecretKey = null,
  }) {
    return _then(_$_TransactionAuthorizedKey(
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
      encryptedSecretKey: null == encryptedSecretKey
          ? _value.encryptedSecretKey
          : encryptedSecretKey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_TransactionAuthorizedKey extends _TransactionAuthorizedKey {
  const _$_TransactionAuthorizedKey(
      {required this.publicKey, required this.encryptedSecretKey})
      : super._();

  @override
  final String publicKey;
  @override
  final String encryptedSecretKey;

  @override
  String toString() {
    return 'TransactionAuthorizedKey(publicKey: $publicKey, encryptedSecretKey: $encryptedSecretKey)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionAuthorizedKey &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey) &&
            (identical(other.encryptedSecretKey, encryptedSecretKey) ||
                other.encryptedSecretKey == encryptedSecretKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, publicKey, encryptedSecretKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionAuthorizedKeyCopyWith<_$_TransactionAuthorizedKey>
      get copyWith => __$$_TransactionAuthorizedKeyCopyWithImpl<
          _$_TransactionAuthorizedKey>(this, _$identity);
}

abstract class _TransactionAuthorizedKey extends TransactionAuthorizedKey {
  const factory _TransactionAuthorizedKey(
      {required final String publicKey,
      required final String encryptedSecretKey}) = _$_TransactionAuthorizedKey;
  const _TransactionAuthorizedKey._() : super._();

  @override
  String get publicKey;
  @override
  String get encryptedSecretKey;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionAuthorizedKeyCopyWith<_$_TransactionAuthorizedKey>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TransactionOwnership {
  List<TransactionAuthorizedKey>? get authorizedPublicKeys =>
      throw _privateConstructorUsedError;
  String? get secret => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransactionOwnershipCopyWith<TransactionOwnership> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionOwnershipCopyWith<$Res> {
  factory $TransactionOwnershipCopyWith(TransactionOwnership value,
          $Res Function(TransactionOwnership) then) =
      _$TransactionOwnershipCopyWithImpl<$Res, TransactionOwnership>;
  @useResult
  $Res call(
      {List<TransactionAuthorizedKey>? authorizedPublicKeys, String? secret});
}

/// @nodoc
class _$TransactionOwnershipCopyWithImpl<$Res,
        $Val extends TransactionOwnership>
    implements $TransactionOwnershipCopyWith<$Res> {
  _$TransactionOwnershipCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authorizedPublicKeys = freezed,
    Object? secret = freezed,
  }) {
    return _then(_value.copyWith(
      authorizedPublicKeys: freezed == authorizedPublicKeys
          ? _value.authorizedPublicKeys
          : authorizedPublicKeys // ignore: cast_nullable_to_non_nullable
              as List<TransactionAuthorizedKey>?,
      secret: freezed == secret
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransactionOwnershipCopyWith<$Res>
    implements $TransactionOwnershipCopyWith<$Res> {
  factory _$$_TransactionOwnershipCopyWith(_$_TransactionOwnership value,
          $Res Function(_$_TransactionOwnership) then) =
      __$$_TransactionOwnershipCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TransactionAuthorizedKey>? authorizedPublicKeys, String? secret});
}

/// @nodoc
class __$$_TransactionOwnershipCopyWithImpl<$Res>
    extends _$TransactionOwnershipCopyWithImpl<$Res, _$_TransactionOwnership>
    implements _$$_TransactionOwnershipCopyWith<$Res> {
  __$$_TransactionOwnershipCopyWithImpl(_$_TransactionOwnership _value,
      $Res Function(_$_TransactionOwnership) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authorizedPublicKeys = freezed,
    Object? secret = freezed,
  }) {
    return _then(_$_TransactionOwnership(
      authorizedPublicKeys: freezed == authorizedPublicKeys
          ? _value._authorizedPublicKeys
          : authorizedPublicKeys // ignore: cast_nullable_to_non_nullable
              as List<TransactionAuthorizedKey>?,
      secret: freezed == secret
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_TransactionOwnership extends _TransactionOwnership {
  const _$_TransactionOwnership(
      {final List<TransactionAuthorizedKey>? authorizedPublicKeys, this.secret})
      : _authorizedPublicKeys = authorizedPublicKeys,
        super._();

  final List<TransactionAuthorizedKey>? _authorizedPublicKeys;
  @override
  List<TransactionAuthorizedKey>? get authorizedPublicKeys {
    final value = _authorizedPublicKeys;
    if (value == null) return null;
    if (_authorizedPublicKeys is EqualUnmodifiableListView)
      return _authorizedPublicKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? secret;

  @override
  String toString() {
    return 'TransactionOwnership(authorizedPublicKeys: $authorizedPublicKeys, secret: $secret)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionOwnership &&
            const DeepCollectionEquality()
                .equals(other._authorizedPublicKeys, _authorizedPublicKeys) &&
            (identical(other.secret, secret) || other.secret == secret));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_authorizedPublicKeys), secret);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionOwnershipCopyWith<_$_TransactionOwnership> get copyWith =>
      __$$_TransactionOwnershipCopyWithImpl<_$_TransactionOwnership>(
          this, _$identity);
}

abstract class _TransactionOwnership extends TransactionOwnership {
  const factory _TransactionOwnership(
      {final List<TransactionAuthorizedKey>? authorizedPublicKeys,
      final String? secret}) = _$_TransactionOwnership;
  const _TransactionOwnership._() : super._();

  @override
  List<TransactionAuthorizedKey>? get authorizedPublicKeys;
  @override
  String? get secret;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionOwnershipCopyWith<_$_TransactionOwnership> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TransactionData {
  /// Code: smart contract code (hexadecimal),
  String get code => throw _privateConstructorUsedError;

  /// Content: free zone for data hosting (string or hexadecimal)
  String? get content => throw _privateConstructorUsedError;

  /// Ownership: authorization/delegations containing list of secrets and their authorized public keys to proof the ownership
  List<TransactionOwnership> get ownerships =>
      throw _privateConstructorUsedError;

  /// Ledger: asset transfers
  TransactionLedger get ledger => throw _privateConstructorUsedError;

  /// Recipients: For non asset transfers, the list of recipients of the transaction (e.g Smart contract interactions)
  List<String>? get recipients => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransactionDataCopyWith<TransactionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionDataCopyWith<$Res> {
  factory $TransactionDataCopyWith(
          TransactionData value, $Res Function(TransactionData) then) =
      _$TransactionDataCopyWithImpl<$Res, TransactionData>;
  @useResult
  $Res call(
      {String code,
      String? content,
      List<TransactionOwnership> ownerships,
      TransactionLedger ledger,
      List<String>? recipients});

  $TransactionLedgerCopyWith<$Res> get ledger;
}

/// @nodoc
class _$TransactionDataCopyWithImpl<$Res, $Val extends TransactionData>
    implements $TransactionDataCopyWith<$Res> {
  _$TransactionDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? content = freezed,
    Object? ownerships = null,
    Object? ledger = null,
    Object? recipients = freezed,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerships: null == ownerships
          ? _value.ownerships
          : ownerships // ignore: cast_nullable_to_non_nullable
              as List<TransactionOwnership>,
      ledger: null == ledger
          ? _value.ledger
          : ledger // ignore: cast_nullable_to_non_nullable
              as TransactionLedger,
      recipients: freezed == recipients
          ? _value.recipients
          : recipients // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TransactionLedgerCopyWith<$Res> get ledger {
    return $TransactionLedgerCopyWith<$Res>(_value.ledger, (value) {
      return _then(_value.copyWith(ledger: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TransactionDataCopyWith<$Res>
    implements $TransactionDataCopyWith<$Res> {
  factory _$$_TransactionDataCopyWith(
          _$_TransactionData value, $Res Function(_$_TransactionData) then) =
      __$$_TransactionDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String code,
      String? content,
      List<TransactionOwnership> ownerships,
      TransactionLedger ledger,
      List<String>? recipients});

  @override
  $TransactionLedgerCopyWith<$Res> get ledger;
}

/// @nodoc
class __$$_TransactionDataCopyWithImpl<$Res>
    extends _$TransactionDataCopyWithImpl<$Res, _$_TransactionData>
    implements _$$_TransactionDataCopyWith<$Res> {
  __$$_TransactionDataCopyWithImpl(
      _$_TransactionData _value, $Res Function(_$_TransactionData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? content = freezed,
    Object? ownerships = null,
    Object? ledger = null,
    Object? recipients = freezed,
  }) {
    return _then(_$_TransactionData(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerships: null == ownerships
          ? _value._ownerships
          : ownerships // ignore: cast_nullable_to_non_nullable
              as List<TransactionOwnership>,
      ledger: null == ledger
          ? _value.ledger
          : ledger // ignore: cast_nullable_to_non_nullable
              as TransactionLedger,
      recipients: freezed == recipients
          ? _value._recipients
          : recipients // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

class _$_TransactionData extends _TransactionData {
  const _$_TransactionData(
      {required this.code,
      required this.content,
      required final List<TransactionOwnership> ownerships,
      required this.ledger,
      final List<String>? recipients})
      : _ownerships = ownerships,
        _recipients = recipients,
        super._();

  /// Code: smart contract code (hexadecimal),
  @override
  final String code;

  /// Content: free zone for data hosting (string or hexadecimal)
  @override
  final String? content;

  /// Ownership: authorization/delegations containing list of secrets and their authorized public keys to proof the ownership
  final List<TransactionOwnership> _ownerships;

  /// Ownership: authorization/delegations containing list of secrets and their authorized public keys to proof the ownership
  @override
  List<TransactionOwnership> get ownerships {
    if (_ownerships is EqualUnmodifiableListView) return _ownerships;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ownerships);
  }

  /// Ledger: asset transfers
  @override
  final TransactionLedger ledger;

  /// Recipients: For non asset transfers, the list of recipients of the transaction (e.g Smart contract interactions)
  final List<String>? _recipients;

  /// Recipients: For non asset transfers, the list of recipients of the transaction (e.g Smart contract interactions)
  @override
  List<String>? get recipients {
    final value = _recipients;
    if (value == null) return null;
    if (_recipients is EqualUnmodifiableListView) return _recipients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TransactionData(code: $code, content: $content, ownerships: $ownerships, ledger: $ledger, recipients: $recipients)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionData &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality()
                .equals(other._ownerships, _ownerships) &&
            (identical(other.ledger, ledger) || other.ledger == ledger) &&
            const DeepCollectionEquality()
                .equals(other._recipients, _recipients));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      code,
      content,
      const DeepCollectionEquality().hash(_ownerships),
      ledger,
      const DeepCollectionEquality().hash(_recipients));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionDataCopyWith<_$_TransactionData> get copyWith =>
      __$$_TransactionDataCopyWithImpl<_$_TransactionData>(this, _$identity);
}

abstract class _TransactionData extends TransactionData {
  const factory _TransactionData(
      {required final String code,
      required final String? content,
      required final List<TransactionOwnership> ownerships,
      required final TransactionLedger ledger,
      final List<String>? recipients}) = _$_TransactionData;
  const _TransactionData._() : super._();

  @override

  /// Code: smart contract code (hexadecimal),
  String get code;
  @override

  /// Content: free zone for data hosting (string or hexadecimal)
  String? get content;
  @override

  /// Ownership: authorization/delegations containing list of secrets and their authorized public keys to proof the ownership
  List<TransactionOwnership> get ownerships;
  @override

  /// Ledger: asset transfers
  TransactionLedger get ledger;
  @override

  /// Recipients: For non asset transfers, the list of recipients of the transaction (e.g Smart contract interactions)
  List<String>? get recipients;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionDataCopyWith<_$_TransactionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SignTransactionCommand {
  /// Service
  String get accountName => throw _privateConstructorUsedError;

  /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
  archethic.Data get data => throw _privateConstructorUsedError;

  /// - Type: transaction type
  String get type => throw _privateConstructorUsedError;

  /// - Version: version of the transaction (used for backward compatiblity)
  int get version => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignTransactionCommandCopyWith<SignTransactionCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignTransactionCommandCopyWith<$Res> {
  factory $SignTransactionCommandCopyWith(SignTransactionCommand value,
          $Res Function(SignTransactionCommand) then) =
      _$SignTransactionCommandCopyWithImpl<$Res, SignTransactionCommand>;
  @useResult
  $Res call(
      {String accountName, archethic.Data data, String type, int version});
}

/// @nodoc
class _$SignTransactionCommandCopyWithImpl<$Res,
        $Val extends SignTransactionCommand>
    implements $SignTransactionCommandCopyWith<$Res> {
  _$SignTransactionCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountName = null,
    Object? data = null,
    Object? type = null,
    Object? version = null,
  }) {
    return _then(_value.copyWith(
      accountName: null == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as archethic.Data,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SignTransactionCommandCopyWith<$Res>
    implements $SignTransactionCommandCopyWith<$Res> {
  factory _$$_SignTransactionCommandCopyWith(_$_SignTransactionCommand value,
          $Res Function(_$_SignTransactionCommand) then) =
      __$$_SignTransactionCommandCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String accountName, archethic.Data data, String type, int version});
}

/// @nodoc
class __$$_SignTransactionCommandCopyWithImpl<$Res>
    extends _$SignTransactionCommandCopyWithImpl<$Res,
        _$_SignTransactionCommand>
    implements _$$_SignTransactionCommandCopyWith<$Res> {
  __$$_SignTransactionCommandCopyWithImpl(_$_SignTransactionCommand _value,
      $Res Function(_$_SignTransactionCommand) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountName = null,
    Object? data = null,
    Object? type = null,
    Object? version = null,
  }) {
    return _then(_$_SignTransactionCommand(
      accountName: null == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as archethic.Data,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_SignTransactionCommand extends _SignTransactionCommand {
  const _$_SignTransactionCommand(
      {required this.accountName,
      required this.data,
      required this.type,
      required this.version})
      : super._();

  /// Service
  @override
  final String accountName;

  /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
  @override
  final archethic.Data data;

  /// - Type: transaction type
  @override
  final String type;

  /// - Version: version of the transaction (used for backward compatiblity)
  @override
  final int version;

  @override
  String toString() {
    return 'SignTransactionCommand(accountName: $accountName, data: $data, type: $type, version: $version)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignTransactionCommand &&
            (identical(other.accountName, accountName) ||
                other.accountName == accountName) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.version, version) || other.version == version));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, accountName, data, type, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SignTransactionCommandCopyWith<_$_SignTransactionCommand> get copyWith =>
      __$$_SignTransactionCommandCopyWithImpl<_$_SignTransactionCommand>(
          this, _$identity);
}

abstract class _SignTransactionCommand extends SignTransactionCommand {
  const factory _SignTransactionCommand(
      {required final String accountName,
      required final archethic.Data data,
      required final String type,
      required final int version}) = _$_SignTransactionCommand;
  const _SignTransactionCommand._() : super._();

  @override

  /// Service
  String get accountName;
  @override

  /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
  archethic.Data get data;
  @override

  /// - Type: transaction type
  String get type;
  @override

  /// - Version: version of the transaction (used for backward compatiblity)
  int get version;
  @override
  @JsonKey(ignore: true)
  _$$_SignTransactionCommandCopyWith<_$_SignTransactionCommand> get copyWith =>
      throw _privateConstructorUsedError;
}
