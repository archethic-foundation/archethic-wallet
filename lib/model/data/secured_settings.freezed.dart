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

  @JsonKey(ignore: true)
  $SecuredSettingsCopyWith<SecuredSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecuredSettingsCopyWith<$Res> {
  factory $SecuredSettingsCopyWith(
          SecuredSettings value, $Res Function(SecuredSettings) then) =
      _$SecuredSettingsCopyWithImpl<$Res>;
  $Res call(
      {String? seed,
      String? pin,
      String? password,
      String? yubikeyClientID,
      String? yubikeyClientAPIKey});
}

/// @nodoc
class _$SecuredSettingsCopyWithImpl<$Res>
    implements $SecuredSettingsCopyWith<$Res> {
  _$SecuredSettingsCopyWithImpl(this._value, this._then);

  final SecuredSettings _value;
  // ignore: unused_field
  final $Res Function(SecuredSettings) _then;

  @override
  $Res call({
    Object? seed = freezed,
    Object? pin = freezed,
    Object? password = freezed,
    Object? yubikeyClientID = freezed,
    Object? yubikeyClientAPIKey = freezed,
  }) {
    return _then(_value.copyWith(
      seed: seed == freezed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as String?,
      pin: pin == freezed
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      yubikeyClientID: yubikeyClientID == freezed
          ? _value.yubikeyClientID
          : yubikeyClientID // ignore: cast_nullable_to_non_nullable
              as String?,
      yubikeyClientAPIKey: yubikeyClientAPIKey == freezed
          ? _value.yubikeyClientAPIKey
          : yubikeyClientAPIKey // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_SecuredSettingsCopyWith<$Res>
    implements $SecuredSettingsCopyWith<$Res> {
  factory _$$_SecuredSettingsCopyWith(
          _$_SecuredSettings value, $Res Function(_$_SecuredSettings) then) =
      __$$_SecuredSettingsCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? seed,
      String? pin,
      String? password,
      String? yubikeyClientID,
      String? yubikeyClientAPIKey});
}

/// @nodoc
class __$$_SecuredSettingsCopyWithImpl<$Res>
    extends _$SecuredSettingsCopyWithImpl<$Res>
    implements _$$_SecuredSettingsCopyWith<$Res> {
  __$$_SecuredSettingsCopyWithImpl(
      _$_SecuredSettings _value, $Res Function(_$_SecuredSettings) _then)
      : super(_value, (v) => _then(v as _$_SecuredSettings));

  @override
  _$_SecuredSettings get _value => super._value as _$_SecuredSettings;

  @override
  $Res call({
    Object? seed = freezed,
    Object? pin = freezed,
    Object? password = freezed,
    Object? yubikeyClientID = freezed,
    Object? yubikeyClientAPIKey = freezed,
  }) {
    return _then(_$_SecuredSettings(
      seed: seed == freezed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as String?,
      pin: pin == freezed
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      yubikeyClientID: yubikeyClientID == freezed
          ? _value.yubikeyClientID
          : yubikeyClientID // ignore: cast_nullable_to_non_nullable
              as String?,
      yubikeyClientAPIKey: yubikeyClientAPIKey == freezed
          ? _value.yubikeyClientAPIKey
          : yubikeyClientAPIKey // ignore: cast_nullable_to_non_nullable
              as String?,
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
      this.yubikeyClientAPIKey})
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
  String toString() {
    return 'SecuredSettings(seed: $seed, pin: $pin, password: $password, yubikeyClientID: $yubikeyClientID, yubikeyClientAPIKey: $yubikeyClientAPIKey)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SecuredSettings &&
            const DeepCollectionEquality().equals(other.seed, seed) &&
            const DeepCollectionEquality().equals(other.pin, pin) &&
            const DeepCollectionEquality().equals(other.password, password) &&
            const DeepCollectionEquality()
                .equals(other.yubikeyClientID, yubikeyClientID) &&
            const DeepCollectionEquality()
                .equals(other.yubikeyClientAPIKey, yubikeyClientAPIKey));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(seed),
      const DeepCollectionEquality().hash(pin),
      const DeepCollectionEquality().hash(password),
      const DeepCollectionEquality().hash(yubikeyClientID),
      const DeepCollectionEquality().hash(yubikeyClientAPIKey));

  @JsonKey(ignore: true)
  @override
  _$$_SecuredSettingsCopyWith<_$_SecuredSettings> get copyWith =>
      __$$_SecuredSettingsCopyWithImpl<_$_SecuredSettings>(this, _$identity);
}

abstract class _SecuredSettings extends SecuredSettings {
  const factory _SecuredSettings(
      {final String? seed,
      final String? pin,
      final String? password,
      final String? yubikeyClientID,
      final String? yubikeyClientAPIKey}) = _$_SecuredSettings;
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
  @JsonKey(ignore: true)
  _$$_SecuredSettingsCopyWith<_$_SecuredSettings> get copyWith =>
      throw _privateConstructorUsedError;
}
