// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
  Map<String, KeychainServiceKeyPair>? get keychainServiceKeyPairMap =>
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
      Map<String, KeychainServiceKeyPair>? keychainServiceKeyPairMap});
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
    Object? keychainServiceKeyPairMap = freezed,
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
      keychainServiceKeyPairMap: freezed == keychainServiceKeyPairMap
          ? _value.keychainServiceKeyPairMap
          : keychainServiceKeyPairMap // ignore: cast_nullable_to_non_nullable
              as Map<String, KeychainServiceKeyPair>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SecuredSettingsCopyWith<$Res>
    implements $SecuredSettingsCopyWith<$Res> {
  factory _$$_SecuredSettingsCopyWith(
          _$_SecuredSettings value, $Res Function(_$_SecuredSettings) then) =
      __$$_SecuredSettingsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? seed,
      String? pin,
      String? password,
      String? yubikeyClientID,
      String? yubikeyClientAPIKey,
      Map<String, KeychainServiceKeyPair>? keychainServiceKeyPairMap});
}

/// @nodoc
class __$$_SecuredSettingsCopyWithImpl<$Res>
    extends _$SecuredSettingsCopyWithImpl<$Res, _$_SecuredSettings>
    implements _$$_SecuredSettingsCopyWith<$Res> {
  __$$_SecuredSettingsCopyWithImpl(
      _$_SecuredSettings _value, $Res Function(_$_SecuredSettings) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seed = freezed,
    Object? pin = freezed,
    Object? password = freezed,
    Object? yubikeyClientID = freezed,
    Object? yubikeyClientAPIKey = freezed,
    Object? keychainServiceKeyPairMap = freezed,
  }) {
    return _then(_$_SecuredSettings(
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
      keychainServiceKeyPairMap: freezed == keychainServiceKeyPairMap
          ? _value._keychainServiceKeyPairMap
          : keychainServiceKeyPairMap // ignore: cast_nullable_to_non_nullable
              as Map<String, KeychainServiceKeyPair>?,
    ));
  }
}

/// @nodoc

class _$_SecuredSettings extends _SecuredSettings {
  const _$_SecuredSettings(
      {this.seed,
      this.pin,
      this.password,
      this.yubikeyClientID,
      this.yubikeyClientAPIKey,
      final Map<String, KeychainServiceKeyPair>? keychainServiceKeyPairMap})
      : _keychainServiceKeyPairMap = keychainServiceKeyPairMap,
        super._();

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
  final Map<String, KeychainServiceKeyPair>? _keychainServiceKeyPairMap;
  @override
  Map<String, KeychainServiceKeyPair>? get keychainServiceKeyPairMap {
    final value = _keychainServiceKeyPairMap;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'SecuredSettings(seed: $seed, pin: $pin, password: $password, yubikeyClientID: $yubikeyClientID, yubikeyClientAPIKey: $yubikeyClientAPIKey, keychainServiceKeyPairMap: $keychainServiceKeyPairMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SecuredSettings &&
            (identical(other.seed, seed) || other.seed == seed) &&
            (identical(other.pin, pin) || other.pin == pin) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.yubikeyClientID, yubikeyClientID) ||
                other.yubikeyClientID == yubikeyClientID) &&
            (identical(other.yubikeyClientAPIKey, yubikeyClientAPIKey) ||
                other.yubikeyClientAPIKey == yubikeyClientAPIKey) &&
            const DeepCollectionEquality().equals(
                other._keychainServiceKeyPairMap, _keychainServiceKeyPairMap));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      seed,
      pin,
      password,
      yubikeyClientID,
      yubikeyClientAPIKey,
      const DeepCollectionEquality().hash(_keychainServiceKeyPairMap));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SecuredSettingsCopyWith<_$_SecuredSettings> get copyWith =>
      __$$_SecuredSettingsCopyWithImpl<_$_SecuredSettings>(this, _$identity);
}

abstract class _SecuredSettings extends SecuredSettings {
  const factory _SecuredSettings(
      {final String? seed,
      final String? pin,
      final String? password,
      final String? yubikeyClientID,
      final String? yubikeyClientAPIKey,
      final Map<String, KeychainServiceKeyPair>?
          keychainServiceKeyPairMap}) = _$_SecuredSettings;
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
  Map<String, KeychainServiceKeyPair>? get keychainServiceKeyPairMap;
  @override
  @JsonKey(ignore: true)
  _$$_SecuredSettingsCopyWith<_$_SecuredSettings> get copyWith =>
      throw _privateConstructorUsedError;
}
