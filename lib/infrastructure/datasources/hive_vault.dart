/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:typed_data';

// Package imports:
import 'package:aewallet/model/data/secured_settings.dart';
import 'package:aewallet/model/keychain_secured_infos.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class HiveVaultDatasource {
  HiveVaultDatasource._(this._box);

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

  final List<int> secureKey = Hive.generateSecureKey();

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<HiveVaultDatasource> getInstance() async {
    try {
      const secureStorage = FlutterSecureStorage();
      final encryptionKey = await _readEncryptionKey(secureStorage) ??
          await _generateEncryptionKey(secureStorage);
      final encryptedBox = await Hive.openBox<dynamic>(
        _vaultBox,
        encryptionCipher: HiveAesCipher(encryptionKey),
      );
      return HiveVaultDatasource._(encryptedBox);
    } catch (e, stack) {
      dev.log('Failed to get HiveVault instance.', error: e, stackTrace: stack);
      rethrow;
    }
  }

  static Future<Uint8List> _generateEncryptionKey(
    FlutterSecureStorage secureStorage,
  ) async {
    final key = Hive.generateSecureKey();
    final secureKey = base64UrlEncode(key);
    await secureStorage.write(
      key: 'archethic_wallet_secure_key',
      value: secureKey,
    );
    return Uint8List.fromList(key);
  }

  static Future<Uint8List?> _readEncryptionKey(
    FlutterSecureStorage secureStorage,
  ) async {
    final secureKey = await secureStorage.read(
      key: 'archethic_wallet_secure_key',
    );
    if (secureKey == null || secureKey.isEmpty) {
      return null;
    }
    return base64Url.decode(secureKey);
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

  Future<void> clearAll() async {
    await _box.clear();
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
