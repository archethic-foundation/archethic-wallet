// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TransactionError {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() timeout,
    required TResult Function() connectivity,
    required TResult Function() consensusNotReached,
    required TResult Function() invalidTransaction,
    required TResult Function() invalidConfirmation,
    required TResult Function() insufficientFunds,
    required TResult Function() userRejected,
    required TResult Function(String accountName) unknownAccount,
    required TResult Function(String? reason) other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? timeout,
    TResult? Function()? connectivity,
    TResult? Function()? consensusNotReached,
    TResult? Function()? invalidTransaction,
    TResult? Function()? invalidConfirmation,
    TResult? Function()? insufficientFunds,
    TResult? Function()? userRejected,
    TResult? Function(String accountName)? unknownAccount,
    TResult? Function(String? reason)? other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? timeout,
    TResult Function()? connectivity,
    TResult Function()? consensusNotReached,
    TResult Function()? invalidTransaction,
    TResult Function()? invalidConfirmation,
    TResult Function()? insufficientFunds,
    TResult Function()? userRejected,
    TResult Function(String accountName)? unknownAccount,
    TResult Function(String? reason)? other,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransactionTimeout value) timeout,
    required TResult Function(_TransactionConnectionError value) connectivity,
    required TResult Function(_TransactionConsensusNotReachedError value)
        consensusNotReached,
    required TResult Function(_TransactionInvalid value) invalidTransaction,
    required TResult Function(_TransactionInvalidConfirmation value)
        invalidConfirmation,
    required TResult Function(_TransactionInsufficientFunds value)
        insufficientFunds,
    required TResult Function(_TransactionUserRejected value) userRejected,
    required TResult Function(_TransactionUnknownAccount value) unknownAccount,
    required TResult Function(_TransactionOtherError value) other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransactionTimeout value)? timeout,
    TResult? Function(_TransactionConnectionError value)? connectivity,
    TResult? Function(_TransactionConsensusNotReachedError value)?
        consensusNotReached,
    TResult? Function(_TransactionInvalid value)? invalidTransaction,
    TResult? Function(_TransactionInvalidConfirmation value)?
        invalidConfirmation,
    TResult? Function(_TransactionInsufficientFunds value)? insufficientFunds,
    TResult? Function(_TransactionUserRejected value)? userRejected,
    TResult? Function(_TransactionUnknownAccount value)? unknownAccount,
    TResult? Function(_TransactionOtherError value)? other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransactionTimeout value)? timeout,
    TResult Function(_TransactionConnectionError value)? connectivity,
    TResult Function(_TransactionConsensusNotReachedError value)?
        consensusNotReached,
    TResult Function(_TransactionInvalid value)? invalidTransaction,
    TResult Function(_TransactionInvalidConfirmation value)?
        invalidConfirmation,
    TResult Function(_TransactionInsufficientFunds value)? insufficientFunds,
    TResult Function(_TransactionUserRejected value)? userRejected,
    TResult Function(_TransactionUnknownAccount value)? unknownAccount,
    TResult Function(_TransactionOtherError value)? other,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionErrorCopyWith<$Res> {
  factory $TransactionErrorCopyWith(
          TransactionError value, $Res Function(TransactionError) then) =
      _$TransactionErrorCopyWithImpl<$Res, TransactionError>;
}

/// @nodoc
class _$TransactionErrorCopyWithImpl<$Res, $Val extends TransactionError>
    implements $TransactionErrorCopyWith<$Res> {
  _$TransactionErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_TransactionTimeoutCopyWith<$Res> {
  factory _$$_TransactionTimeoutCopyWith(_$_TransactionTimeout value,
          $Res Function(_$_TransactionTimeout) then) =
      __$$_TransactionTimeoutCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_TransactionTimeoutCopyWithImpl<$Res>
    extends _$TransactionErrorCopyWithImpl<$Res, _$_TransactionTimeout>
    implements _$$_TransactionTimeoutCopyWith<$Res> {
  __$$_TransactionTimeoutCopyWithImpl(
      _$_TransactionTimeout _value, $Res Function(_$_TransactionTimeout) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_TransactionTimeout extends _TransactionTimeout {
  const _$_TransactionTimeout() : super._();

  @override
  String toString() {
    return 'TransactionError.timeout()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_TransactionTimeout);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() timeout,
    required TResult Function() connectivity,
    required TResult Function() consensusNotReached,
    required TResult Function() invalidTransaction,
    required TResult Function() invalidConfirmation,
    required TResult Function() insufficientFunds,
    required TResult Function() userRejected,
    required TResult Function(String accountName) unknownAccount,
    required TResult Function(String? reason) other,
  }) {
    return timeout();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? timeout,
    TResult? Function()? connectivity,
    TResult? Function()? consensusNotReached,
    TResult? Function()? invalidTransaction,
    TResult? Function()? invalidConfirmation,
    TResult? Function()? insufficientFunds,
    TResult? Function()? userRejected,
    TResult? Function(String accountName)? unknownAccount,
    TResult? Function(String? reason)? other,
  }) {
    return timeout?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? timeout,
    TResult Function()? connectivity,
    TResult Function()? consensusNotReached,
    TResult Function()? invalidTransaction,
    TResult Function()? invalidConfirmation,
    TResult Function()? insufficientFunds,
    TResult Function()? userRejected,
    TResult Function(String accountName)? unknownAccount,
    TResult Function(String? reason)? other,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransactionTimeout value) timeout,
    required TResult Function(_TransactionConnectionError value) connectivity,
    required TResult Function(_TransactionConsensusNotReachedError value)
        consensusNotReached,
    required TResult Function(_TransactionInvalid value) invalidTransaction,
    required TResult Function(_TransactionInvalidConfirmation value)
        invalidConfirmation,
    required TResult Function(_TransactionInsufficientFunds value)
        insufficientFunds,
    required TResult Function(_TransactionUserRejected value) userRejected,
    required TResult Function(_TransactionUnknownAccount value) unknownAccount,
    required TResult Function(_TransactionOtherError value) other,
  }) {
    return timeout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransactionTimeout value)? timeout,
    TResult? Function(_TransactionConnectionError value)? connectivity,
    TResult? Function(_TransactionConsensusNotReachedError value)?
        consensusNotReached,
    TResult? Function(_TransactionInvalid value)? invalidTransaction,
    TResult? Function(_TransactionInvalidConfirmation value)?
        invalidConfirmation,
    TResult? Function(_TransactionInsufficientFunds value)? insufficientFunds,
    TResult? Function(_TransactionUserRejected value)? userRejected,
    TResult? Function(_TransactionUnknownAccount value)? unknownAccount,
    TResult? Function(_TransactionOtherError value)? other,
  }) {
    return timeout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransactionTimeout value)? timeout,
    TResult Function(_TransactionConnectionError value)? connectivity,
    TResult Function(_TransactionConsensusNotReachedError value)?
        consensusNotReached,
    TResult Function(_TransactionInvalid value)? invalidTransaction,
    TResult Function(_TransactionInvalidConfirmation value)?
        invalidConfirmation,
    TResult Function(_TransactionInsufficientFunds value)? insufficientFunds,
    TResult Function(_TransactionUserRejected value)? userRejected,
    TResult Function(_TransactionUnknownAccount value)? unknownAccount,
    TResult Function(_TransactionOtherError value)? other,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(this);
    }
    return orElse();
  }
}

