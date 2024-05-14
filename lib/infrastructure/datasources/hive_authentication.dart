/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:convert';

import 'package:aewallet/infrastructure/datasources/vault.dart';
import 'package:aewallet/model/blockchain/keychain_secured_infos.dart';
import 'package:aewallet/model/data/secured_settings.dart';
import 'package:hive/hive.dart';

class HiveAuthenticationDatasource {
  HiveAuthenticationDatasource._(this._box);

  static const String _vaultBox = '_vaultBox';
  final Box<dynamic> _box;

  //
  static const String _seed = 'archethic_wallet_seed';
  static const String _pin = 'archethic_wallet_pin';
  static const String _password = 'archethic_wallet_password';
  static const String _yubikeyClientID = 'archethic_wallet_yubikeyClientID';
  static const String _yubikeyClientAPIKey =
      'archethic_wallet_yubikeyClientAPIKey';
  static const String _keychainSecuredInfos =
      'archethic_keychain_secured_infos';

  static HiveAuthenticationDatasource? _instance;
  static Future<HiveAuthenticationDatasource> getInstance() async {
    if (_instance?._box.isOpen == true) return _instance!;

    final encryptedBox = await Vault.instance().openBox(_vaultBox);
    return _instance = HiveAuthenticationDatasource._(encryptedBox);
  }

  static Future<bool> get boxExists => Vault.instance().boxExists(_vaultBox);
  static Future<void> clear() async {
    Vault.instance().clear(_vaultBox);
  }

  T _getValue<T>(dynamic key, {T? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T;

  Future<void> _setValue<T>(dynamic key, T value) => _box.put(key, value);

  Future<void> _removeValue<T>(dynamic key) => _box.delete(key);

  Future<void> setSeed(String v) => _setValue(_seed, v);

  String? getSeed() => _getValue(_seed);

  Future<void> deleteSeed() async {
    return _removeValue(_seed);
  }

  Future<void> setPin(String v) => _setValue(_pin, v);

  String? getPin() => _getValue(_pin);

  Future<void> deletePin() async {
    return _removeValue(_pin);
  }

  Future<void> setPassword(String v) => _setValue(_password, v);

  String? getPassword() => _getValue(_password);

  Future<void> deletePassword() async {
    return _removeValue(_password);
  }

  Future<void> setYubikeyClientAPIKey(String v) =>
      _setValue(_yubikeyClientAPIKey, v);

  String getYubikeyClientAPIKey() =>
      _getValue(_yubikeyClientAPIKey, defaultValue: '');

  Future<void> setYubikeyClientID(String v) => _setValue(_yubikeyClientID, v);

  String getYubikeyClientID() => _getValue(_yubikeyClientID, defaultValue: '');

  Future<void> setKeychainSecuredInfos(
    KeychainSecuredInfos v,
  ) {
    try {
      return _setValue(
        _keychainSecuredInfos,
        json.encode(v),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  KeychainSecuredInfos? getKeychainSecuredInfos() {
    try {
      final map = json.decode(_getValue(_keychainSecuredInfos));
      return KeychainSecuredInfos.fromJson(map);
    } catch (e) {
      return null;
    }
  }

  SecuredSettings toModel() => SecuredSettings(
        seed: getSeed(),
        password: getPassword(),
        pin: getPin(),
        yubikeyClientAPIKey: getYubikeyClientAPIKey(),
        yubikeyClientID: getYubikeyClientID(),
        keychainSecuredInfos: getKeychainSecuredInfos(),
      );
}
