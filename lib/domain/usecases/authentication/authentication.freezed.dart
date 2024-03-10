// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthenticationResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() success,
    required TResult Function() wrongCredentials,
    required TResult Function() notSetup,
    required TResult Function() tooMuchAttempts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? success,
    TResult? Function()? wrongCredentials,
    TResult? Function()? notSetup,
    TResult? Function()? tooMuchAttempts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? success,
    TResult Function()? wrongCredentials,
    TResult Function()? notSetup,
    TResult Function()? tooMuchAttempts,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticationResult value) success,
    required TResult Function(_AuthenticationFailure value) wrongCredentials,
    required TResult Function(_AuthenticationNotSetup value) notSetup,
    required TResult Function(_AuthenticationTooMuchAttempts value)
        tooMuchAttempts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthenticationResult value)? success,
    TResult? Function(_AuthenticationFailure value)? wrongCredentials,
    TResult? Function(_AuthenticationNotSetup value)? notSetup,
    TResult? Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticationResult value)? success,
    TResult Function(_AuthenticationFailure value)? wrongCredentials,
    TResult Function(_AuthenticationNotSetup value)? notSetup,
    TResult Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationResultCopyWith<$Res> {
  factory $AuthenticationResultCopyWith(AuthenticationResult value,
          $Res Function(AuthenticationResult) then) =
      _$AuthenticationResultCopyWithImpl<$Res, AuthenticationResult>;
}