abstract class _TransactionTimeout extends TransactionError {
  const factory _TransactionTimeout() = _$_TransactionTimeout;
  const _TransactionTimeout._() : super._();
}

/// @nodoc
abstract class _$$_TransactionConnectionErrorCopyWith<$Res> {
  factory _$$_TransactionConnectionErrorCopyWith(
          _$_TransactionConnectionError value,
          $Res Function(_$_TransactionConnectionError) then) =
      __$$_TransactionConnectionErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_TransactionConnectionErrorCopyWithImpl<$Res>
    extends _$TransactionErrorCopyWithImpl<$Res, _$_TransactionConnectionError>
    implements _$$_TransactionConnectionErrorCopyWith<$Res> {
  __$$_TransactionConnectionErrorCopyWithImpl(
      _$_TransactionConnectionError _value,
      $Res Function(_$_TransactionConnectionError) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_TransactionConnectionError extends _TransactionConnectionError {
  const _$_TransactionConnectionError() : super._();

  @override
  String toString() {
    return 'TransactionError.connectivity()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionConnectionError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() timeout,
    required TResult Function() connectivity,
    required TResult Function() consensusNotReached,
    required TResult Function() invalidTransaction,
    required TResult Function() invalidConfirmation,
    required TResult Function() insufficientFunds,
    required TResult Function() userRejected,
    required TResult Function(String accountName) unknownAccount,
    required TResult Function(String? reason) other,
  }) {
    return connectivity();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? timeout,
    TResult? Function()? connectivity,
    TResult? Function()? consensusNotReached,
    TResult? Function()? invalidTransaction,
    TResult? Function()? invalidConfirmation,
    TResult? Function()? insufficientFunds,
    TResult? Function()? userRejected,
    TResult? Function(String accountName)? unknownAccount,
    TResult? Function(String? reason)? other,
  }) {
    return connectivity?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? timeout,
    TResult Function()? connectivity,
    TResult Function()? consensusNotReached,
    TResult Function()? invalidTransaction,
    TResult Function()? invalidConfirmation,
    TResult Function()? insufficientFunds,
    TResult Function()? userRejected,
    TResult Function(String accountName)? unknownAccount,
    TResult Function(String? reason)? other,
    required TResult orElse(),
  }) {
    if (connectivity != null) {
      return connectivity();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransactionTimeout value) timeout,
    required TResult Function(_TransactionConnectionError value) connectivity,
    required TResult Function(_TransactionConsensusNotReachedError value)
        consensusNotReached,
    required TResult Function(_TransactionInvalid value) invalidTransaction,
    required TResult Function(_TransactionInvalidConfirmation value)
        invalidConfirmation,
    required TResult Function(_TransactionInsufficientFunds value)
        insufficientFunds,
    required TResult Function(_TransactionUserRejected value) userRejected,
    required TResult Function(_TransactionUnknownAccount value) unknownAccount,
    required TResult Function(_TransactionOtherError value) other,
  }) {
    return connectivity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransactionTimeout value)? timeout,
    TResult? Function(_TransactionConnectionError value)? connectivity,
    TResult? Function(_TransactionConsensusNotReachedError value)?
        consensusNotReached,
    TResult? Function(_TransactionInvalid value)? invalidTransaction,
    TResult? Function(_TransactionInvalidConfirmation value)?
        invalidConfirmation,
    TResult? Function(_TransactionInsufficientFunds value)? insufficientFunds,
    TResult? Function(_TransactionUserRejected value)? userRejected,
    TResult? Function(_TransactionUnknownAccount value)? unknownAccount,
    TResult? Function(_TransactionOtherError value)? other,
  }) {
    return connectivity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransactionTimeout value)? timeout,
    TResult Function(_TransactionConnectionError value)? connectivity,
    TResult Function(_TransactionConsensusNotReachedError value)?
        consensusNotReached,
    TResult Function(_TransactionInvalid value)? invalidTransaction,
    TResult Function(_TransactionInvalidConfirmation value)?
        invalidConfirmation,
    TResult Function(_TransactionInsufficientFunds value)? insufficientFunds,
    TResult Function(_TransactionUserRejected value)? userRejected,
    TResult Function(_TransactionUnknownAccount value)? unknownAccount,
    TResult Function(_TransactionOtherError value)? other,
    required TResult orElse(),
  }) {
    if (connectivity != null) {
      return connectivity(this);
    }
    return orElse();
  }
}

abstract class _TransactionConnectionError extends TransactionError {
  const factory _TransactionConnectionError() = _$_TransactionConnectionError;
  const _TransactionConnectionError._() : super._();
}

