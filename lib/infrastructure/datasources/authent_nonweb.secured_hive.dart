/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:developer';

import 'package:aewallet/infrastructure/datasources/vault/vault.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

/// Class used on non-web platforms only
/// It stores authent infos in FlutterSecureStorage
///
/// On Web platforms authent info are not stored as is. They are instead used to encrypt the [Vault] AES key.
class AuthentHiveSecuredDatasource {
  AuthentHiveSecuredDatasource._(this._box);

  static const String _authenticationBox = 'NonWebAuthentication';
  final Box<dynamic> _box;

  static const String _pin = 'archethic_wallet_pin';
  static const String _password = 'archethic_wallet_password';
  static const String _yubikeyClientID = 'archethic_wallet_yubikeyClientID';
  static const String _yubikeyClientAPIKey =
      'archethic_wallet_yubikeyClientAPIKey';

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<AuthentHiveSecuredDatasource> getInstance() async {
    final encryptedBox = await _openSecuredBox(_authenticationBox);
    return AuthentHiveSecuredDatasource._(encryptedBox);
  }

  T _getValue<T>(dynamic key, {T? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T;

  Future<void> _setValue<T>(dynamic key, T value) => _box.put(key, value);

  Future<void> _removeValue<T>(dynamic key) => _box.delete(key);

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

  Future<void> clearAll() async {
    await _box.clear();
  }

  static Future<Box<E>> _openSecuredBox<E>(
    String name,
  ) async {
    try {
      return await Hive.openBox<E>(
        name,
        encryptionCipher: await _prepareCipher(),
      );
    } catch (e, stack) {
      log(
        'Failed to open Hive encrypted Box<$E>($name).',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  static Future<HiveCipher> _prepareCipher() async {
    const secureStorage = FlutterSecureStorage();
    final encryptionKey = await Hive.readSecureKey(secureStorage) ??
        await Hive.generateAndStoreSecureKey(secureStorage);

    return HiveAesCipher(encryptionKey);
  }
}
