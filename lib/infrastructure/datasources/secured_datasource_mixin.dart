import 'dart:convert';

import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pointycastle/export.dart';

// mixin SecuredHiveMixin {
// final List<int> secureKey = Hive.generateSecureKey();

// This doesn't have to be a singleton.
// We just want to make sure that the box is open, before we start getting/setting objects on it
// static Future<Box<E>> openSecuredBox<E>(
//   String name,
//   String? password,
// ) async {
//   try {
//     return await Hive.openBox<E>(
//       name,
//       encryptionCipher: kIsWeb
//           ? await _prepareCipherWeb(password!)
//           : await _prepareCipher(),
//     );
//   } catch (e, stack) {
//     log(
//       'Failed to open Hive encrypted Box<$E>($name).',
//       error: e,
//       stackTrace: stack,
//     );
//     rethrow;
//   }
// }

// This doesn't have to be a singleton.
// We just want to make sure that the box is open, before we start getting/setting objects on it
// static Future<LazyBox<E>> openLazySecuredBox<E>(
//   String name,
//   String? password,
// ) async {
//   try {
//     return Hive.openLazyBox<E>(
//       name,
//       encryptionCipher: kIsWeb
//           ? await _prepareCipherWeb(password!)
//           : await _prepareCipher(),
//     );
//   } catch (e, stack) {
//     log(
//       'Failed to open Hive encrypted LazyBox<$E>($name).',
//       error: e,
//       stackTrace: stack,
//     );
//     rethrow;
//   }
// }

// static Future<HiveCipher> _prepareCipher() async {
//   const secureStorage = FlutterSecureStorage();
//   final encryptionKey = await Hive.readSecureKey(secureStorage) ??
//       await Hive.generateAndStoreSecureKey(secureStorage);

//   return HiveAesCipher(encryptionKey);
// }

// static Future<HiveCipher> _prepareCipherWeb(String password) async {
//   const secureStorage = FlutterSecureStorage();

//   final encryptionKey = await Hive.readEncryptedSecureKey(
//         secureStorage,
//         password,
//       ) ??
//       await Hive.generateAndStoreEncryptedSecureKey(
//         secureStorage,
//         password,
//       );

//   return HiveAesCipher(encryptionKey);
// }
// }

extension HiveEncryptedSecuredKey on HiveInterface {
  static const kSecureKey = 'archethic_wallet_secure_key';
  static const kEncryptedSecureKey = 'archethic_wallet_encrypted_secure_key';
  static const kEncryptedSecureKeySalt =
      'archethic_wallet_encrypted_secure_key_salt';

  Future<bool> isSecureKeyDefined(
    FlutterSecureStorage secureStorage,
  ) async =>
      secureStorage.containsKey(key: kSecureKey);

  Future<void> clearSecureKey(
    FlutterSecureStorage secureStorage,
  ) =>
      secureStorage.delete(key: kSecureKey);

  Future<Uint8List> generateAndStoreSecureKey(
    FlutterSecureStorage secureStorage,
  ) async {
    final hiveKey = Hive.generateSecureKey();

    await secureStorage.write(
      key: kSecureKey,
      value: base64UrlEncode(hiveKey.toList()),
    );

    return Uint8List.fromList(hiveKey);
  }

  Future<Uint8List?> readSecureKey(
    FlutterSecureStorage secureStorage,
  ) async {
    final keyBase64 = await secureStorage.read(
      key: kSecureKey,
    );

    if (keyBase64 == null) {
      return null;
    }

    return base64Url.decode(keyBase64);
  }

  Future<Uint8List> updateAndStoreEncryptedSecureKey(
    FlutterSecureStorage secureStorage,
    Uint8List hiveKey,
    String newPassword,
  ) async {
    final salt = archethic.generateRandomSeed();
    final encryptedKey = encryptSecureKey(
      salt,
      newPassword,
      hiveKey,
    );

    await secureStorage.write(
      key: kEncryptedSecureKey,
      value: base64UrlEncode(encryptedKey.toList()),
    );
    await secureStorage.write(
      key: kEncryptedSecureKeySalt,
      value: base64UrlEncode(archethic.hexToUint8List(salt)),
    );

    return Uint8List.fromList(hiveKey);
  }

  Future<Uint8List> generateAndStoreEncryptedSecureKey(
    FlutterSecureStorage secureStorage,
    String password,
  ) async {
    final salt = archethic.generateRandomSeed();

    final hiveKey = Hive.generateSecureKey();
    final encryptedKey = encryptSecureKey(
      salt,
      password,
      Uint8List.fromList(hiveKey),
    );

    await secureStorage.write(
      key: kEncryptedSecureKey,
      value: base64UrlEncode(encryptedKey.toList()),
    );
    await secureStorage.write(
      key: kEncryptedSecureKeySalt,
      value: base64UrlEncode(archethic.hexToUint8List(salt)),
    );

    return Uint8List.fromList(hiveKey);
  }

  Future<bool> isEncryptedSecureKeyDefined(
    FlutterSecureStorage secureStorage,
  ) async {
    final keyDefined = await secureStorage.containsKey(
      key: kEncryptedSecureKey,
    );
    final keySaltDefined = await secureStorage.containsKey(
      key: kEncryptedSecureKeySalt,
    );

    return keyDefined && keySaltDefined;
  }

  Future<void> clearEncryptedSecureKey(
    FlutterSecureStorage secureStorage,
  ) =>
      secureStorage.delete(key: kEncryptedSecureKey);

  Future<Uint8List?> readEncryptedSecureKey(
    FlutterSecureStorage secureStorage,
    String password,
  ) async {
    final encryptedKeyBase64 = await secureStorage.read(
      key: kEncryptedSecureKey,
    );
    final saltBase64 = await secureStorage.read(
      key: kEncryptedSecureKeySalt,
    );

    if (encryptedKeyBase64 == null || saltBase64 == null) {
      return null;
    }

    final encryptedKey = base64Url.decode(encryptedKeyBase64);
    final salt = archethic.uint8ListToHex(base64Url.decode(saltBase64));

    final decryptedKey = decryptSecureKey(salt, password, encryptedKey);

    return decryptedKey;
  }

  Uint8List encryptSecureKey(
    String salt,
    String password,
    Uint8List clearSecuredKey,
  ) {
    final derivedKey = _generatePBKDFKey(password, salt);

    return archethic.aesEncrypt(
      archethic.uint8ListToHex(Uint8List.fromList(clearSecuredKey)),
      derivedKey,
    );
  }

  Uint8List? decryptSecureKey(
    String salt,
    String password,
    Uint8List encryptedSecuredKey,
  ) {
    final derivedKey = _generatePBKDFKey(password, salt);

    return archethic.aesDecrypt(encryptedSecuredKey, derivedKey);
  }

  // TODO(): Check if that's not too long to compute. I guess a simple SHA256(password+salt) would do the job
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