/// @nodoc
abstract class _$$_TransactionConsensusNotReachedErrorCopyWith<$Res> {
  factory _$$_TransactionConsensusNotReachedErrorCopyWith(
          _$_TransactionConsensusNotReachedError value,
          $Res Function(_$_TransactionConsensusNotReachedError) then) =
      __$$_TransactionConsensusNotReachedErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_TransactionConsensusNotReachedErrorCopyWithImpl<$Res>
    extends _$TransactionErrorCopyWithImpl<$Res,
        _$_TransactionConsensusNotReachedError>
    implements _$$_TransactionConsensusNotReachedErrorCopyWith<$Res> {
  __$$_TransactionConsensusNotReachedErrorCopyWithImpl(
      _$_TransactionConsensusNotReachedError _value,
      $Res Function(_$_TransactionConsensusNotReachedError) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_TransactionConsensusNotReachedError
    extends _TransactionConsensusNotReachedError {
  const _$_TransactionConsensusNotReachedError() : super._();

  @override
  String toString() {
    return 'TransactionError.consensusNotReached()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionConsensusNotReachedError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() timeout,
    required TResult Function() connectivity,
    required TResult Function() consensusNotReached,
    required TResult Function() invalidTransaction,
    required TResult Function() invalidConfirmation,
    required TResult Function() insufficientFunds,
    required TResult Function() userRejected,
    required TResult Function(String accountName) unknownAccount,
    required TResult Function(String? reason) other,
  }) {
    return consensusNotReached();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? timeout,
    TResult? Function()? connectivity,
    TResult? Function()? consensusNotReached,
    TResult? Function()? invalidTransaction,
    TResult? Function()? invalidConfirmation,
    TResult? Function()? insufficientFunds,
    TResult? Function()? userRejected,
    TResult? Function(String accountName)? unknownAccount,
    TResult? Function(String? reason)? other,
  }) {
    return consensusNotReached?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? timeout,
    TResult Function()? connectivity,
    TResult Function()? consensusNotReached,
    TResult Function()? invalidTransaction,
    TResult Function()? invalidConfirmation,
    TResult Function()? insufficientFunds,
    TResult Function()? userRejected,
    TResult Function(String accountName)? unknownAccount,
    TResult Function(String? reason)? other,
    required TResult orElse(),
  }) {
    if (consensusNotReached != null) {
      return consensusNotReached();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransactionTimeout value) timeout,
    required TResult Function(_TransactionConnectionError value) connectivity,
    required TResult Function(_TransactionConsensusNotReachedError value)
        consensusNotReached,
    required TResult Function(_TransactionInvalid value) invalidTransaction,
    required TResult Function(_TransactionInvalidConfirmation value)
        invalidConfirmation,
    required TResult Function(_TransactionInsufficientFunds value)
        insufficientFunds,
    required TResult Function(_TransactionUserRejected value) userRejected,
    required TResult Function(_TransactionUnknownAccount value) unknownAccount,
    required TResult Function(_TransactionOtherError value) other,
  }) {
    return consensusNotReached(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransactionTimeout value)? timeout,
    TResult? Function(_TransactionConnectionError value)? connectivity,
    TResult? Function(_TransactionConsensusNotReachedError value)?
        consensusNotReached,
    TResult? Function(_TransactionInvalid value)? invalidTransaction,
    TResult? Function(_TransactionInvalidConfirmation value)?
        invalidConfirmation,
    TResult? Function(_TransactionInsufficientFunds value)? insufficientFunds,
    TResult? Function(_TransactionUserRejected value)? userRejected,
    TResult? Function(_TransactionUnknownAccount value)? unknownAccount,
    TResult? Function(_TransactionOtherError value)? other,
  }) {
    return consensusNotReached?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransactionTimeout value)? timeout,
    TResult Function(_TransactionConnectionError value)? connectivity,
    TResult Function(_TransactionConsensusNotReachedError value)?
        consensusNotReached,
    TResult Function(_TransactionInvalid value)? invalidTransaction,
    TResult Function(_TransactionInvalidConfirmation value)?
        invalidConfirmation,
    TResult Function(_TransactionInsufficientFunds value)? insufficientFunds,
    TResult Function(_TransactionUserRejected value)? userRejected,
    TResult Function(_TransactionUnknownAccount value)? unknownAccount,
    TResult Function(_TransactionOtherError value)? other,
    required TResult orElse(),
  }) {
    if (consensusNotReached != null) {
      return consensusNotReached(this);
    }
    return orElse();
  }
}

abstract class _TransactionConsensusNotReachedError extends TransactionError {
  const factory _TransactionConsensusNotReachedError() =
      _$_TransactionConsensusNotReachedError;
  const _TransactionConsensusNotReachedError._() : super._();
}

