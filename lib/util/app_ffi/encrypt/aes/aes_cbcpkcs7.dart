// Dart imports:
import 'dart:typed_data';

// Package imports:
import 'package:pointycastle/api.dart';

// ignore: avoid_classes_with_only_static_members
/// AES Encrypt/Decrypt using CBC block cipher and PKCS7 padding
class AesCbcPkcs7 {
  /// AES/CBC/PKCS7 Encrypt
  static Uint8List encrypt(Uint8List value, {Uint8List? key, Uint8List? iv}) {
    key ??= Uint8List(1);
    iv ??= Uint8List(1);
    final CipherParameters params = PaddedBlockCipherParameters(
        ParametersWithIV<KeyParameter>(KeyParameter(key), iv), null);
    final BlockCipher encryptionCipher = PaddedBlockCipher('AES/CBC/PKCS7');
    encryptionCipher.init(true, params);
    return encryptionCipher.process(value);
  }

  /// AES/CBC/PKCS7 Decrypt
  static Uint8List decrypt(Uint8List encrypted,
      {Uint8List? key, Uint8List? iv}) {
    key ??= Uint8List(1);
    iv ??= Uint8List(1);
    final CipherParameters params = PaddedBlockCipherParameters(
        ParametersWithIV(KeyParameter(key), iv), null);
    final BlockCipher decryptionCipher = PaddedBlockCipher('AES/CBC/PKCS7');
    decryptionCipher.init(false, params);
    return decryptionCipher.process(encrypted);
  }
}
