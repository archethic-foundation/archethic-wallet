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
mixin _$Credentials {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pin) pin,
    required TResult Function(String password, String seed) password,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pin)? pin,
    TResult? Function(String password, String seed)? password,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pin)? pin,
    TResult Function(String password, String seed)? password,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PinCredentials value) pin,
    required TResult Function(PasswordCredentials value) password,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PinCredentials value)? pin,
    TResult? Function(PasswordCredentials value)? password,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PinCredentials value)? pin,
    TResult Function(PasswordCredentials value)? password,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredentialsCopyWith<$Res> {
  factory $CredentialsCopyWith(
          Credentials value, $Res Function(Credentials) then) =
      _$CredentialsCopyWithImpl<$Res, Credentials>;
}

/// @nodoc
class _$CredentialsCopyWithImpl<$Res, $Val extends Credentials>
    implements $CredentialsCopyWith<$Res> {
  _$CredentialsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$PinCredentialsImplCopyWith<$Res> {
  factory _$$PinCredentialsImplCopyWith(_$PinCredentialsImpl value,
          $Res Function(_$PinCredentialsImpl) then) =
      __$$PinCredentialsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String pin});
}

/// @nodoc
class __$$PinCredentialsImplCopyWithImpl<$Res>
    extends _$CredentialsCopyWithImpl<$Res, _$PinCredentialsImpl>
    implements _$$PinCredentialsImplCopyWith<$Res> {
  __$$PinCredentialsImplCopyWithImpl(
      _$PinCredentialsImpl _value, $Res Function(_$PinCredentialsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pin = null,
  }) {
    return _then(_$PinCredentialsImpl(
      pin: null == pin
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PinCredentialsImpl extends PinCredentials {
  const _$PinCredentialsImpl({required this.pin}) : super._();

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
            other is _$PinCredentialsImpl &&
            (identical(other.pin, pin) || other.pin == pin));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pin);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PinCredentialsImplCopyWith<_$PinCredentialsImpl> get copyWith =>
      __$$PinCredentialsImplCopyWithImpl<_$PinCredentialsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pin) pin,
    required TResult Function(String password, String seed) password,
  }) {
    return pin(this.pin);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pin)? pin,
    TResult? Function(String password, String seed)? password,
  }) {
    return pin?.call(this.pin);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pin)? pin,
    TResult Function(String password, String seed)? password,
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
    required TResult Function(PasswordCredentials value) password,
  }) {
    return pin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PinCredentials value)? pin,
    TResult? Function(PasswordCredentials value)? password,
  }) {
    return pin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PinCredentials value)? pin,
    TResult Function(PasswordCredentials value)? password,
    required TResult orElse(),
  }) {
    if (pin != null) {
      return pin(this);
    }
    return orElse();
  }
}

abstract class PinCredentials extends Credentials {
  const factory PinCredentials({required final String pin}) =
      _$PinCredentialsImpl;
  const PinCredentials._() : super._();

  String get pin;
  @JsonKey(ignore: true)
  _$$PinCredentialsImplCopyWith<_$PinCredentialsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PasswordCredentialsImplCopyWith<$Res> {
  factory _$$PasswordCredentialsImplCopyWith(_$PasswordCredentialsImpl value,
          $Res Function(_$PasswordCredentialsImpl) then) =
      __$$PasswordCredentialsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String password, String seed});
}

/// @nodoc
class __$$PasswordCredentialsImplCopyWithImpl<$Res>
    extends _$CredentialsCopyWithImpl<$Res, _$PasswordCredentialsImpl>
    implements _$$PasswordCredentialsImplCopyWith<$Res> {
  __$$PasswordCredentialsImplCopyWithImpl(_$PasswordCredentialsImpl _value,
      $Res Function(_$PasswordCredentialsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? password = null,
    Object? seed = null,
  }) {
    return _then(_$PasswordCredentialsImpl(
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      seed: null == seed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PasswordCredentialsImpl extends PasswordCredentials {
  const _$PasswordCredentialsImpl({required this.password, required this.seed})
      : super._();

  @override
  final String password;
  @override
  final String seed;

  @override
  String toString() {
    return 'Credentials.password(password: $password, seed: $seed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordCredentialsImpl &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.seed, seed) || other.seed == seed));
  }

  @override
  int get hashCode => Object.hash(runtimeType, password, seed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordCredentialsImplCopyWith<_$PasswordCredentialsImpl> get copyWith =>
      __$$PasswordCredentialsImplCopyWithImpl<_$PasswordCredentialsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pin) pin,
    required TResult Function(String password, String seed) password,
  }) {
    return password(this.password, seed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pin)? pin,
    TResult? Function(String password, String seed)? password,
  }) {
    return password?.call(this.password, seed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pin)? pin,
    TResult Function(String password, String seed)? password,
    required TResult orElse(),
  }) {
    if (password != null) {
      return password(this.password, seed);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PinCredentials value) pin,
    required TResult Function(PasswordCredentials value) password,
  }) {
    return password(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PinCredentials value)? pin,
    TResult? Function(PasswordCredentials value)? password,
  }) {
    return password?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PinCredentials value)? pin,
    TResult Function(PasswordCredentials value)? password,
    required TResult orElse(),
  }) {
    if (password != null) {
      return password(this);
    }
    return orElse();
  }
}

abstract class PasswordCredentials extends Credentials {
  const factory PasswordCredentials(
      {required final String password,
      required final String seed}) = _$PasswordCredentialsImpl;
  const PasswordCredentials._() : super._();