/// @nodoc
abstract class _$$_TransactionInvalidCopyWith<$Res> {
  factory _$$_TransactionInvalidCopyWith(_$_TransactionInvalid value,
          $Res Function(_$_TransactionInvalid) then) =
      __$$_TransactionInvalidCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_TransactionInvalidCopyWithImpl<$Res>
    extends _$TransactionErrorCopyWithImpl<$Res, _$_TransactionInvalid>
    implements _$$_TransactionInvalidCopyWith<$Res> {
  __$$_TransactionInvalidCopyWithImpl(
      _$_TransactionInvalid _value, $Res Function(_$_TransactionInvalid) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_TransactionInvalid extends _TransactionInvalid {
  const _$_TransactionInvalid() : super._();

  @override
  String toString() {
    return 'TransactionError.invalidTransaction()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_TransactionInvalid);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() timeout,
    required TResult Function() connectivity,
    required TResult Function() consensusNotReached,
    required TResult Function() invalidTransaction,
    required TResult Function() invalidConfirmation,
    required TResult Function() insufficientFunds,
    required TResult Function() userRejected,
    required TResult Function(String accountName) unknownAccount,
    required TResult Function(String? reason) other,
  }) {
    return invalidTransaction();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? timeout,
    TResult? Function()? connectivity,
    TResult? Function()? consensusNotReached,
    TResult? Function()? invalidTransaction,
    TResult? Function()? invalidConfirmation,
    TResult? Function()? insufficientFunds,
    TResult? Function()? userRejected,
    TResult? Function(String accountName)? unknownAccount,
    TResult? Function(String? reason)? other,
  }) {
    return invalidTransaction?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? timeout,
    TResult Function()? connectivity,
    TResult Function()? consensusNotReached,
    TResult Function()? invalidTransaction,
    TResult Function()? invalidConfirmation,
    TResult Function()? insufficientFunds,
    TResult Function()? userRejected,
    TResult Function(String accountName)? unknownAccount,
    TResult Function(String? reason)? other,
    required TResult orElse(),
  }) {
    if (invalidTransaction != null) {
      return invalidTransaction();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransactionTimeout value) timeout,
    required TResult Function(_TransactionConnectionError value) connectivity,
    required TResult Function(_TransactionConsensusNotReachedError value)
        consensusNotReached,
    required TResult Function(_TransactionInvalid value) invalidTransaction,
    required TResult Function(_TransactionInvalidConfirmation value)
        invalidConfirmation,
    required TResult Function(_TransactionInsufficientFunds value)
        insufficientFunds,
    required TResult Function(_TransactionUserRejected value) userRejected,
    required TResult Function(_TransactionUnknownAccount value) unknownAccount,
    required TResult Function(_TransactionOtherError value) other,
  }) {
    return invalidTransaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransactionTimeout value)? timeout,
    TResult? Function(_TransactionConnectionError value)? connectivity,
    TResult? Function(_TransactionConsensusNotReachedError value)?
        consensusNotReached,
    TResult? Function(_TransactionInvalid value)? invalidTransaction,
    TResult? Function(_TransactionInvalidConfirmation value)?
        invalidConfirmation,
    TResult? Function(_TransactionInsufficientFunds value)? insufficientFunds,
    TResult? Function(_TransactionUserRejected value)? userRejected,
    TResult? Function(_TransactionUnknownAccount value)? unknownAccount,
    TResult? Function(_TransactionOtherError value)? other,
  }) {
    return invalidTransaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransactionTimeout value)? timeout,
    TResult Function(_TransactionConnectionError value)? connectivity,
    TResult Function(_TransactionConsensusNotReachedError value)?
        consensusNotReached,
    TResult Function(_TransactionInvalid value)? invalidTransaction,
    TResult Function(_TransactionInvalidConfirmation value)?
        invalidConfirmation,
    TResult Function(_TransactionInsufficientFunds value)? insufficientFunds,
    TResult Function(_TransactionUserRejected value)? userRejected,
    TResult Function(_TransactionUnknownAccount value)? unknownAccount,
    TResult Function(_TransactionOtherError value)? other,
    required TResult orElse(),
  }) {
    if (invalidTransaction != null) {
      return invalidTransaction(this);
    }
    return orElse();
  }
}

abstract class _TransactionInvalid extends TransactionError {
  const factory _TransactionInvalid() = _$_TransactionInvalid;
  const _TransactionInvalid._() : super._();
}

/// @nodoc
abstract class _$$_TransactionInvalidConfirmationCopyWith<$Res> {
  factory _$$_TransactionInvalidConfirmationCopyWith(
          _$_TransactionInvalidConfirmation value,
          $Res Function(_$_TransactionInvalidConfirmation) then) =
      __$$_TransactionInvalidConfirmationCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_TransactionInvalidConfirmationCopyWithImpl<$Res>
    extends _$TransactionErrorCopyWithImpl<$Res,
        _$_TransactionInvalidConfirmation>
    implements _$$_TransactionInvalidConfirmationCopyWith<$Res> {
  __$$_TransactionInvalidConfirmationCopyWithImpl(
      _$_TransactionInvalidConfirmation _value,
      $Res Function(_$_TransactionInvalidConfirmation) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_TransactionInvalidConfirmation
    extends _TransactionInvalidConfirmation {
  const _$_TransactionInvalidConfirmation() : super._();

  @override
  String toString() {
    return 'TransactionError.invalidConfirmation()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionInvalidConfirmation);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() timeout,
    required TResult Function() connectivity,
    required TResult Function() consensusNotReached,
    required TResult Function() invalidTransaction,
    required TResult Function() invalidConfirmation,
    required TResult Function() insufficientFunds,
    required TResult Function() userRejected,
    required TResult Function(String accountName) unknownAccount,
    required TResult Function(String? reason) other,
  }) {
    return invalidConfirmation();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? timeout,
    TResult? Function()? connectivity,
    TResult? Function()? consensusNotReached,
    TResult? Function()? invalidTransaction,
    TResult? Function()? invalidConfirmation,
    TResult? Function()? insufficientFunds,
    TResult? Function()? userRejected,
    TResult? Function(String accountName)? unknownAccount,
    TResult? Function(String? reason)? other,
  }) {
    return invalidConfirmation?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? timeout,
    TResult Function()? connectivity,
    TResult Function()? consensusNotReached,
    TResult Function()? invalidTransaction,
    TResult Function()? invalidConfirmation,
    TResult Function()? insufficientFunds,
    TResult Function()? userRejected,
    TResult Function(String accountName)? unknownAccount,
    TResult Function(String? reason)? other,
    required TResult orElse(),
  }) {
    if (invalidConfirmation != null) {
      return invalidConfirmation();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransactionTimeout value) timeout,
    required TResult Function(_TransactionConnectionError value) connectivity,
    required TResult Function(_TransactionConsensusNotReachedError value)
        consensusNotReached,
    required TResult Function(_TransactionInvalid value) invalidTransaction,
    required TResult Function(_TransactionInvalidConfirmation value)
        invalidConfirmation,
    required TResult Function(_TransactionInsufficientFunds value)
        insufficientFunds,
    required TResult Function(_TransactionUserRejected value) userRejected,
    required TResult Function(_TransactionUnknownAccount value) unknownAccount,
    required TResult Function(_TransactionOtherError value) other,
  }) {
    return invalidConfirmation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransactionTimeout value)? timeout,
    TResult? Function(_TransactionConnectionError value)? connectivity,
    TResult? Function(_TransactionConsensusNotReachedError value)?
        consensusNotReached,
    TResult? Function(_TransactionInvalid value)? invalidTransaction,
    TResult? Function(_TransactionInvalidConfirmation value)?
        invalidConfirmation,
    TResult? Function(_TransactionInsufficientFunds value)? insufficientFunds,
    TResult? Function(_TransactionUserRejected value)? userRejected,
    TResult? Function(_TransactionUnknownAccount value)? unknownAccount,
    TResult? Function(_TransactionOtherError value)? other,
  }) {
    return invalidConfirmation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransactionTimeout value)? timeout,
    TResult Function(_TransactionConnectionError value)? connectivity,
    TResult Function(_TransactionConsensusNotReachedError value)?
        consensusNotReached,
    TResult Function(_TransactionInvalid value)? invalidTransaction,
    TResult Function(_TransactionInvalidConfirmation value)?
        invalidConfirmation,
    TResult Function(_TransactionInsufficientFunds value)? insufficientFunds,
    TResult Function(_TransactionUserRejected value)? userRejected,
    TResult Function(_TransactionUnknownAccount value)? unknownAccount,
    TResult Function(_TransactionOtherError value)? other,
    required TResult orElse(),
  }) {
    if (invalidConfirmation != null) {
      return invalidConfirmation(this);
    }
    return orElse();
  }
}

