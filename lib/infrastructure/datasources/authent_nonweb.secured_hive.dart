/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:convert';
import 'dart:typed_data';

import 'package:aewallet/infrastructure/datasources/hive.extension.dart';
import 'package:aewallet/infrastructure/datasources/vault/vault.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:logging/logging.dart';

/// Class used on non-web platforms only
/// It stores authent infos in FlutterSecureStorage
///
/// On Web platforms authent info are not stored as is. They are instead used to encrypt the [Vault] AES key.
class AuthentHiveSecuredDatasource {
  AuthentHiveSecuredDatasource._(this._box);

  static final _logger = Logger('AuthentHiveSecuredDatasource');

  static const _authenticationBox = 'NonWebAuthentication';
  final Box<dynamic> _box;

  static const _pin = 'archethic_wallet_pin';
  static const _password = 'archethic_wallet_password';
  static const _yubikeyClientID = 'archethic_wallet_yubikeyClientID';
  static const _yubikeyClientAPIKey = 'archethic_wallet_yubikeyClientAPIKey';

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

  static Future<void> clear() async {
    await Hive.deleteBox<dynamic>(_authenticationBox);
  }

  static Future<Box<E>> _openSecuredBox<E>(
    String name,
  ) async {
    try {
      return await Hive.openBox<E>(
        name,
        encryptionCipher:
            await _AuthentHiveSecuredDatasourceSecureKey.prepareCipher(),
      );
    } catch (e, stack) {
      _logger.severe('Failed to open Hive encrypted Box<$E>($name).', e, stack);
      rethrow;
    }
  }
}

extension _AuthentHiveSecuredDatasourceSecureKey
    on AuthentHiveSecuredDatasource {
  static const kSecureKey = 'archethic_wallet_authent_secure_key';

  static Future<HiveCipher> prepareCipher() async => HiveAesCipher(
        await _readSecureKey() ?? await _initSecureKey(),
      );

  static Future<Uint8List?> _readSecureKey() async {
    const secureStorage = FlutterSecureStorage();

    final key = await secureStorage.read(key: kSecureKey);
    if (key != null) return base64Decode(key);

    return null;
  }

  static Future<Uint8List> _initSecureKey() async {
    const secureStorage = FlutterSecureStorage();

    final key = Uint8List.fromList(Hive.generateSecureKey());
    await secureStorage.write(
      key: kSecureKey,
      value: base64Encode(key),
    );
    return key;
  }

  static Future<void> _clearSecureKey() async {
    const secureStorage = FlutterSecureStorage();

    await secureStorage.delete(
      key: kSecureKey,
    );
  }
}
