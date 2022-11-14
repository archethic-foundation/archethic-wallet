// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
abstract class _$$PinCredentialsCopyWith<$Res> {
  factory _$$PinCredentialsCopyWith(
          _$PinCredentials value, $Res Function(_$PinCredentials) then) =
      __$$PinCredentialsCopyWithImpl<$Res>;
  @useResult
  $Res call({String pin});
}

/// @nodoc
class __$$PinCredentialsCopyWithImpl<$Res>
    extends _$CredentialsCopyWithImpl<$Res, _$PinCredentials>
    implements _$$PinCredentialsCopyWith<$Res> {
  __$$PinCredentialsCopyWithImpl(
      _$PinCredentials _value, $Res Function(_$PinCredentials) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pin = null,
  }) {
    return _then(_$PinCredentials(
      pin: null == pin
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
            (identical(other.pin, pin) || other.pin == pin));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pin);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PinCredentialsCopyWith<_$PinCredentials> get copyWith =>
      __$$PinCredentialsCopyWithImpl<_$PinCredentials>(this, _$identity);

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
  const factory PinCredentials({required final String pin}) = _$PinCredentials;
  const PinCredentials._() : super._();

  String get pin;
  @JsonKey(ignore: true)
  _$$PinCredentialsCopyWith<_$PinCredentials> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PasswordCredentialsCopyWith<$Res> {
  factory _$$PasswordCredentialsCopyWith(_$PasswordCredentials value,
          $Res Function(_$PasswordCredentials) then) =
      __$$PasswordCredentialsCopyWithImpl<$Res>;
  @useResult
  $Res call({String password, String seed});
}

/// @nodoc
class __$$PasswordCredentialsCopyWithImpl<$Res>
    extends _$CredentialsCopyWithImpl<$Res, _$PasswordCredentials>
    implements _$$PasswordCredentialsCopyWith<$Res> {
  __$$PasswordCredentialsCopyWithImpl(
      _$PasswordCredentials _value, $Res Function(_$PasswordCredentials) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? password = null,
    Object? seed = null,
  }) {
    return _then(_$PasswordCredentials(
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

class _$PasswordCredentials extends PasswordCredentials {
  const _$PasswordCredentials({required this.password, required this.seed})
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
            other is _$PasswordCredentials &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.seed, seed) || other.seed == seed));
  }

  @override
  int get hashCode => Object.hash(runtimeType, password, seed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordCredentialsCopyWith<_$PasswordCredentials> get copyWith =>
      __$$PasswordCredentialsCopyWithImpl<_$PasswordCredentials>(
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
      required final String seed}) = _$PasswordCredentials;
  const PasswordCredentials._() : super._();

  String get password;
  String get seed;
  @JsonKey(ignore: true)
  _$$PasswordCredentialsCopyWith<_$PasswordCredentials> get copyWith =>
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
abstract class _$$_AuthenticationSettingsCopyWith<$Res>
    implements $AuthenticationSettingsCopyWith<$Res> {
  factory _$$_AuthenticationSettingsCopyWith(_$_AuthenticationSettings value,
          $Res Function(_$_AuthenticationSettings) then) =
      __$$_AuthenticationSettingsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AuthMethod authenticationMethod,
      bool pinPadShuffle,
      UnlockOption lock,
      LockTimeoutOption lockTimeout});
}

/// @nodoc
class __$$_AuthenticationSettingsCopyWithImpl<$Res>
    extends _$AuthenticationSettingsCopyWithImpl<$Res,
        _$_AuthenticationSettings>
    implements _$$_AuthenticationSettingsCopyWith<$Res> {
  __$$_AuthenticationSettingsCopyWithImpl(_$_AuthenticationSettings _value,
      $Res Function(_$_AuthenticationSettings) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authenticationMethod = null,
    Object? pinPadShuffle = null,
    Object? lock = null,
    Object? lockTimeout = null,
  }) {
    return _then(_$_AuthenticationSettings(
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

class _$_AuthenticationSettings extends _AuthenticationSettings {
  const _$_AuthenticationSettings(
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
            other is _$_AuthenticationSettings &&
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
  _$$_AuthenticationSettingsCopyWith<_$_AuthenticationSettings> get copyWith =>
      __$$_AuthenticationSettingsCopyWithImpl<_$_AuthenticationSettings>(
          this, _$identity);
}

abstract class _AuthenticationSettings extends AuthenticationSettings {
  const factory _AuthenticationSettings(
          {required final AuthMethod authenticationMethod,
          required final bool pinPadShuffle,
          required final UnlockOption lock,
          required final LockTimeoutOption lockTimeout}) =
      _$_AuthenticationSettings;
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
  _$$_AuthenticationSettingsCopyWith<_$_AuthenticationSettings> get copyWith =>
      throw _privateConstructorUsedError;
}