abstract class _TransactionInvalidConfirmation extends TransactionError {
  const factory _TransactionInvalidConfirmation() =
      _$_TransactionInvalidConfirmation;
  const _TransactionInvalidConfirmation._() : super._();
}

/// @nodoc
abstract class _$$_TransactionInsufficientFundsCopyWith<$Res> {
  factory _$$_TransactionInsufficientFundsCopyWith(
          _$_TransactionInsufficientFunds value,
          $Res Function(_$_TransactionInsufficientFunds) then) =
      __$$_TransactionInsufficientFundsCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_TransactionInsufficientFundsCopyWithImpl<$Res>
    extends _$TransactionErrorCopyWithImpl<$Res,
        _$_TransactionInsufficientFunds>
    implements _$$_TransactionInsufficientFundsCopyWith<$Res> {
  __$$_TransactionInsufficientFundsCopyWithImpl(
      _$_TransactionInsufficientFunds _value,
      $Res Function(_$_TransactionInsufficientFunds) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_TransactionInsufficientFunds extends _TransactionInsufficientFunds {
  const _$_TransactionInsufficientFunds() : super._();

  @override
  String toString() {
    return 'TransactionError.insufficientFunds()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionInsufficientFunds);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() timeout,
    required TResult Function() connectivity,
    required TResult Function() consensusNotReached,
    required TResult Function() invalidTransaction,
    required TResult Function() invalidConfirmation,
    required TResult Function() insufficientFunds,
    required TResult Function() userRejected,
    required TResult Function(String accountName) unknownAccount,
    required TResult Function(String? reason) other,
  }) {
    return insufficientFunds();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? timeout,
    TResult? Function()? connectivity,
    TResult? Function()? consensusNotReached,
    TResult? Function()? invalidTransaction,
    TResult? Function()? invalidConfirmation,
    TResult? Function()? insufficientFunds,
    TResult? Function()? userRejected,
    TResult? Function(String accountName)? unknownAccount,
    TResult? Function(String? reason)? other,
  }) {
    return insufficientFunds?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? timeout,
    TResult Function()? connectivity,
    TResult Function()? consensusNotReached,
    TResult Function()? invalidTransaction,
    TResult Function()? invalidConfirmation,
    TResult Function()? insufficientFunds,
    TResult Function()? userRejected,
    TResult Function(String accountName)? unknownAccount,
    TResult Function(String? reason)? other,
    required TResult orElse(),
  }) {
    if (insufficientFunds != null) {
      return insufficientFunds();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransactionTimeout value) timeout,
    required TResult Function(_TransactionConnectionError value) connectivity,
    required TResult Function(_TransactionConsensusNotReachedError value)
        consensusNotReached,
    required TResult Function(_TransactionInvalid value) invalidTransaction,
    required TResult Function(_TransactionInvalidConfirmation value)
        invalidConfirmation,
    required TResult Function(_TransactionInsufficientFunds value)
        insufficientFunds,
    required TResult Function(_TransactionUserRejected value) userRejected,
    required TResult Function(_TransactionUnknownAccount value) unknownAccount,
    required TResult Function(_TransactionOtherError value) other,
  }) {
    return insufficientFunds(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransactionTimeout value)? timeout,
    TResult? Function(_TransactionConnectionError value)? connectivity,
    TResult? Function(_TransactionConsensusNotReachedError value)?
        consensusNotReached,
    TResult? Function(_TransactionInvalid value)? invalidTransaction,
    TResult? Function(_TransactionInvalidConfirmation value)?
        invalidConfirmation,
    TResult? Function(_TransactionInsufficientFunds value)? insufficientFunds,
    TResult? Function(_TransactionUserRejected value)? userRejected,
    TResult? Function(_TransactionUnknownAccount value)? unknownAccount,
    TResult? Function(_TransactionOtherError value)? other,
  }) {
    return insufficientFunds?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransactionTimeout value)? timeout,
    TResult Function(_TransactionConnectionError value)? connectivity,
    TResult Function(_TransactionConsensusNotReachedError value)?
        consensusNotReached,
    TResult Function(_TransactionInvalid value)? invalidTransaction,
    TResult Function(_TransactionInvalidConfirmation value)?
        invalidConfirmation,
    TResult Function(_TransactionInsufficientFunds value)? insufficientFunds,
    TResult Function(_TransactionUserRejected value)? userRejected,
    TResult Function(_TransactionUnknownAccount value)? unknownAccount,
    TResult Function(_TransactionOtherError value)? other,
    required TResult orElse(),
  }) {
    if (insufficientFunds != null) {
      return insufficientFunds(this);
    }
    return orElse();
  }
}

