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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_AuthenticationResultCopyWith<$Res> {
  factory _$$_AuthenticationResultCopyWith(_$_AuthenticationResult value,
          $Res Function(_$_AuthenticationResult) then) =
      __$$_AuthenticationResultCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_AuthenticationResultCopyWithImpl<$Res>
    extends _$AuthenticationResultCopyWithImpl<$Res, _$_AuthenticationResult>
    implements _$$_AuthenticationResultCopyWith<$Res> {
  __$$_AuthenticationResultCopyWithImpl(_$_AuthenticationResult _value,
      $Res Function(_$_AuthenticationResult) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_AuthenticationResult extends _AuthenticationResult {
  const _$_AuthenticationResult() : super._();

  @override
  String toString() {
    return 'AuthenticationResult.success()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_AuthenticationResult);
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
  const factory _AuthenticationResult() = _$_AuthenticationResult;
  const _AuthenticationResult._() : super._();
}

/// @nodoc
abstract class _$$_AuthenticationFailureCopyWith<$Res> {
  factory _$$_AuthenticationFailureCopyWith(_$_AuthenticationFailure value,
          $Res Function(_$_AuthenticationFailure) then) =
      __$$_AuthenticationFailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_AuthenticationFailureCopyWithImpl<$Res>
    extends _$AuthenticationResultCopyWithImpl<$Res, _$_AuthenticationFailure>
    implements _$$_AuthenticationFailureCopyWith<$Res> {
  __$$_AuthenticationFailureCopyWithImpl(_$_AuthenticationFailure _value,
      $Res Function(_$_AuthenticationFailure) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_AuthenticationFailure extends _AuthenticationFailure {
  const _$_AuthenticationFailure() : super._();

  @override
  String toString() {
    return 'AuthenticationResult.wrongCredentials()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_AuthenticationFailure);
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
  const factory _AuthenticationFailure() = _$_AuthenticationFailure;
  const _AuthenticationFailure._() : super._();
}

/// @nodoc
abstract class _$$_AuthenticationNotSetupCopyWith<$Res> {
  factory _$$_AuthenticationNotSetupCopyWith(_$_AuthenticationNotSetup value,
          $Res Function(_$_AuthenticationNotSetup) then) =
      __$$_AuthenticationNotSetupCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_AuthenticationNotSetupCopyWithImpl<$Res>
    extends _$AuthenticationResultCopyWithImpl<$Res, _$_AuthenticationNotSetup>
    implements _$$_AuthenticationNotSetupCopyWith<$Res> {
  __$$_AuthenticationNotSetupCopyWithImpl(_$_AuthenticationNotSetup _value,
      $Res Function(_$_AuthenticationNotSetup) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_AuthenticationNotSetup extends _AuthenticationNotSetup {
  const _$_AuthenticationNotSetup() : super._();

  @override
  String toString() {
    return 'AuthenticationResult.notSetup()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthenticationNotSetup);
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
  const factory _AuthenticationNotSetup() = _$_AuthenticationNotSetup;
  const _AuthenticationNotSetup._() : super._();
}

/// @nodoc
abstract class _$$_AuthenticationTooMuchAttemptsCopyWith<$Res> {
  factory _$$_AuthenticationTooMuchAttemptsCopyWith(
          _$_AuthenticationTooMuchAttempts value,
          $Res Function(_$_AuthenticationTooMuchAttempts) then) =
      __$$_AuthenticationTooMuchAttemptsCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_AuthenticationTooMuchAttemptsCopyWithImpl<$Res>
    extends _$AuthenticationResultCopyWithImpl<$Res,
        _$_AuthenticationTooMuchAttempts>
    implements _$$_AuthenticationTooMuchAttemptsCopyWith<$Res> {
  __$$_AuthenticationTooMuchAttemptsCopyWithImpl(
      _$_AuthenticationTooMuchAttempts _value,
      $Res Function(_$_AuthenticationTooMuchAttempts) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_AuthenticationTooMuchAttempts extends _AuthenticationTooMuchAttempts {
  const _$_AuthenticationTooMuchAttempts() : super._();

  @override
  String toString() {
    return 'AuthenticationResult.tooMuchAttempts()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthenticationTooMuchAttempts);
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
      _$_AuthenticationTooMuchAttempts;
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
abstract class _$$_UpdatePinSuccessCopyWith<$Res> {
  factory _$$_UpdatePinSuccessCopyWith(
          _$_UpdatePinSuccess value, $Res Function(_$_UpdatePinSuccess) then) =
      __$$_UpdatePinSuccessCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_UpdatePinSuccessCopyWithImpl<$Res>
    extends _$UpdatePinResultCopyWithImpl<$Res, _$_UpdatePinSuccess>
    implements _$$_UpdatePinSuccessCopyWith<$Res> {
  __$$_UpdatePinSuccessCopyWithImpl(
      _$_UpdatePinSuccess _value, $Res Function(_$_UpdatePinSuccess) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_UpdatePinSuccess extends _UpdatePinSuccess {
  const _$_UpdatePinSuccess() : super._();

  @override
  String toString() {
    return 'UpdatePinResult.success()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_UpdatePinSuccess);
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
  const factory _UpdatePinSuccess() = _$_UpdatePinSuccess;
  const _UpdatePinSuccess._() : super._();
}

/// @nodoc
abstract class _$$_UpdatePinsDoNotMatchCopyWith<$Res> {
  factory _$$_UpdatePinsDoNotMatchCopyWith(_$_UpdatePinsDoNotMatch value,
          $Res Function(_$_UpdatePinsDoNotMatch) then) =
      __$$_UpdatePinsDoNotMatchCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_UpdatePinsDoNotMatchCopyWithImpl<$Res>
    extends _$UpdatePinResultCopyWithImpl<$Res, _$_UpdatePinsDoNotMatch>
    implements _$$_UpdatePinsDoNotMatchCopyWith<$Res> {
  __$$_UpdatePinsDoNotMatchCopyWithImpl(_$_UpdatePinsDoNotMatch _value,
      $Res Function(_$_UpdatePinsDoNotMatch) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_UpdatePinsDoNotMatch extends _UpdatePinsDoNotMatch {
  const _$_UpdatePinsDoNotMatch() : super._();

  @override
  String toString() {
    return 'UpdatePinResult.pinsDoNotMatch()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_UpdatePinsDoNotMatch);
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
  const factory _UpdatePinsDoNotMatch() = _$_UpdatePinsDoNotMatch;
  const _UpdatePinsDoNotMatch._() : super._();
}
