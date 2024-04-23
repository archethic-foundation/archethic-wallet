import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/key_derivators/api.dart';
import 'package:pointycastle/key_derivators/pbkdf2.dart';
import 'package:pointycastle/macs/hmac.dart';

mixin SecuredHiveMixin {
  final List<int> secureKey = Hive.generateSecureKey();

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<Box<E>> openSecuredBox<E>(
    String name,
    String? password,
  ) async {
    try {
      return await Hive.openBox<E>(
        name,
        encryptionCipher: kIsWeb
            ? await _prepareCipherWeb(password!)
            : await _prepareCipher(),
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
    String? password,
  ) async {
    try {
      return Hive.openLazyBox<E>(
        name,
        encryptionCipher: kIsWeb
            ? await _prepareCipherWeb(password!)
            : await _prepareCipher(),
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

  static Future<HiveCipher> _prepareCipherWeb(String userPassword) async {
    const secureStorage = FlutterSecureStorage();
    final encryptionKey =
        await _readEncryptionKeyWeb(secureStorage, userPassword) ??
            await _generateEncryptionKeyWeb(secureStorage, userPassword);

    return HiveAesCipher(encryptionKey);
  }

  static Future<Uint8List> _generateEncryptionKeyWeb(
    FlutterSecureStorage secureStorage,
    String userPassword,
  ) async {
    if (kIsWeb == false) {
      return Uint8List.fromList([]);
    }

    final salt = math.Random.secure().nextInt(256).toString();
    final derivedKey = _generatePBKDFKey(userPassword, salt);

    final hiveKey = Hive.generateSecureKey();
    final encryptedKey = archethic.ecEncrypt(
      archethic.uint8ListToHex(Uint8List.fromList(hiveKey)),
      derivedKey,
    );

    await secureStorage.write(
      key: 'encryptedHiveKey',
      value: base64UrlEncode(encryptedKey.toList()),
    );
    await secureStorage.write(
      key: 'keySalt',
      value: base64UrlEncode(archethic.hexToUint8List(salt)),
    );

    return Uint8List.fromList(hiveKey);
  }

  static Future<Uint8List?> _readEncryptionKeyWeb(
    FlutterSecureStorage secureStorage,
    String userPassword,
  ) async {
    if (kIsWeb == false) {
      return Uint8List.fromList([]);
    }

    final encryptedKeyBase64 =
        await secureStorage.read(key: 'encryptedHiveKey');
    final saltBase64 = await secureStorage.read(key: 'keySalt');

    if (encryptedKeyBase64 == null || saltBase64 == null) {
      return null;
    }

    final encryptedKey = base64Url.decode(encryptedKeyBase64);
    final salt = archethic.uint8ListToHex(base64Url.decode(saltBase64));

    final derivedKey = _generatePBKDFKey(userPassword, salt);

    final decryptedKey = archethic.ecDecrypt(encryptedKey, derivedKey);

    return decryptedKey;
  }

  // method to generate encryption key using user's password.
  static Uint8List _generatePBKDFKey(
    String password,
    String salt, {
    int iterations = 10000,
    int derivedKeyLength = 32,
  }) {
    final passwordBytes = utf8.encode(password);
    final saltBytes = utf8.encode(salt);

    final params = Pbkdf2Parameters(
      Uint8List.fromList(saltBytes),
      iterations,
      derivedKeyLength,
    );
    final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64));

    // ignore: cascade_invocations
    pbkdf2.init(params);

    return pbkdf2.process(Uint8List.fromList(passwordBytes));
  }
}