abstract class _TransactionInsufficientFunds extends TransactionError {
  const factory _TransactionInsufficientFunds() =
      _$_TransactionInsufficientFunds;
  const _TransactionInsufficientFunds._() : super._();
}

/// @nodoc
abstract class _$$_TransactionUserRejectedCopyWith<$Res> {
  factory _$$_TransactionUserRejectedCopyWith(_$_TransactionUserRejected value,
          $Res Function(_$_TransactionUserRejected) then) =
      __$$_TransactionUserRejectedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_TransactionUserRejectedCopyWithImpl<$Res>
    extends _$TransactionErrorCopyWithImpl<$Res, _$_TransactionUserRejected>
    implements _$$_TransactionUserRejectedCopyWith<$Res> {
  __$$_TransactionUserRejectedCopyWithImpl(_$_TransactionUserRejected _value,
      $Res Function(_$_TransactionUserRejected) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_TransactionUserRejected extends _TransactionUserRejected {
  const _$_TransactionUserRejected() : super._();

  @override
  String toString() {
    return 'TransactionError.userRejected()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionUserRejected);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() timeout,
    required TResult Function() connectivity,
    required TResult Function() consensusNotReached,
    required TResult Function() invalidTransaction,
    required TResult Function() invalidConfirmation,
    required TResult Function() insufficientFunds,
    required TResult Function() userRejected,
    required TResult Function(String accountName) unknownAccount,
    required TResult Function(String? reason) other,
  }) {
    return userRejected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? timeout,
    TResult? Function()? connectivity,
    TResult? Function()? consensusNotReached,
    TResult? Function()? invalidTransaction,
    TResult? Function()? invalidConfirmation,
    TResult? Function()? insufficientFunds,
    TResult? Function()? userRejected,
    TResult? Function(String accountName)? unknownAccount,
    TResult? Function(String? reason)? other,
  }) {
    return userRejected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? timeout,
    TResult Function()? connectivity,
    TResult Function()? consensusNotReached,
    TResult Function()? invalidTransaction,
    TResult Function()? invalidConfirmation,
    TResult Function()? insufficientFunds,
    TResult Function()? userRejected,
    TResult Function(String accountName)? unknownAccount,
    TResult Function(String? reason)? other,
    required TResult orElse(),
  }) {
    if (userRejected != null) {
      return userRejected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransactionTimeout value) timeout,
    required TResult Function(_TransactionConnectionError value) connectivity,
    required TResult Function(_TransactionConsensusNotReachedError value)
        consensusNotReached,
    required TResult Function(_TransactionInvalid value) invalidTransaction,
    required TResult Function(_TransactionInvalidConfirmation value)
        invalidConfirmation,
    required TResult Function(_TransactionInsufficientFunds value)
        insufficientFunds,
    required TResult Function(_TransactionUserRejected value) userRejected,
    required TResult Function(_TransactionUnknownAccount value) unknownAccount,
    required TResult Function(_TransactionOtherError value) other,
  }) {
    return userRejected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransactionTimeout value)? timeout,
    TResult? Function(_TransactionConnectionError value)? connectivity,
    TResult? Function(_TransactionConsensusNotReachedError value)?
        consensusNotReached,
    TResult? Function(_TransactionInvalid value)? invalidTransaction,
    TResult? Function(_TransactionInvalidConfirmation value)?
        invalidConfirmation,
    TResult? Function(_TransactionInsufficientFunds value)? insufficientFunds,
    TResult? Function(_TransactionUserRejected value)? userRejected,
    TResult? Function(_TransactionUnknownAccount value)? unknownAccount,
    TResult? Function(_TransactionOtherError value)? other,
  }) {
    return userRejected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransactionTimeout value)? timeout,
    TResult Function(_TransactionConnectionError value)? connectivity,
    TResult Function(_TransactionConsensusNotReachedError value)?
        consensusNotReached,
    TResult Function(_TransactionInvalid value)? invalidTransaction,
    TResult Function(_TransactionInvalidConfirmation value)?
        invalidConfirmation,
    TResult Function(_TransactionInsufficientFunds value)? insufficientFunds,
    TResult Function(_TransactionUserRejected value)? userRejected,
    TResult Function(_TransactionUnknownAccount value)? unknownAccount,
    TResult Function(_TransactionOtherError value)? other,
    required TResult orElse(),
  }) {
    if (userRejected != null) {
      return userRejected(this);
    }
    return orElse();
  }
}

abstract class _TransactionUserRejected extends TransactionError {
  const factory _TransactionUserRejected() = _$_TransactionUserRejected;
  const _TransactionUserRejected._() : super._();
}

/// @nodoc
abstract class _$$_TransactionUnknownAccountCopyWith<$Res> {
  factory _$$_TransactionUnknownAccountCopyWith(
          _$_TransactionUnknownAccount value,
          $Res Function(_$_TransactionUnknownAccount) then) =
      __$$_TransactionUnknownAccountCopyWithImpl<$Res>;
  @useResult
  $Res call({String accountName});
}

