/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:typed_data';

// Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class Vault {
  Vault._(this._box);

  static const String _vaultBox = '_vaultBox';
  final Box<dynamic> _box;

  //
  static const String _seed = 'archethic_seed';
  static const String _pin = 'archethic_pin';
  static const String _password = 'archethic_password';
  static const String _yubikeyClientID = 'archethic_yubikeyClientID';
  static const String _yubikeyClientAPIKey = 'archethic_yubikeyClientAPIKey';

  final List<int> secureKey = Hive.generateSecureKey();

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<Vault> getInstance() async {
    try {
      const FlutterSecureStorage secureStorage = FlutterSecureStorage();
      final Uint8List encryptionKey;
      String? _secureKey =
          await secureStorage.read(key: 'archethic_secure_key');
      if (_secureKey == null || _secureKey.isEmpty) {
        final List<int> key = Hive.generateSecureKey();
        encryptionKey = Uint8List.fromList(key);
        _secureKey = base64UrlEncode(key);
        await secureStorage.write(
            key: 'archethic_secure_key', value: _secureKey);
      } else {
        encryptionKey = base64Url.decode(_secureKey);
      }
      final Box<dynamic> encryptedBox = await Hive.openBox<dynamic>(_vaultBox,
          encryptionCipher: HiveAesCipher(encryptionKey));
      return Vault._(encryptedBox);
    } catch (e) {
      dev.log(e.toString());
      throw Exception();
    }
  }

  T _getValue<T>(dynamic key, {T? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T;

  Future<void> _setValue<T>(dynamic key, T value) => _box.put(key, value);

  Future<void> _removeValue<T>(dynamic key) => _box.delete(key);

  Future<void> setSeed(String v) => _setValue(_seed, v);

  String? getSeed() => _getValue(_seed);

  Future<void> deleteSeed() async {
    return await _removeValue(_seed);
  }

  Future<void> setPin(String v) => _setValue(_pin, v);

  String? getPin() => _getValue(_pin);

  Future<void> deletePin() async {
    return await _removeValue(_pin);
  }

  Future<void> setPassword(String v) => _setValue(_password, v);

  String? getPassword() => _getValue(_password);

  Future<void> deletePassword() async {
    return await _removeValue(_password);
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
}