/// @nodoc
class _$AuthenticationResultCopyWithImpl<$Res,
        $Val extends AuthenticationResult>
    implements $AuthenticationResultCopyWith<$Res> {
  _$AuthenticationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AuthenticationResultImplCopyWith<$Res> {
  factory _$$AuthenticationResultImplCopyWith(_$AuthenticationResultImpl value,
          $Res Function(_$AuthenticationResultImpl) then) =
      __$$AuthenticationResultImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationResultImplCopyWithImpl<$Res>
    extends _$AuthenticationResultCopyWithImpl<$Res, _$AuthenticationResultImpl>
    implements _$$AuthenticationResultImplCopyWith<$Res> {
  __$$AuthenticationResultImplCopyWithImpl(_$AuthenticationResultImpl _value,
      $Res Function(_$AuthenticationResultImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationResultImpl extends _AuthenticationResult {
  const _$AuthenticationResultImpl() : super._();

  @override
  String toString() {
    return 'AuthenticationResult.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationResultImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() success,
    required TResult Function() wrongCredentials,
    required TResult Function() notSetup,
    required TResult Function() tooMuchAttempts,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? success,
    TResult? Function()? wrongCredentials,
    TResult? Function()? notSetup,
    TResult? Function()? tooMuchAttempts,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? success,
    TResult Function()? wrongCredentials,
    TResult Function()? notSetup,
    TResult Function()? tooMuchAttempts,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticationResult value) success,
    required TResult Function(_AuthenticationFailure value) wrongCredentials,
    required TResult Function(_AuthenticationNotSetup value) notSetup,
    required TResult Function(_AuthenticationTooMuchAttempts value)
        tooMuchAttempts,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthenticationResult value)? success,
    TResult? Function(_AuthenticationFailure value)? wrongCredentials,
    TResult? Function(_AuthenticationNotSetup value)? notSetup,
    TResult? Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticationResult value)? success,
    TResult Function(_AuthenticationFailure value)? wrongCredentials,
    TResult Function(_AuthenticationNotSetup value)? notSetup,
    TResult Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _AuthenticationResult extends AuthenticationResult {
  const factory _AuthenticationResult() = _$AuthenticationResultImpl;
  const _AuthenticationResult._() : super._();
}

/// @nodoc
abstract class _$$AuthenticationFailureImplCopyWith<$Res> {
  factory _$$AuthenticationFailureImplCopyWith(
          _$AuthenticationFailureImpl value,
          $Res Function(_$AuthenticationFailureImpl) then) =
      __$$AuthenticationFailureImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationFailureImplCopyWithImpl<$Res>
    extends _$AuthenticationResultCopyWithImpl<$Res,
        _$AuthenticationFailureImpl>
    implements _$$AuthenticationFailureImplCopyWith<$Res> {
  __$$AuthenticationFailureImplCopyWithImpl(_$AuthenticationFailureImpl _value,
      $Res Function(_$AuthenticationFailureImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationFailureImpl extends _AuthenticationFailure {
  const _$AuthenticationFailureImpl() : super._();

  @override
  String toString() {
    return 'AuthenticationResult.wrongCredentials()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationFailureImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() success,
    required TResult Function() wrongCredentials,
    required TResult Function() notSetup,
    required TResult Function() tooMuchAttempts,
  }) {
    return wrongCredentials();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? success,
    TResult? Function()? wrongCredentials,
    TResult? Function()? notSetup,
    TResult? Function()? tooMuchAttempts,
  }) {
    return wrongCredentials?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? success,
    TResult Function()? wrongCredentials,
    TResult Function()? notSetup,
    TResult Function()? tooMuchAttempts,
    required TResult orElse(),
  }) {
    if (wrongCredentials != null) {
      return wrongCredentials();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticationResult value) success,
    required TResult Function(_AuthenticationFailure value) wrongCredentials,
    required TResult Function(_AuthenticationNotSetup value) notSetup,
    required TResult Function(_AuthenticationTooMuchAttempts value)
        tooMuchAttempts,
  }) {
    return wrongCredentials(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthenticationResult value)? success,
    TResult? Function(_AuthenticationFailure value)? wrongCredentials,
    TResult? Function(_AuthenticationNotSetup value)? notSetup,
    TResult? Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
  }) {
    return wrongCredentials?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticationResult value)? success,
    TResult Function(_AuthenticationFailure value)? wrongCredentials,
    TResult Function(_AuthenticationNotSetup value)? notSetup,
    TResult Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
    required TResult orElse(),
  }) {
    if (wrongCredentials != null) {
      return wrongCredentials(this);
    }
    return orElse();
  }
}

abstract class _AuthenticationFailure extends AuthenticationResult {
  const factory _AuthenticationFailure() = _$AuthenticationFailureImpl;
  const _AuthenticationFailure._() : super._();
}

/// @nodoc
abstract class _$$AuthenticationNotSetupImplCopyWith<$Res> {
  factory _$$AuthenticationNotSetupImplCopyWith(
          _$AuthenticationNotSetupImpl value,
          $Res Function(_$AuthenticationNotSetupImpl) then) =
      __$$AuthenticationNotSetupImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationNotSetupImplCopyWithImpl<$Res>
    extends _$AuthenticationResultCopyWithImpl<$Res,
        _$AuthenticationNotSetupImpl>
    implements _$$AuthenticationNotSetupImplCopyWith<$Res> {
  __$$AuthenticationNotSetupImplCopyWithImpl(
      _$AuthenticationNotSetupImpl _value,
      $Res Function(_$AuthenticationNotSetupImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationNotSetupImpl extends _AuthenticationNotSetup {
  const _$AuthenticationNotSetupImpl() : super._();

  @override
  String toString() {
    return 'AuthenticationResult.notSetup()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationNotSetupImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() success,
    required TResult Function() wrongCredentials,
    required TResult Function() notSetup,
    required TResult Function() tooMuchAttempts,
  }) {
    return notSetup();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? success,
    TResult? Function()? wrongCredentials,
    TResult? Function()? notSetup,
    TResult? Function()? tooMuchAttempts,
  }) {
    return notSetup?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? success,
    TResult Function()? wrongCredentials,
    TResult Function()? notSetup,
    TResult Function()? tooMuchAttempts,
    required TResult orElse(),
  }) {
    if (notSetup != null) {
      return notSetup();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticationResult value) success,
    required TResult Function(_AuthenticationFailure value) wrongCredentials,
    required TResult Function(_AuthenticationNotSetup value) notSetup,
    required TResult Function(_AuthenticationTooMuchAttempts value)
        tooMuchAttempts,
  }) {
    return notSetup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthenticationResult value)? success,
    TResult? Function(_AuthenticationFailure value)? wrongCredentials,
    TResult? Function(_AuthenticationNotSetup value)? notSetup,
    TResult? Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
  }) {
    return notSetup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticationResult value)? success,
    TResult Function(_AuthenticationFailure value)? wrongCredentials,
    TResult Function(_AuthenticationNotSetup value)? notSetup,
    TResult Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
    required TResult orElse(),
  }) {
    if (notSetup != null) {
      return notSetup(this);
    }
    return orElse();
  }
}