/// @nodoc
class __$$_TransactionUnknownAccountCopyWithImpl<$Res>
    extends _$TransactionErrorCopyWithImpl<$Res, _$_TransactionUnknownAccount>
    implements _$$_TransactionUnknownAccountCopyWith<$Res> {
  __$$_TransactionUnknownAccountCopyWithImpl(
      _$_TransactionUnknownAccount _value,
      $Res Function(_$_TransactionUnknownAccount) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountName = null,
  }) {
    return _then(_$_TransactionUnknownAccount(
      accountName: null == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_TransactionUnknownAccount extends _TransactionUnknownAccount {
  const _$_TransactionUnknownAccount({required this.accountName}) : super._();

  @override
  final String accountName;

  @override
  String toString() {
    return 'TransactionError.unknownAccount(accountName: $accountName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionUnknownAccount &&
            (identical(other.accountName, accountName) ||
                other.accountName == accountName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accountName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionUnknownAccountCopyWith<_$_TransactionUnknownAccount>
      get copyWith => __$$_TransactionUnknownAccountCopyWithImpl<
          _$_TransactionUnknownAccount>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() timeout,
    required TResult Function() connectivity,
    required TResult Function() consensusNotReached,
    required TResult Function() invalidTransaction,
    required TResult Function() invalidConfirmation,
    required TResult Function() insufficientFunds,
    required TResult Function() userRejected,
    required TResult Function(String accountName) unknownAccount,
    required TResult Function(String? reason) other,
  }) {
    return unknownAccount(accountName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? timeout,
    TResult? Function()? connectivity,
    TResult? Function()? consensusNotReached,
    TResult? Function()? invalidTransaction,
    TResult? Function()? invalidConfirmation,
    TResult? Function()? insufficientFunds,
    TResult? Function()? userRejected,
    TResult? Function(String accountName)? unknownAccount,
    TResult? Function(String? reason)? other,
  }) {
    return unknownAccount?.call(accountName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? timeout,
    TResult Function()? connectivity,
    TResult Function()? consensusNotReached,
    TResult Function()? invalidTransaction,
    TResult Function()? invalidConfirmation,
    TResult Function()? insufficientFunds,
    TResult Function()? userRejected,
    TResult Function(String accountName)? unknownAccount,
    TResult Function(String? reason)? other,
    required TResult orElse(),
  }) {
    if (unknownAccount != null) {
      return unknownAccount(accountName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransactionTimeout value) timeout,
    required TResult Function(_TransactionConnectionError value) connectivity,
    required TResult Function(_TransactionConsensusNotReachedError value)
        consensusNotReached,
    required TResult Function(_TransactionInvalid value) invalidTransaction,
    required TResult Function(_TransactionInvalidConfirmation value)
        invalidConfirmation,
    required TResult Function(_TransactionInsufficientFunds value)
        insufficientFunds,
    required TResult Function(_TransactionUserRejected value) userRejected,
    required TResult Function(_TransactionUnknownAccount value) unknownAccount,
    required TResult Function(_TransactionOtherError value) other,
  }) {
    return unknownAccount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransactionTimeout value)? timeout,
    TResult? Function(_TransactionConnectionError value)? connectivity,
    TResult? Function(_TransactionConsensusNotReachedError value)?
        consensusNotReached,
    TResult? Function(_TransactionInvalid value)? invalidTransaction,
    TResult? Function(_TransactionInvalidConfirmation value)?
        invalidConfirmation,
    TResult? Function(_TransactionInsufficientFunds value)? insufficientFunds,
    TResult? Function(_TransactionUserRejected value)? userRejected,
    TResult? Function(_TransactionUnknownAccount value)? unknownAccount,
    TResult? Function(_TransactionOtherError value)? other,
  }) {
    return unknownAccount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransactionTimeout value)? timeout,
    TResult Function(_TransactionConnectionError value)? connectivity,
    TResult Function(_TransactionConsensusNotReachedError value)?
        consensusNotReached,
    TResult Function(_TransactionInvalid value)? invalidTransaction,
    TResult Function(_TransactionInvalidConfirmation value)?
        invalidConfirmation,
    TResult Function(_TransactionInsufficientFunds value)? insufficientFunds,
    TResult Function(_TransactionUserRejected value)? userRejected,
    TResult Function(_TransactionUnknownAccount value)? unknownAccount,
    TResult Function(_TransactionOtherError value)? other,
    required TResult orElse(),
  }) {
    if (unknownAccount != null) {
      return unknownAccount(this);
    }
    return orElse();
  }
}

abstract class _TransactionUnknownAccount extends TransactionError {
  const factory _TransactionUnknownAccount(
      {required final String accountName}) = _$_TransactionUnknownAccount;
  const _TransactionUnknownAccount._() : super._();

  String get accountName;
  @JsonKey(ignore: true)
  _$$_TransactionUnknownAccountCopyWith<_$_TransactionUnknownAccount>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_TransactionOtherErrorCopyWith<$Res> {
  factory _$$_TransactionOtherErrorCopyWith(_$_TransactionOtherError value,
          $Res Function(_$_TransactionOtherError) then) =
      __$$_TransactionOtherErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String? reason});
}

