// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'model.dart';

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
    TResult Function()? success,
    TResult Function()? wrongCredentials,
    TResult Function()? notSetup,
    TResult Function()? tooMuchAttempts,
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
    TResult Function(_AuthenticationResult value)? success,
    TResult Function(_AuthenticationFailure value)? wrongCredentials,
    TResult Function(_AuthenticationNotSetup value)? notSetup,
    TResult Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
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
      _$AuthenticationResultCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthenticationResultCopyWithImpl<$Res>
    implements $AuthenticationResultCopyWith<$Res> {
  _$AuthenticationResultCopyWithImpl(this._value, this._then);

  final AuthenticationResult _value;
  // ignore: unused_field
  final $Res Function(AuthenticationResult) _then;
}

/// @nodoc
abstract class _$$_AuthenticationResultCopyWith<$Res> {
  factory _$$_AuthenticationResultCopyWith(_$_AuthenticationResult value,
          $Res Function(_$_AuthenticationResult) then) =
      __$$_AuthenticationResultCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_AuthenticationResultCopyWithImpl<$Res>
    extends _$AuthenticationResultCopyWithImpl<$Res>
    implements _$$_AuthenticationResultCopyWith<$Res> {
  __$$_AuthenticationResultCopyWithImpl(_$_AuthenticationResult _value,
      $Res Function(_$_AuthenticationResult) _then)
      : super(_value, (v) => _then(v as _$_AuthenticationResult));

  @override
  _$_AuthenticationResult get _value => super._value as _$_AuthenticationResult;
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
    TResult Function()? success,
    TResult Function()? wrongCredentials,
    TResult Function()? notSetup,
    TResult Function()? tooMuchAttempts,
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
    TResult Function(_AuthenticationResult value)? success,
    TResult Function(_AuthenticationFailure value)? wrongCredentials,
    TResult Function(_AuthenticationNotSetup value)? notSetup,
    TResult Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
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
    extends _$AuthenticationResultCopyWithImpl<$Res>
    implements _$$_AuthenticationFailureCopyWith<$Res> {
  __$$_AuthenticationFailureCopyWithImpl(_$_AuthenticationFailure _value,
      $Res Function(_$_AuthenticationFailure) _then)
      : super(_value, (v) => _then(v as _$_AuthenticationFailure));

  @override
  _$_AuthenticationFailure get _value =>
      super._value as _$_AuthenticationFailure;
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
    TResult Function()? success,
    TResult Function()? wrongCredentials,
    TResult Function()? notSetup,
    TResult Function()? tooMuchAttempts,
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
    TResult Function(_AuthenticationResult value)? success,
    TResult Function(_AuthenticationFailure value)? wrongCredentials,
    TResult Function(_AuthenticationNotSetup value)? notSetup,
    TResult Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
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
    extends _$AuthenticationResultCopyWithImpl<$Res>
    implements _$$_AuthenticationNotSetupCopyWith<$Res> {
  __$$_AuthenticationNotSetupCopyWithImpl(_$_AuthenticationNotSetup _value,
      $Res Function(_$_AuthenticationNotSetup) _then)
      : super(_value, (v) => _then(v as _$_AuthenticationNotSetup));

  @override
  _$_AuthenticationNotSetup get _value =>
      super._value as _$_AuthenticationNotSetup;
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
    TResult Function()? success,
    TResult Function()? wrongCredentials,
    TResult Function()? notSetup,
    TResult Function()? tooMuchAttempts,
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
    TResult Function(_AuthenticationResult value)? success,
    TResult Function(_AuthenticationFailure value)? wrongCredentials,
    TResult Function(_AuthenticationNotSetup value)? notSetup,
    TResult Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
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
    extends _$AuthenticationResultCopyWithImpl<$Res>
    implements _$$_AuthenticationTooMuchAttemptsCopyWith<$Res> {
  __$$_AuthenticationTooMuchAttemptsCopyWithImpl(
      _$_AuthenticationTooMuchAttempts _value,
      $Res Function(_$_AuthenticationTooMuchAttempts) _then)
      : super(_value, (v) => _then(v as _$_AuthenticationTooMuchAttempts));

  @override
  _$_AuthenticationTooMuchAttempts get _value =>
      super._value as _$_AuthenticationTooMuchAttempts;
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
    TResult Function()? success,
    TResult Function()? wrongCredentials,
    TResult Function()? notSetup,
    TResult Function()? tooMuchAttempts,
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
    TResult Function(_AuthenticationResult value)? success,
    TResult Function(_AuthenticationFailure value)? wrongCredentials,
    TResult Function(_AuthenticationNotSetup value)? notSetup,
    TResult Function(_AuthenticationTooMuchAttempts value)? tooMuchAttempts,
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
mixin _$Credentials {
  String get pin => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pin) pin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String pin)? pin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pin)? pin,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PinCredentials value) pin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(PinCredentials value)? pin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PinCredentials value)? pin,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CredentialsCopyWith<Credentials> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredentialsCopyWith<$Res> {
  factory $CredentialsCopyWith(
          Credentials value, $Res Function(Credentials) then) =
      _$CredentialsCopyWithImpl<$Res>;
  $Res call({String pin});
}

/// @nodoc
class _$CredentialsCopyWithImpl<$Res> implements $CredentialsCopyWith<$Res> {
  _$CredentialsCopyWithImpl(this._value, this._then);

