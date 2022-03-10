// Dart imports:
import 'dart:convert';
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/foundation.dart';

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
      if (kDebugMode) {
        print(e);
      }
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

  Future<void> deleteAll() async {
    await deleteSecureKey();
    _box.deleteFromDisk();
  }

  Future<void> deleteSecureKey() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    await secureStorage.delete(key: 'archethic_secure_key');
  }
}