/// @nodoc
class __$$_TransactionOtherErrorCopyWithImpl<$Res>
    extends _$TransactionErrorCopyWithImpl<$Res, _$_TransactionOtherError>
    implements _$$_TransactionOtherErrorCopyWith<$Res> {
  __$$_TransactionOtherErrorCopyWithImpl(_$_TransactionOtherError _value,
      $Res Function(_$_TransactionOtherError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = freezed,
  }) {
    return _then(_$_TransactionOtherError(
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_TransactionOtherError extends _TransactionOtherError {
  const _$_TransactionOtherError({this.reason}) : super._();

  @override
  final String? reason;

  @override
  String toString() {
    return 'TransactionError.other(reason: $reason)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionOtherError &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionOtherErrorCopyWith<_$_TransactionOtherError> get copyWith =>
      __$$_TransactionOtherErrorCopyWithImpl<_$_TransactionOtherError>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() timeout,
    required TResult Function() connectivity,
    required TResult Function() consensusNotReached,
    required TResult Function() invalidTransaction,
    required TResult Function() invalidConfirmation,
    required TResult Function() insufficientFunds,
    required TResult Function() userRejected,
    required TResult Function(String accountName) unknownAccount,
    required TResult Function(String? reason) other,
  }) {
    return other(reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? timeout,
    TResult? Function()? connectivity,
    TResult? Function()? consensusNotReached,
    TResult? Function()? invalidTransaction,
    TResult? Function()? invalidConfirmation,
    TResult? Function()? insufficientFunds,
    TResult? Function()? userRejected,
    TResult? Function(String accountName)? unknownAccount,
    TResult? Function(String? reason)? other,
  }) {
    return other?.call(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? timeout,
    TResult Function()? connectivity,
    TResult Function()? consensusNotReached,
    TResult Function()? invalidTransaction,
    TResult Function()? invalidConfirmation,
    TResult Function()? insufficientFunds,
    TResult Function()? userRejected,
    TResult Function(String accountName)? unknownAccount,
    TResult Function(String? reason)? other,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransactionTimeout value) timeout,
    required TResult Function(_TransactionConnectionError value) connectivity,
    required TResult Function(_TransactionConsensusNotReachedError value)
        consensusNotReached,
    required TResult Function(_TransactionInvalid value) invalidTransaction,
    required TResult Function(_TransactionInvalidConfirmation value)
        invalidConfirmation,
    required TResult Function(_TransactionInsufficientFunds value)
        insufficientFunds,
    required TResult Function(_TransactionUserRejected value) userRejected,
    required TResult Function(_TransactionUnknownAccount value) unknownAccount,
    required TResult Function(_TransactionOtherError value) other,
  }) {
    return other(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransactionTimeout value)? timeout,
    TResult? Function(_TransactionConnectionError value)? connectivity,
    TResult? Function(_TransactionConsensusNotReachedError value)?
        consensusNotReached,
    TResult? Function(_TransactionInvalid value)? invalidTransaction,
    TResult? Function(_TransactionInvalidConfirmation value)?
        invalidConfirmation,
    TResult? Function(_TransactionInsufficientFunds value)? insufficientFunds,
    TResult? Function(_TransactionUserRejected value)? userRejected,
    TResult? Function(_TransactionUnknownAccount value)? unknownAccount,
    TResult? Function(_TransactionOtherError value)? other,
  }) {
    return other?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransactionTimeout value)? timeout,
    TResult Function(_TransactionConnectionError value)? connectivity,
    TResult Function(_TransactionConsensusNotReachedError value)?
        consensusNotReached,
    TResult Function(_TransactionInvalid value)? invalidTransaction,
    TResult Function(_TransactionInvalidConfirmation value)?
        invalidConfirmation,
    TResult Function(_TransactionInsufficientFunds value)? insufficientFunds,
    TResult Function(_TransactionUserRejected value)? userRejected,
    TResult Function(_TransactionUnknownAccount value)? unknownAccount,
    TResult Function(_TransactionOtherError value)? other,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(this);
    }
    return orElse();
  }
}

abstract class _TransactionOtherError extends TransactionError {
  const factory _TransactionOtherError({final String? reason}) =
      _$_TransactionOtherError;
  const _TransactionOtherError._() : super._();

  String? get reason;
  @JsonKey(ignore: true)
  _$$_TransactionOtherErrorCopyWith<_$_TransactionOtherError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TransactionConfirmation {
  String get transactionAddress => throw _privateConstructorUsedError;
  int get nbConfirmations => throw _privateConstructorUsedError;
  int get maxConfirmations => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransactionConfirmationCopyWith<TransactionConfirmation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionConfirmationCopyWith<$Res> {
  factory $TransactionConfirmationCopyWith(TransactionConfirmation value,
          $Res Function(TransactionConfirmation) then) =
      _$TransactionConfirmationCopyWithImpl<$Res, TransactionConfirmation>;
  @useResult
  $Res call(
      {String transactionAddress, int nbConfirmations, int maxConfirmations});
}

/// @nodoc
class _$TransactionConfirmationCopyWithImpl<$Res,
        $Val extends TransactionConfirmation>
    implements $TransactionConfirmationCopyWith<$Res> {
  _$TransactionConfirmationCopyWithImpl(this._value, this._then);

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
abstract class _$$_TransactionConfirmationCopyWith<$Res>
    implements $TransactionConfirmationCopyWith<$Res> {
  factory _$$_TransactionConfirmationCopyWith(_$_TransactionConfirmation value,
          $Res Function(_$_TransactionConfirmation) then) =
      __$$_TransactionConfirmationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String transactionAddress, int nbConfirmations, int maxConfirmations});
}

/// @nodoc
class __$$_TransactionConfirmationCopyWithImpl<$Res>
    extends _$TransactionConfirmationCopyWithImpl<$Res,
        _$_TransactionConfirmation>
    implements _$$_TransactionConfirmationCopyWith<$Res> {
  __$$_TransactionConfirmationCopyWithImpl(_$_TransactionConfirmation _value,
      $Res Function(_$_TransactionConfirmation) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionAddress = null,
    Object? nbConfirmations = null,
    Object? maxConfirmations = null,
  }) {
    return _then(_$_TransactionConfirmation(
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

class _$_TransactionConfirmation extends _TransactionConfirmation {
  const _$_TransactionConfirmation(
      {required this.transactionAddress,
      this.nbConfirmations = 0,
      this.maxConfirmations = 0})
      : super._();

  @override
  final String transactionAddress;
  @override
  @JsonKey()
  final int nbConfirmations;
  @override
  @JsonKey()
  final int maxConfirmations;

  @override
  String toString() {
    return 'TransactionConfirmation(transactionAddress: $transactionAddress, nbConfirmations: $nbConfirmations, maxConfirmations: $maxConfirmations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionConfirmation &&
            (identical(other.transactionAddress, transactionAddress) ||
                other.transactionAddress == transactionAddress) &&
            (identical(other.nbConfirmations, nbConfirmations) ||
                other.nbConfirmations == nbConfirmations) &&
            (identical(other.maxConfirmations, maxConfirmations) ||
                other.maxConfirmations == maxConfirmations));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, transactionAddress, nbConfirmations, maxConfirmations);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionConfirmationCopyWith<_$_TransactionConfirmation>
      get copyWith =>
          __$$_TransactionConfirmationCopyWithImpl<_$_TransactionConfirmation>(
              this, _$identity);
}

abstract class _TransactionConfirmation extends TransactionConfirmation {
  const factory _TransactionConfirmation(
      {required final String transactionAddress,
      final int nbConfirmations,
      final int maxConfirmations}) = _$_TransactionConfirmation;
  const _TransactionConfirmation._() : super._();

  @override
  String get transactionAddress;
  @override
  int get nbConfirmations;
  @override
  int get maxConfirmations;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionConfirmationCopyWith<_$_TransactionConfirmation>
      get copyWith => throw _privateConstructorUsedError;
}
