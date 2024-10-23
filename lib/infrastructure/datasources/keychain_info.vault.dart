/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:convert';

import 'package:aewallet/infrastructure/datasources/vault/vault.dart';
import 'package:aewallet/model/blockchain/keychain_secured_infos.dart';
import 'package:hive/hive.dart';

class KeychainInfoVaultDatasource {
  KeychainInfoVaultDatasource._(this._box);

  static const String _vaultBox = '_vaultBox';
  final Box<dynamic> _box;

  static const String _seed = 'archethic_wallet_seed';
  static const String _keychainSecuredInfos =
      'archethic_keychain_secured_infos';

  static KeychainInfoVaultDatasource? _instance;
  static Future<KeychainInfoVaultDatasource> getInstance() async {
    if (_instance?._box.isOpen == true) return _instance!;

    final encryptedBox = await Vault.instance().openBox(_vaultBox);
    return _instance = KeychainInfoVaultDatasource._(encryptedBox);
  }

  static Future<bool> get boxExists => Vault.instance().boxExists(_vaultBox);
  static Future<void> clear() => Vault.instance().clear(_vaultBox);

  T? _getValue<T>(dynamic key, {T? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T?;

  Future<void> _setValue<T>(dynamic key, T value) => _box.put(key, value);

  Future<void> _removeValue<T>(dynamic key) => _box.delete(key);

  Future<void> setSeed(String v) => _setValue(_seed, v);

  String? getSeed() => _getValue(_seed);

  Future<void> deleteSeed() async {
    return _removeValue(_seed);
  }

  Future<void> setKeychainSecuredInfos(
    KeychainSecuredInfos v,
  ) {
    return _setValue(
      _keychainSecuredInfos,
      json.encode(v),
    );
  }

  KeychainSecuredInfos? getKeychainSecuredInfos() {
    final value = _getValue(_keychainSecuredInfos);
    if (value == null) return null;

    final map = json.decode(value);
    return KeychainSecuredInfos.fromJson(map);
  }
}