abstract class _AuthenticationNotSetup extends AuthenticationResult {
  const factory _AuthenticationNotSetup() = _$AuthenticationNotSetupImpl;
  const _AuthenticationNotSetup._() : super._();
}

/// @nodoc
abstract class _$$AuthenticationTooMuchAttemptsImplCopyWith<$Res> {
  factory _$$AuthenticationTooMuchAttemptsImplCopyWith(
          _$AuthenticationTooMuchAttemptsImpl value,
          $Res Function(_$AuthenticationTooMuchAttemptsImpl) then) =
      __$$AuthenticationTooMuchAttemptsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationTooMuchAttemptsImplCopyWithImpl<$Res>
    extends _$AuthenticationResultCopyWithImpl<$Res,
        _$AuthenticationTooMuchAttemptsImpl>
    implements _$$AuthenticationTooMuchAttemptsImplCopyWith<$Res> {
  __$$AuthenticationTooMuchAttemptsImplCopyWithImpl(
      _$AuthenticationTooMuchAttemptsImpl _value,
      $Res Function(_$AuthenticationTooMuchAttemptsImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationTooMuchAttemptsImpl
    extends _AuthenticationTooMuchAttempts {
  const _$AuthenticationTooMuchAttemptsImpl() : super._();

  @override
  String toString() {
    return 'AuthenticationResult.tooMuchAttempts()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationTooMuchAttemptsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() success,
    required TResult Function() wrongCredentials,
    required TResult Function() notSetup,
    required TResult Function() tooMuchAttempts,
  }) {
    return tooMuchAttempts();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? success,
    TResult? Function()? wrongCredentials,
    TResult? Function()? notSetup,
    TResult? Function()? tooMuchAttempts,
  }) {
    return tooMuchAttempts?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? success,
    TResult Function()? wrongCredentials,
    TResult Function()? notSetup,
    TResult Function()? tooMuchAttempts,
    required TResult orElse(),
  }) {
    if (tooMuchAttempts != null) {
      return tooMuchAttempts();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticationResult value) success,
    required TResult Function(_AuthenticationFailure value) wrongCredentials,
    required TResult Function(_AuthenticationNotSetup value) notSetup,
    required TResult Function(_AuthenticationTooMuchAttempts value)
        tooMuchAttempts,
  }) {
    return tooMuchAttempts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthenticationResult value)? success,
    TResult? Function(_AuthenticationFailure value)? wrongCredentials,
    TResult? Function(_AuthenticationNotSetup value)? notSetup,
    TResult? Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
  }) {
    return tooMuchAttempts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticationResult value)? success,
    TResult Function(_AuthenticationFailure value)? wrongCredentials,
    TResult Function(_AuthenticationNotSetup value)? notSetup,
    TResult Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
    required TResult orElse(),
  }) {
    if (tooMuchAttempts != null) {
      return tooMuchAttempts(this);
    }
    return orElse();
  }
}

abstract class _AuthenticationTooMuchAttempts extends AuthenticationResult {
  const factory _AuthenticationTooMuchAttempts() =
      _$AuthenticationTooMuchAttemptsImpl;
  const _AuthenticationTooMuchAttempts._() : super._();
}

/// @nodoc
mixin _$UpdatePinResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() success,
    required TResult Function() pinsDoNotMatch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? success,
    TResult? Function()? pinsDoNotMatch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? success,
    TResult Function()? pinsDoNotMatch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdatePinSuccess value) success,
    required TResult Function(_UpdatePinsDoNotMatch value) pinsDoNotMatch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdatePinSuccess value)? success,
    TResult? Function(_UpdatePinsDoNotMatch value)? pinsDoNotMatch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdatePinSuccess value)? success,
    TResult Function(_UpdatePinsDoNotMatch value)? pinsDoNotMatch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePinResultCopyWith<$Res> {
  factory $UpdatePinResultCopyWith(
          UpdatePinResult value, $Res Function(UpdatePinResult) then) =
      _$UpdatePinResultCopyWithImpl<$Res, UpdatePinResult>;
}

