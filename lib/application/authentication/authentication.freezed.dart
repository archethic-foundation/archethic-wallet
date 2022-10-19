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

/// @nodoc
mixin _$AuthenticationSettings {
  AuthMethod get authenticationMethod => throw _privateConstructorUsedError;
  bool get pinPadShuffle => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthenticationSettingsCopyWith<AuthenticationSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationSettingsCopyWith<$Res> {
  factory $AuthenticationSettingsCopyWith(AuthenticationSettings value,
          $Res Function(AuthenticationSettings) then) =
      _$AuthenticationSettingsCopyWithImpl<$Res>;
  $Res call({AuthMethod authenticationMethod, bool pinPadShuffle});
}

/// @nodoc
class _$AuthenticationSettingsCopyWithImpl<$Res>
    implements $AuthenticationSettingsCopyWith<$Res> {
  _$AuthenticationSettingsCopyWithImpl(this._value, this._then);

  final AuthenticationSettings _value;
  // ignore: unused_field
  final $Res Function(AuthenticationSettings) _then;

  @override
  $Res call({
    Object? authenticationMethod = freezed,
    Object? pinPadShuffle = freezed,
  }) {
    return _then(_value.copyWith(
      authenticationMethod: authenticationMethod == freezed
          ? _value.authenticationMethod
          : authenticationMethod // ignore: cast_nullable_to_non_nullable
              as AuthMethod,
      pinPadShuffle: pinPadShuffle == freezed
          ? _value.pinPadShuffle
          : pinPadShuffle // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_AuthenticationSettingsCopyWith<$Res>
    implements $AuthenticationSettingsCopyWith<$Res> {
  factory _$$_AuthenticationSettingsCopyWith(_$_AuthenticationSettings value,
          $Res Function(_$_AuthenticationSettings) then) =
      __$$_AuthenticationSettingsCopyWithImpl<$Res>;
  @override
  $Res call({AuthMethod authenticationMethod, bool pinPadShuffle});
}

/// @nodoc
class __$$_AuthenticationSettingsCopyWithImpl<$Res>
    extends _$AuthenticationSettingsCopyWithImpl<$Res>
    implements _$$_AuthenticationSettingsCopyWith<$Res> {
  __$$_AuthenticationSettingsCopyWithImpl(_$_AuthenticationSettings _value,
      $Res Function(_$_AuthenticationSettings) _then)
      : super(_value, (v) => _then(v as _$_AuthenticationSettings));

  @override
  _$_AuthenticationSettings get _value =>
      super._value as _$_AuthenticationSettings;

  @override
  $Res call({
    Object? authenticationMethod = freezed,
    Object? pinPadShuffle = freezed,
  }) {
    return _then(_$_AuthenticationSettings(
      authenticationMethod: authenticationMethod == freezed
          ? _value.authenticationMethod
          : authenticationMethod // ignore: cast_nullable_to_non_nullable
              as AuthMethod,
      pinPadShuffle: pinPadShuffle == freezed
          ? _value.pinPadShuffle
          : pinPadShuffle // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_AuthenticationSettings extends _AuthenticationSettings {
  const _$_AuthenticationSettings(
      {required this.authenticationMethod, required this.pinPadShuffle})
      : super._();

  @override
  final AuthMethod authenticationMethod;
  @override
  final bool pinPadShuffle;

  @override
  String toString() {
    return 'AuthenticationSettings(authenticationMethod: $authenticationMethod, pinPadShuffle: $pinPadShuffle)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthenticationSettings &&
            const DeepCollectionEquality()
                .equals(other.authenticationMethod, authenticationMethod) &&
            const DeepCollectionEquality()
                .equals(other.pinPadShuffle, pinPadShuffle));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(authenticationMethod),
      const DeepCollectionEquality().hash(pinPadShuffle));

  @JsonKey(ignore: true)
  @override
  _$$_AuthenticationSettingsCopyWith<_$_AuthenticationSettings> get copyWith =>
      __$$_AuthenticationSettingsCopyWithImpl<_$_AuthenticationSettings>(
          this, _$identity);
}

abstract class _AuthenticationSettings extends AuthenticationSettings {
  const factory _AuthenticationSettings(
      {required final AuthMethod authenticationMethod,
      required final bool pinPadShuffle}) = _$_AuthenticationSettings;
  const _AuthenticationSettings._() : super._();

  @override
  AuthMethod get authenticationMethod;
  @override
  bool get pinPadShuffle;
  @override
  @JsonKey(ignore: true)
  _$$_AuthenticationSettingsCopyWith<_$_AuthenticationSettings> get copyWith =>
      throw _privateConstructorUsedError;
}
