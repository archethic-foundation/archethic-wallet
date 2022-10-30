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
      _$PinAuthenticationStateCopyWithImpl<$Res, PinAuthenticationState>;
  @useResult
  $Res call({int failedAttemptsCount, int maxAttemptsCount});
}

/// @nodoc
class _$PinAuthenticationStateCopyWithImpl<$Res,
        $Val extends PinAuthenticationState>
    implements $PinAuthenticationStateCopyWith<$Res> {
  _$PinAuthenticationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failedAttemptsCount = null,
    Object? maxAttemptsCount = null,
  }) {
    return _then(_value.copyWith(
      failedAttemptsCount: null == failedAttemptsCount
          ? _value.failedAttemptsCount
          : failedAttemptsCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxAttemptsCount: null == maxAttemptsCount
          ? _value.maxAttemptsCount
          : maxAttemptsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PinAuthenticationStateCopyWith<$Res>
    implements $PinAuthenticationStateCopyWith<$Res> {
  factory _$$_PinAuthenticationStateCopyWith(_$_PinAuthenticationState value,
          $Res Function(_$_PinAuthenticationState) then) =
      __$$_PinAuthenticationStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int failedAttemptsCount, int maxAttemptsCount});
}

/// @nodoc
class __$$_PinAuthenticationStateCopyWithImpl<$Res>
    extends _$PinAuthenticationStateCopyWithImpl<$Res,
        _$_PinAuthenticationState>
    implements _$$_PinAuthenticationStateCopyWith<$Res> {
  __$$_PinAuthenticationStateCopyWithImpl(_$_PinAuthenticationState _value,
      $Res Function(_$_PinAuthenticationState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failedAttemptsCount = null,
    Object? maxAttemptsCount = null,
  }) {
    return _then(_$_PinAuthenticationState(
      failedAttemptsCount: null == failedAttemptsCount
          ? _value.failedAttemptsCount
          : failedAttemptsCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxAttemptsCount: null == maxAttemptsCount
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
            (identical(other.failedAttemptsCount, failedAttemptsCount) ||
                other.failedAttemptsCount == failedAttemptsCount) &&
            (identical(other.maxAttemptsCount, maxAttemptsCount) ||
                other.maxAttemptsCount == maxAttemptsCount));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, failedAttemptsCount, maxAttemptsCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
      _$AuthenticationSettingsCopyWithImpl<$Res, AuthenticationSettings>;
  @useResult
  $Res call({AuthMethod authenticationMethod, bool pinPadShuffle});
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
  $Res call({AuthMethod authenticationMethod, bool pinPadShuffle});
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
            (identical(other.authenticationMethod, authenticationMethod) ||
                other.authenticationMethod == authenticationMethod) &&
            (identical(other.pinPadShuffle, pinPadShuffle) ||
                other.pinPadShuffle == pinPadShuffle));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, authenticationMethod, pinPadShuffle);

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
