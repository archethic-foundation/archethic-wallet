import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

mixin SecuredHiveMixin {
  final List<int> secureKey = Hive.generateSecureKey();

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<Box<E>> openSecuredBox<E>(
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

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<LazyBox<E>> openLazySecuredBox<E>(
    String name,
  ) async {
    try {
      return Hive.openLazyBox<E>(
        name,
        encryptionCipher: await _prepareCipher(),
      );
    } catch (e, stack) {
      log(
        'Failed to open Hive encrypted LazyBox<$E>($name).',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  static Future<HiveCipher> _prepareCipher() async {
    const secureStorage = FlutterSecureStorage();
    final encryptionKey = await _readEncryptionKey(secureStorage) ??
        await _generateEncryptionKey(secureStorage);

    return HiveAesCipher(encryptionKey);
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
}
