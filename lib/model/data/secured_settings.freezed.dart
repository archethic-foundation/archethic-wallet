// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'secured_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SecuredSettings {
  String? get seed => throw _privateConstructorUsedError;
  String? get pin => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String? get yubikeyClientID => throw _privateConstructorUsedError;
  String? get yubikeyClientAPIKey => throw _privateConstructorUsedError;
  KeychainSecuredInfos? get keychainSecuredInfos =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SecuredSettingsCopyWith<SecuredSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecuredSettingsCopyWith<$Res> {
  factory $SecuredSettingsCopyWith(
          SecuredSettings value, $Res Function(SecuredSettings) then) =
      _$SecuredSettingsCopyWithImpl<$Res, SecuredSettings>;
  @useResult
  $Res call(
      {String? seed,
      String? pin,
      String? password,
      String? yubikeyClientID,
      String? yubikeyClientAPIKey,
      KeychainSecuredInfos? keychainSecuredInfos});

  $KeychainSecuredInfosCopyWith<$Res>? get keychainSecuredInfos;
}

/// @nodoc
class _$SecuredSettingsCopyWithImpl<$Res, $Val extends SecuredSettings>
    implements $SecuredSettingsCopyWith<$Res> {
  _$SecuredSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seed = freezed,
    Object? pin = freezed,
    Object? password = freezed,
    Object? yubikeyClientID = freezed,
    Object? yubikeyClientAPIKey = freezed,
    Object? keychainSecuredInfos = freezed,
  }) {
    return _then(_value.copyWith(
      seed: freezed == seed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as String?,
      pin: freezed == pin
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      yubikeyClientID: freezed == yubikeyClientID
          ? _value.yubikeyClientID
          : yubikeyClientID // ignore: cast_nullable_to_non_nullable
              as String?,
      yubikeyClientAPIKey: freezed == yubikeyClientAPIKey
          ? _value.yubikeyClientAPIKey
          : yubikeyClientAPIKey // ignore: cast_nullable_to_non_nullable
              as String?,
      keychainSecuredInfos: freezed == keychainSecuredInfos
          ? _value.keychainSecuredInfos
          : keychainSecuredInfos // ignore: cast_nullable_to_non_nullable
              as KeychainSecuredInfos?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $KeychainSecuredInfosCopyWith<$Res>? get keychainSecuredInfos {
    if (_value.keychainSecuredInfos == null) {
      return null;
    }

    return $KeychainSecuredInfosCopyWith<$Res>(_value.keychainSecuredInfos!,
        (value) {
      return _then(_value.copyWith(keychainSecuredInfos: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SecuredSettingsImplCopyWith<$Res>
    implements $SecuredSettingsCopyWith<$Res> {
  factory _$$SecuredSettingsImplCopyWith(_$SecuredSettingsImpl value,
          $Res Function(_$SecuredSettingsImpl) then) =
      __$$SecuredSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? seed,
      String? pin,
      String? password,
      String? yubikeyClientID,
      String? yubikeyClientAPIKey,
      KeychainSecuredInfos? keychainSecuredInfos});

  @override
  $KeychainSecuredInfosCopyWith<$Res>? get keychainSecuredInfos;
}

/// @nodoc
class __$$SecuredSettingsImplCopyWithImpl<$Res>
    extends _$SecuredSettingsCopyWithImpl<$Res, _$SecuredSettingsImpl>
    implements _$$SecuredSettingsImplCopyWith<$Res> {
  __$$SecuredSettingsImplCopyWithImpl(
      _$SecuredSettingsImpl _value, $Res Function(_$SecuredSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seed = freezed,
    Object? pin = freezed,
    Object? password = freezed,
    Object? yubikeyClientID = freezed,
    Object? yubikeyClientAPIKey = freezed,
    Object? keychainSecuredInfos = freezed,
  }) {
    return _then(_$SecuredSettingsImpl(
      seed: freezed == seed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as String?,
      pin: freezed == pin
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      yubikeyClientID: freezed == yubikeyClientID
          ? _value.yubikeyClientID
          : yubikeyClientID // ignore: cast_nullable_to_non_nullable
              as String?,
      yubikeyClientAPIKey: freezed == yubikeyClientAPIKey
          ? _value.yubikeyClientAPIKey
          : yubikeyClientAPIKey // ignore: cast_nullable_to_non_nullable
              as String?,
      keychainSecuredInfos: freezed == keychainSecuredInfos
          ? _value.keychainSecuredInfos
          : keychainSecuredInfos // ignore: cast_nullable_to_non_nullable
              as KeychainSecuredInfos?,
    ));
  }
}

/// @nodoc

class _$SecuredSettingsImpl extends _SecuredSettings {
  const _$SecuredSettingsImpl(
      {this.seed,
      this.pin,
      this.password,
      this.yubikeyClientID,
      this.yubikeyClientAPIKey,
      this.keychainSecuredInfos})
      : super._();

  @override
  final String? seed;
  @override
  final String? pin;
  @override
  final String? password;
  @override
  final String? yubikeyClientID;
  @override
  final String? yubikeyClientAPIKey;
  @override
  final KeychainSecuredInfos? keychainSecuredInfos;

  @override
  String toString() {
    return 'SecuredSettings(seed: $seed, pin: $pin, password: $password, yubikeyClientID: $yubikeyClientID, yubikeyClientAPIKey: $yubikeyClientAPIKey, keychainSecuredInfos: $keychainSecuredInfos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecuredSettingsImpl &&
            (identical(other.seed, seed) || other.seed == seed) &&
            (identical(other.pin, pin) || other.pin == pin) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.yubikeyClientID, yubikeyClientID) ||
                other.yubikeyClientID == yubikeyClientID) &&
            (identical(other.yubikeyClientAPIKey, yubikeyClientAPIKey) ||
                other.yubikeyClientAPIKey == yubikeyClientAPIKey) &&
            (identical(other.keychainSecuredInfos, keychainSecuredInfos) ||
                other.keychainSecuredInfos == keychainSecuredInfos));
  }

  @override
  int get hashCode => Object.hash(runtimeType, seed, pin, password,
      yubikeyClientID, yubikeyClientAPIKey, keychainSecuredInfos);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SecuredSettingsImplCopyWith<_$SecuredSettingsImpl> get copyWith =>
      __$$SecuredSettingsImplCopyWithImpl<_$SecuredSettingsImpl>(
          this, _$identity);
}

abstract class _SecuredSettings extends SecuredSettings {
  const factory _SecuredSettings(
          {final String? seed,
          final String? pin,
          final String? password,
          final String? yubikeyClientID,
          final String? yubikeyClientAPIKey,
          final KeychainSecuredInfos? keychainSecuredInfos}) =
      _$SecuredSettingsImpl;
  const _SecuredSettings._() : super._();

  @override
  String? get seed;
  @override
  String? get pin;
  @override
  String? get password;
  @override
  String? get yubikeyClientID;
  @override
  String? get yubikeyClientAPIKey;
  @override
  KeychainSecuredInfos? get keychainSecuredInfos;
  @override
  @JsonKey(ignore: true)
  _$$SecuredSettingsImplCopyWith<_$SecuredSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
