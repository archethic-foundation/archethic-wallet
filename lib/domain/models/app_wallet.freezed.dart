// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_wallet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppWallet {
  String get seed =>
      throw _privateConstructorUsedError; // TODO(redddwarf03): Mutualize keychain infos
  AppKeychain get appKeychain => throw _privateConstructorUsedError;
  KeychainSecuredInfos get keychainSecuredInfos =>
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
      KeychainSecuredInfos keychainSecuredInfos});

  $KeychainSecuredInfosCopyWith<$Res> get keychainSecuredInfos;
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
    Object? keychainSecuredInfos = null,
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
      keychainSecuredInfos: null == keychainSecuredInfos
          ? _value.keychainSecuredInfos
          : keychainSecuredInfos // ignore: cast_nullable_to_non_nullable
              as KeychainSecuredInfos,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $KeychainSecuredInfosCopyWith<$Res> get keychainSecuredInfos {
    return $KeychainSecuredInfosCopyWith<$Res>(_value.keychainSecuredInfos,
        (value) {
      return _then(_value.copyWith(keychainSecuredInfos: value) as $Val);
    });
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
      KeychainSecuredInfos keychainSecuredInfos});

  @override
  $KeychainSecuredInfosCopyWith<$Res> get keychainSecuredInfos;
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
    Object? keychainSecuredInfos = null,
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
      keychainSecuredInfos: null == keychainSecuredInfos
          ? _value.keychainSecuredInfos
          : keychainSecuredInfos // ignore: cast_nullable_to_non_nullable
              as KeychainSecuredInfos,
    ));
  }
}

/// @nodoc

class _$_AppWallet extends _AppWallet {
  const _$_AppWallet(
      {required this.seed,
      required this.appKeychain,
      required this.keychainSecuredInfos})
      : super._();

  @override
  final String seed;
// TODO(redddwarf03): Mutualize keychain infos
  @override
  final AppKeychain appKeychain;
  @override
  final KeychainSecuredInfos keychainSecuredInfos;

  @override
  String toString() {
    return 'AppWallet(seed: $seed, appKeychain: $appKeychain, keychainSecuredInfos: $keychainSecuredInfos)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppWallet &&
            (identical(other.seed, seed) || other.seed == seed) &&
            (identical(other.appKeychain, appKeychain) ||
                other.appKeychain == appKeychain) &&
            (identical(other.keychainSecuredInfos, keychainSecuredInfos) ||
                other.keychainSecuredInfos == keychainSecuredInfos));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, seed, appKeychain, keychainSecuredInfos);

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
      required final KeychainSecuredInfos keychainSecuredInfos}) = _$_AppWallet;
  const _AppWallet._() : super._();

  @override
  String get seed;
  @override // TODO(redddwarf03): Mutualize keychain infos
  AppKeychain get appKeychain;
  @override
  KeychainSecuredInfos get keychainSecuredInfos;
  @override
  @JsonKey(ignore: true)
  _$$_AppWalletCopyWith<_$_AppWallet> get copyWith =>
      throw _privateConstructorUsedError;
}
