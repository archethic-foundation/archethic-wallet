// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_wallet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppWallet {
  String get seed => throw _privateConstructorUsedError;
  AppKeychain get appKeychain => throw _privateConstructorUsedError;
  Map<String, KeychainServiceKeyPair> get keychainServiceKeyPairMap =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppWalletCopyWith<AppWallet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppWalletCopyWith<$Res> {
  factory $AppWalletCopyWith(AppWallet value, $Res Function(AppWallet) then) =
      _$AppWalletCopyWithImpl<$Res, AppWallet>;
  @useResult
  $Res call(
      {String seed,
      AppKeychain appKeychain,
      Map<String, KeychainServiceKeyPair> keychainServiceKeyPairMap});
}

/// @nodoc
class _$AppWalletCopyWithImpl<$Res, $Val extends AppWallet>
    implements $AppWalletCopyWith<$Res> {
  _$AppWalletCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seed = null,
    Object? appKeychain = null,
    Object? keychainServiceKeyPairMap = null,
  }) {
    return _then(_value.copyWith(
      seed: null == seed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as String,
      appKeychain: null == appKeychain
          ? _value.appKeychain
          : appKeychain // ignore: cast_nullable_to_non_nullable
              as AppKeychain,
      keychainServiceKeyPairMap: null == keychainServiceKeyPairMap
          ? _value.keychainServiceKeyPairMap
          : keychainServiceKeyPairMap // ignore: cast_nullable_to_non_nullable
              as Map<String, KeychainServiceKeyPair>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppWalletCopyWith<$Res> implements $AppWalletCopyWith<$Res> {
  factory _$$_AppWalletCopyWith(
          _$_AppWallet value, $Res Function(_$_AppWallet) then) =
      __$$_AppWalletCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String seed,
      AppKeychain appKeychain,
      Map<String, KeychainServiceKeyPair> keychainServiceKeyPairMap});
}

/// @nodoc
class __$$_AppWalletCopyWithImpl<$Res>
    extends _$AppWalletCopyWithImpl<$Res, _$_AppWallet>
    implements _$$_AppWalletCopyWith<$Res> {
  __$$_AppWalletCopyWithImpl(
      _$_AppWallet _value, $Res Function(_$_AppWallet) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seed = null,
    Object? appKeychain = null,
    Object? keychainServiceKeyPairMap = null,
  }) {
    return _then(_$_AppWallet(
      seed: null == seed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as String,
      appKeychain: null == appKeychain
          ? _value.appKeychain
          : appKeychain // ignore: cast_nullable_to_non_nullable
              as AppKeychain,
      keychainServiceKeyPairMap: null == keychainServiceKeyPairMap
          ? _value._keychainServiceKeyPairMap
          : keychainServiceKeyPairMap // ignore: cast_nullable_to_non_nullable
              as Map<String, KeychainServiceKeyPair>,
    ));
  }
}

/// @nodoc

class _$_AppWallet extends _AppWallet {
  const _$_AppWallet(
      {required this.seed,
      required this.appKeychain,
      final Map<String, KeychainServiceKeyPair> keychainServiceKeyPairMap =
          const {}})
      : _keychainServiceKeyPairMap = keychainServiceKeyPairMap,
        super._();

  @override
  final String seed;
  @override
  final AppKeychain appKeychain;
  final Map<String, KeychainServiceKeyPair> _keychainServiceKeyPairMap;
  @override
  @JsonKey()
  Map<String, KeychainServiceKeyPair> get keychainServiceKeyPairMap {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_keychainServiceKeyPairMap);
  }

  @override
  String toString() {
    return 'AppWallet(seed: $seed, appKeychain: $appKeychain, keychainServiceKeyPairMap: $keychainServiceKeyPairMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppWallet &&
            (identical(other.seed, seed) || other.seed == seed) &&
            (identical(other.appKeychain, appKeychain) ||
                other.appKeychain == appKeychain) &&
            const DeepCollectionEquality().equals(
                other._keychainServiceKeyPairMap, _keychainServiceKeyPairMap));
  }

  @override
  int get hashCode => Object.hash(runtimeType, seed, appKeychain,
      const DeepCollectionEquality().hash(_keychainServiceKeyPairMap));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppWalletCopyWith<_$_AppWallet> get copyWith =>
      __$$_AppWalletCopyWithImpl<_$_AppWallet>(this, _$identity);
}

abstract class _AppWallet extends AppWallet {
  const factory _AppWallet(
      {required final String seed,
      required final AppKeychain appKeychain,
      final Map<String, KeychainServiceKeyPair>
          keychainServiceKeyPairMap}) = _$_AppWallet;
  const _AppWallet._() : super._();

  @override
  String get seed;
  @override
  AppKeychain get appKeychain;
  @override
  Map<String, KeychainServiceKeyPair> get keychainServiceKeyPairMap;
  @override
  @JsonKey(ignore: true)
  _$$_AppWalletCopyWith<_$_AppWallet> get copyWith =>
      throw _privateConstructorUsedError;
}