  final Credentials _value;
  // ignore: unused_field
  final $Res Function(Credentials) _then;

  @override
  $Res call({
    Object? pin = freezed,
  }) {
    return _then(_value.copyWith(
      pin: pin == freezed
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$PinCredentialsCopyWith<$Res>
    implements $CredentialsCopyWith<$Res> {
  factory _$$PinCredentialsCopyWith(
          _$PinCredentials value, $Res Function(_$PinCredentials) then) =
      __$$PinCredentialsCopyWithImpl<$Res>;
  @override
  $Res call({String pin});
}

/// @nodoc
class __$$PinCredentialsCopyWithImpl<$Res>
    extends _$CredentialsCopyWithImpl<$Res>
    implements _$$PinCredentialsCopyWith<$Res> {
  __$$PinCredentialsCopyWithImpl(
      _$PinCredentials _value, $Res Function(_$PinCredentials) _then)
      : super(_value, (v) => _then(v as _$PinCredentials));

  @override
  _$PinCredentials get _value => super._value as _$PinCredentials;

  @override
  $Res call({
    Object? pin = freezed,
  }) {
    return _then(_$PinCredentials(
      pin: pin == freezed
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PinCredentials extends PinCredentials {
  const _$PinCredentials({required this.pin}) : super._();

  @override
  final String pin;

  @override
  String toString() {
    return 'Credentials.pin(pin: $pin)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PinCredentials &&
            const DeepCollectionEquality().equals(other.pin, pin));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(pin));

  @JsonKey(ignore: true)
  @override
  _$$PinCredentialsCopyWith<_$PinCredentials> get copyWith =>
      __$$PinCredentialsCopyWithImpl<_$PinCredentials>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pin) pin,
  }) {
    return pin(this.pin);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String pin)? pin,
  }) {
    return pin?.call(this.pin);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pin)? pin,
    required TResult orElse(),
  }) {
    if (pin != null) {
      return pin(this.pin);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PinCredentials value) pin,
  }) {
    return pin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(PinCredentials value)? pin,
  }) {
    return pin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PinCredentials value)? pin,
    required TResult orElse(),
  }) {
    if (pin != null) {
      return pin(this);
    }
    return orElse();
  }
}

abstract class PinCredentials extends Credentials {
  const factory PinCredentials({required final String pin}) = _$PinCredentials;
  const PinCredentials._() : super._();