/// @nodoc
class _$UpdatePinResultCopyWithImpl<$Res, $Val extends UpdatePinResult>
    implements $UpdatePinResultCopyWith<$Res> {
  _$UpdatePinResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$UpdatePinSuccessImplCopyWith<$Res> {
  factory _$$UpdatePinSuccessImplCopyWith(_$UpdatePinSuccessImpl value,
          $Res Function(_$UpdatePinSuccessImpl) then) =
      __$$UpdatePinSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UpdatePinSuccessImplCopyWithImpl<$Res>
    extends _$UpdatePinResultCopyWithImpl<$Res, _$UpdatePinSuccessImpl>
    implements _$$UpdatePinSuccessImplCopyWith<$Res> {
  __$$UpdatePinSuccessImplCopyWithImpl(_$UpdatePinSuccessImpl _value,
      $Res Function(_$UpdatePinSuccessImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UpdatePinSuccessImpl extends _UpdatePinSuccess {
  const _$UpdatePinSuccessImpl() : super._();

  @override
  String toString() {
    return 'UpdatePinResult.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UpdatePinSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() success,
    required TResult Function() pinsDoNotMatch,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? success,
    TResult? Function()? pinsDoNotMatch,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? success,
    TResult Function()? pinsDoNotMatch,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdatePinSuccess value) success,
    required TResult Function(_UpdatePinsDoNotMatch value) pinsDoNotMatch,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdatePinSuccess value)? success,
    TResult? Function(_UpdatePinsDoNotMatch value)? pinsDoNotMatch,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdatePinSuccess value)? success,
    TResult Function(_UpdatePinsDoNotMatch value)? pinsDoNotMatch,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _UpdatePinSuccess extends UpdatePinResult {
  const factory _UpdatePinSuccess() = _$UpdatePinSuccessImpl;
  const _UpdatePinSuccess._() : super._();
}

/// @nodoc
abstract class _$$UpdatePinsDoNotMatchImplCopyWith<$Res> {
  factory _$$UpdatePinsDoNotMatchImplCopyWith(_$UpdatePinsDoNotMatchImpl value,
          $Res Function(_$UpdatePinsDoNotMatchImpl) then) =
      __$$UpdatePinsDoNotMatchImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UpdatePinsDoNotMatchImplCopyWithImpl<$Res>
    extends _$UpdatePinResultCopyWithImpl<$Res, _$UpdatePinsDoNotMatchImpl>
    implements _$$UpdatePinsDoNotMatchImplCopyWith<$Res> {
  __$$UpdatePinsDoNotMatchImplCopyWithImpl(_$UpdatePinsDoNotMatchImpl _value,
      $Res Function(_$UpdatePinsDoNotMatchImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UpdatePinsDoNotMatchImpl extends _UpdatePinsDoNotMatch {
  const _$UpdatePinsDoNotMatchImpl() : super._();

  @override
  String toString() {
    return 'UpdatePinResult.pinsDoNotMatch()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePinsDoNotMatchImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() success,
    required TResult Function() pinsDoNotMatch,
  }) {
    return pinsDoNotMatch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? success,
    TResult? Function()? pinsDoNotMatch,
  }) {
    return pinsDoNotMatch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? success,
    TResult Function()? pinsDoNotMatch,
    required TResult orElse(),
  }) {
    if (pinsDoNotMatch != null) {
      return pinsDoNotMatch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdatePinSuccess value) success,
    required TResult Function(_UpdatePinsDoNotMatch value) pinsDoNotMatch,
  }) {
    return pinsDoNotMatch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdatePinSuccess value)? success,
    TResult? Function(_UpdatePinsDoNotMatch value)? pinsDoNotMatch,
  }) {
    return pinsDoNotMatch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdatePinSuccess value)? success,
    TResult Function(_UpdatePinsDoNotMatch value)? pinsDoNotMatch,
    required TResult orElse(),
  }) {
    if (pinsDoNotMatch != null) {
      return pinsDoNotMatch(this);
    }
    return orElse();
  }
}

abstract class _UpdatePinsDoNotMatch extends UpdatePinResult {
  const factory _UpdatePinsDoNotMatch() = _$UpdatePinsDoNotMatchImpl;
  const _UpdatePinsDoNotMatch._() : super._();
}
