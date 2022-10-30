// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Transaction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Transfer transfer) transfer,
    required TResult Function(Token token) token,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Transfer transfer)? transfer,
    TResult? Function(Token token)? token,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Transfer transfer)? transfer,
    TResult Function(Token token)? token,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransactionTransfer value) transfer,
    required TResult Function(_TransactionToken value) token,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransactionTransfer value)? transfer,
    TResult? Function(_TransactionToken value)? token,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransactionTransfer value)? transfer,
    TResult Function(_TransactionToken value)? token,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
          Transaction value, $Res Function(Transaction) then) =
      _$TransactionCopyWithImpl<$Res, Transaction>;
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res, $Val extends Transaction>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_TransactionTransferCopyWith<$Res> {
  factory _$$_TransactionTransferCopyWith(_$_TransactionTransfer value,
          $Res Function(_$_TransactionTransfer) then) =
      __$$_TransactionTransferCopyWithImpl<$Res>;
  @useResult
  $Res call({Transfer transfer});

  $TransferCopyWith<$Res> get transfer;
}

/// @nodoc
class __$$_TransactionTransferCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res, _$_TransactionTransfer>
    implements _$$_TransactionTransferCopyWith<$Res> {
  __$$_TransactionTransferCopyWithImpl(_$_TransactionTransfer _value,
      $Res Function(_$_TransactionTransfer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transfer = null,
  }) {
    return _then(_$_TransactionTransfer(
      transfer: null == transfer
          ? _value.transfer
          : transfer // ignore: cast_nullable_to_non_nullable
              as Transfer,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $TransferCopyWith<$Res> get transfer {
    return $TransferCopyWith<$Res>(_value.transfer, (value) {
      return _then(_value.copyWith(transfer: value));
    });
  }
}

/// @nodoc

class _$_TransactionTransfer extends _TransactionTransfer {
  const _$_TransactionTransfer({required this.transfer}) : super._();

  @override
  final Transfer transfer;

  @override
  String toString() {
    return 'Transaction.transfer(transfer: $transfer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionTransfer &&
            (identical(other.transfer, transfer) ||
                other.transfer == transfer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transfer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionTransferCopyWith<_$_TransactionTransfer> get copyWith =>
      __$$_TransactionTransferCopyWithImpl<_$_TransactionTransfer>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Transfer transfer) transfer,
    required TResult Function(Token token) token,
  }) {
    return transfer(this.transfer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Transfer transfer)? transfer,
    TResult? Function(Token token)? token,
  }) {
    return transfer?.call(this.transfer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Transfer transfer)? transfer,
    TResult Function(Token token)? token,
    required TResult orElse(),
  }) {
    if (transfer != null) {
      return transfer(this.transfer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransactionTransfer value) transfer,
    required TResult Function(_TransactionToken value) token,
  }) {
    return transfer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransactionTransfer value)? transfer,
    TResult? Function(_TransactionToken value)? token,
  }) {
    return transfer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransactionTransfer value)? transfer,
    TResult Function(_TransactionToken value)? token,
    required TResult orElse(),
  }) {
    if (transfer != null) {
      return transfer(this);
    }
    return orElse();
  }
}

abstract class _TransactionTransfer extends Transaction {
  const factory _TransactionTransfer({required final Transfer transfer}) =
      _$_TransactionTransfer;
  const _TransactionTransfer._() : super._();

  Transfer get transfer;
  @JsonKey(ignore: true)
  _$$_TransactionTransferCopyWith<_$_TransactionTransfer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_TransactionTokenCopyWith<$Res> {
  factory _$$_TransactionTokenCopyWith(
          _$_TransactionToken value, $Res Function(_$_TransactionToken) then) =
      __$$_TransactionTokenCopyWithImpl<$Res>;
  @useResult
  $Res call({Token token});

  $TokenCopyWith<$Res> get token;
}

/// @nodoc
class __$$_TransactionTokenCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res, _$_TransactionToken>
    implements _$$_TransactionTokenCopyWith<$Res> {
  __$$_TransactionTokenCopyWithImpl(
      _$_TransactionToken _value, $Res Function(_$_TransactionToken) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_$_TransactionToken(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as Token,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $TokenCopyWith<$Res> get token {
    return $TokenCopyWith<$Res>(_value.token, (value) {
      return _then(_value.copyWith(token: value));
    });
  }
}

/// @nodoc

class _$_TransactionToken extends _TransactionToken {
  const _$_TransactionToken({required this.token}) : super._();

  @override
  final Token token;

  @override
  String toString() {
    return 'Transaction.token(token: $token)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionToken &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionTokenCopyWith<_$_TransactionToken> get copyWith =>
      __$$_TransactionTokenCopyWithImpl<_$_TransactionToken>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Transfer transfer) transfer,
    required TResult Function(Token token) token,
  }) {
    return token(this.token);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Transfer transfer)? transfer,
    TResult? Function(Token token)? token,
  }) {
    return token?.call(this.token);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Transfer transfer)? transfer,
    TResult Function(Token token)? token,
    required TResult orElse(),
  }) {
    if (token != null) {
      return token(this.token);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransactionTransfer value) transfer,
    required TResult Function(_TransactionToken value) token,
  }) {
    return token(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransactionTransfer value)? transfer,
    TResult? Function(_TransactionToken value)? token,
  }) {
    return token?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransactionTransfer value)? transfer,
    TResult Function(_TransactionToken value)? token,
    required TResult orElse(),
  }) {
    if (token != null) {
      return token(this);
    }
    return orElse();
  }
}

abstract class _TransactionToken extends Transaction {
  const factory _TransactionToken({required final Token token}) =
      _$_TransactionToken;
  const _TransactionToken._() : super._();

  Token get token;
  @JsonKey(ignore: true)
  _$$_TransactionTokenCopyWith<_$_TransactionToken> get copyWith =>
      throw _privateConstructorUsedError;
}