  @override
  String get pin;
  @override
  @JsonKey(ignore: true)
  _$$PinCredentialsCopyWith<_$PinCredentials> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PinAuthenticationState {
  int get failedAttemptsCount => throw _privateConstructorUsedError;
  int get maxAttemptsCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PinAuthenticationStateCopyWith<PinAuthenticationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PinAuthenticationStateCopyWith<$Res> {
  factory $PinAuthenticationStateCopyWith(PinAuthenticationState value,
          $Res Function(PinAuthenticationState) then) =
      _$PinAuthenticationStateCopyWithImpl<$Res>;
  $Res call({int failedAttemptsCount, int maxAttemptsCount});
}

/// @nodoc
class _$PinAuthenticationStateCopyWithImpl<$Res>
    implements $PinAuthenticationStateCopyWith<$Res> {
  _$PinAuthenticationStateCopyWithImpl(this._value, this._then);

  final PinAuthenticationState _value;
  // ignore: unused_field
  final $Res Function(PinAuthenticationState) _then;

  @override
  $Res call({
    Object? failedAttemptsCount = freezed,
    Object? maxAttemptsCount = freezed,
  }) {
    return _then(_value.copyWith(
      failedAttemptsCount: failedAttemptsCount == freezed
          ? _value.failedAttemptsCount
          : failedAttemptsCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxAttemptsCount: maxAttemptsCount == freezed
          ? _value.maxAttemptsCount
          : maxAttemptsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_PinAuthenticationStateCopyWith<$Res>
    implements $PinAuthenticationStateCopyWith<$Res> {
  factory _$$_PinAuthenticationStateCopyWith(_$_PinAuthenticationState value,
          $Res Function(_$_PinAuthenticationState) then) =
      __$$_PinAuthenticationStateCopyWithImpl<$Res>;
  @override
  $Res call({int failedAttemptsCount, int maxAttemptsCount});
}

/// @nodoc
class __$$_PinAuthenticationStateCopyWithImpl<$Res>
    extends _$PinAuthenticationStateCopyWithImpl<$Res>
    implements _$$_PinAuthenticationStateCopyWith<$Res> {
  __$$_PinAuthenticationStateCopyWithImpl(_$_PinAuthenticationState _value,
      $Res Function(_$_PinAuthenticationState) _then)
      : super(_value, (v) => _then(v as _$_PinAuthenticationState));

  @override
  _$_PinAuthenticationState get _value =>
      super._value as _$_PinAuthenticationState;

  @override
  $Res call({
    Object? failedAttemptsCount = freezed,
    Object? maxAttemptsCount = freezed,
  }) {
    return _then(_$_PinAuthenticationState(
      failedAttemptsCount: failedAttemptsCount == freezed
          ? _value.failedAttemptsCount
          : failedAttemptsCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxAttemptsCount: maxAttemptsCount == freezed
          ? _value.maxAttemptsCount
          : maxAttemptsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_PinAuthenticationState extends _PinAuthenticationState {
  const _$_PinAuthenticationState(
      {required this.failedAttemptsCount, required this.maxAttemptsCount})
      : super._();

  @override
  final int failedAttemptsCount;
  @override
  final int maxAttemptsCount;

  @override
  String toString() {
    return 'PinAuthenticationState(failedAttemptsCount: $failedAttemptsCount, maxAttemptsCount: $maxAttemptsCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PinAuthenticationState &&
            const DeepCollectionEquality()
                .equals(other.failedAttemptsCount, failedAttemptsCount) &&
            const DeepCollectionEquality()
                .equals(other.maxAttemptsCount, maxAttemptsCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(failedAttemptsCount),
      const DeepCollectionEquality().hash(maxAttemptsCount));

  @JsonKey(ignore: true)
  @override
  _$$_PinAuthenticationStateCopyWith<_$_PinAuthenticationState> get copyWith =>
      __$$_PinAuthenticationStateCopyWithImpl<_$_PinAuthenticationState>(
          this, _$identity);
}

abstract class _PinAuthenticationState extends PinAuthenticationState {
  const factory _PinAuthenticationState(
      {required final int failedAttemptsCount,
      required final int maxAttemptsCount}) = _$_PinAuthenticationState;
  const _PinAuthenticationState._() : super._();

  @override
  int get failedAttemptsCount;
  @override
  int get maxAttemptsCount;
  @override
  @JsonKey(ignore: true)
  _$$_PinAuthenticationStateCopyWith<_$_PinAuthenticationState> get copyWith =>
      throw _privateConstructorUsedError;
}