  String get password;
  String get seed;
  @JsonKey(ignore: true)
  _$$PasswordCredentialsImplCopyWith<_$PasswordCredentialsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AuthenticationSettings {
  AuthMethod get authenticationMethod => throw _privateConstructorUsedError;
  bool get pinPadShuffle => throw _privateConstructorUsedError;
  UnlockOption get lock => throw _privateConstructorUsedError;
  LockTimeoutOption get lockTimeout => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthenticationSettingsCopyWith<AuthenticationSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationSettingsCopyWith<$Res> {
  factory $AuthenticationSettingsCopyWith(AuthenticationSettings value,
          $Res Function(AuthenticationSettings) then) =
      _$AuthenticationSettingsCopyWithImpl<$Res, AuthenticationSettings>;
  @useResult
  $Res call(
      {AuthMethod authenticationMethod,
      bool pinPadShuffle,
      UnlockOption lock,
      LockTimeoutOption lockTimeout});
}

/// @nodoc
class _$AuthenticationSettingsCopyWithImpl<$Res,
        $Val extends AuthenticationSettings>
    implements $AuthenticationSettingsCopyWith<$Res> {
  _$AuthenticationSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authenticationMethod = null,
    Object? pinPadShuffle = null,
    Object? lock = null,
    Object? lockTimeout = null,
  }) {
    return _then(_value.copyWith(
      authenticationMethod: null == authenticationMethod
          ? _value.authenticationMethod
          : authenticationMethod // ignore: cast_nullable_to_non_nullable
              as AuthMethod,
      pinPadShuffle: null == pinPadShuffle
          ? _value.pinPadShuffle
          : pinPadShuffle // ignore: cast_nullable_to_non_nullable
              as bool,
      lock: null == lock
          ? _value.lock
          : lock // ignore: cast_nullable_to_non_nullable
              as UnlockOption,
      lockTimeout: null == lockTimeout
          ? _value.lockTimeout
          : lockTimeout // ignore: cast_nullable_to_non_nullable
              as LockTimeoutOption,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthenticationSettingsImplCopyWith<$Res>
    implements $AuthenticationSettingsCopyWith<$Res> {
  factory _$$AuthenticationSettingsImplCopyWith(
          _$AuthenticationSettingsImpl value,
          $Res Function(_$AuthenticationSettingsImpl) then) =
      __$$AuthenticationSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AuthMethod authenticationMethod,
      bool pinPadShuffle,
      UnlockOption lock,
      LockTimeoutOption lockTimeout});
}

/// @nodoc
class __$$AuthenticationSettingsImplCopyWithImpl<$Res>
    extends _$AuthenticationSettingsCopyWithImpl<$Res,
        _$AuthenticationSettingsImpl>
    implements _$$AuthenticationSettingsImplCopyWith<$Res> {
  __$$AuthenticationSettingsImplCopyWithImpl(
      _$AuthenticationSettingsImpl _value,
      $Res Function(_$AuthenticationSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authenticationMethod = null,
    Object? pinPadShuffle = null,
    Object? lock = null,
    Object? lockTimeout = null,
  }) {
    return _then(_$AuthenticationSettingsImpl(
      authenticationMethod: null == authenticationMethod
          ? _value.authenticationMethod
          : authenticationMethod // ignore: cast_nullable_to_non_nullable
              as AuthMethod,
      pinPadShuffle: null == pinPadShuffle
          ? _value.pinPadShuffle
          : pinPadShuffle // ignore: cast_nullable_to_non_nullable
              as bool,
      lock: null == lock
          ? _value.lock
          : lock // ignore: cast_nullable_to_non_nullable
              as UnlockOption,
      lockTimeout: null == lockTimeout
          ? _value.lockTimeout
          : lockTimeout // ignore: cast_nullable_to_non_nullable
              as LockTimeoutOption,
    ));
  }
}

/// @nodoc

class _$AuthenticationSettingsImpl extends _AuthenticationSettings {
  const _$AuthenticationSettingsImpl(
      {required this.authenticationMethod,
      required this.pinPadShuffle,
      required this.lock,
      required this.lockTimeout})
      : super._();

  @override
  final AuthMethod authenticationMethod;
  @override
  final bool pinPadShuffle;
  @override
  final UnlockOption lock;
  @override
  final LockTimeoutOption lockTimeout;

  @override
  String toString() {
    return 'AuthenticationSettings(authenticationMethod: $authenticationMethod, pinPadShuffle: $pinPadShuffle, lock: $lock, lockTimeout: $lockTimeout)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationSettingsImpl &&
            (identical(other.authenticationMethod, authenticationMethod) ||
                other.authenticationMethod == authenticationMethod) &&
            (identical(other.pinPadShuffle, pinPadShuffle) ||
                other.pinPadShuffle == pinPadShuffle) &&
            (identical(other.lock, lock) || other.lock == lock) &&
            (identical(other.lockTimeout, lockTimeout) ||
                other.lockTimeout == lockTimeout));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, authenticationMethod, pinPadShuffle, lock, lockTimeout);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationSettingsImplCopyWith<_$AuthenticationSettingsImpl>
      get copyWith => __$$AuthenticationSettingsImplCopyWithImpl<
          _$AuthenticationSettingsImpl>(this, _$identity);
}

abstract class _AuthenticationSettings extends AuthenticationSettings {
  const factory _AuthenticationSettings(
          {required final AuthMethod authenticationMethod,
          required final bool pinPadShuffle,
          required final UnlockOption lock,
          required final LockTimeoutOption lockTimeout}) =
      _$AuthenticationSettingsImpl;
  const _AuthenticationSettings._() : super._();

  @override
  AuthMethod get authenticationMethod;
  @override
  bool get pinPadShuffle;
  @override
  UnlockOption get lock;
  @override
  LockTimeoutOption get lockTimeout;
  @override
  @JsonKey(ignore: true)
  _$$AuthenticationSettingsImplCopyWith<_$AuthenticationSettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
