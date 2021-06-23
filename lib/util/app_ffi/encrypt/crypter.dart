// @dart=2.9

// Dart imports:
import 'dart:math';
import 'dart:typed_data';

// Project imports:
import 'package:archethic_mobile_wallet/util/app_ffi/encrypt/aes/aes_cbcpkcs7.dart';
import 'package:archethic_mobile_wallet/util/app_ffi/encrypt/kdf/kdf.dart';
import 'package:archethic_mobile_wallet/util/app_ffi/encrypt/kdf/sha256_kdf.dart';
import 'package:archethic_mobile_wallet/util/app_ffi/encrypt/model/keyiv.dart';
import 'package:archethic_mobile_wallet/util/helpers.dart';

/// Utility for encrypting and decrypting
class AppCrypt {
  /// Decrypts a value with a password using AES/CBC/PKCS7
  /// KDF is Sha256KDF if not specified
  static Uint8List decrypt(dynamic value, String password, {KDF kdf}) {
    kdf = kdf ?? Sha256KDF();
    Uint8List valBytes;
    if (value is String) {
      valBytes = AppHelpers.hexToBytes(value);
    } else if (value is Uint8List) {
      valBytes = value;
    } else {
      throw Exception('Value should be a string or a byte array');
    }

    final Uint8List salt = valBytes.sublist(8, 16);
    final KeyIV key = kdf.deriveKey(password, salt: salt);

    // Decrypt
    final Uint8List encData = valBytes.sublist(16);

    return AesCbcPkcs7.decrypt(encData, key: key.key, iv: key.iv);
  }

  /// Encrypts a value using AES/CBC/PKCS7
  /// KDF is Sha256KDF if not specified
  static Uint8List encrypt(dynamic value, String password, {KDF kdf}) {
    kdf = kdf ?? Sha256KDF();
    Uint8List valBytes;
    if (value is String) {
      valBytes = AppHelpers.hexToBytes(value);
    } else if (value is Uint8List) {
      valBytes = value;
    } else {
      throw Exception('Seed should be a string or uint8list');
    }

    // Generate a random salt
    final Uint8List salt = Uint8List(8);
    final Random rng = Random.secure();
    for (int i = 0; i < 8; i++) {
      salt[i] = rng.nextInt(255);
    }

    final KeyIV keyInfo = kdf.deriveKey(password, salt: salt);

    final Uint8List seedEncrypted =
        AesCbcPkcs7.encrypt(valBytes, key: keyInfo.key, iv: keyInfo.iv);

    return AppHelpers.concat(
        [AppHelpers.stringToBytesUtf8('Salted__'), salt, seedEncrypted]);
  }
}
