// @dart=2.9

// Dart imports:
import 'dart:typed_data';

// Package imports:
import 'package:pointycastle/api.dart' show ParametersWithIV, KeyParameter;
import 'package:pointycastle/stream/salsa20.dart';
import 'package:uniris_lib_dart/utils.dart';

// Project imports:
import 'package:uniris_mobile_wallet/util/helpers.dart';

/*
 * Encryption using Salsa20 from pointycastle
 */
class Salsa20Encryptor {
  Salsa20Encryptor(this.key, this.iv)
      : _params = ParametersWithIV<KeyParameter>(
            KeyParameter(Uint8List.fromList(key.codeUnits)),
            Uint8List.fromList(iv.codeUnits));

  final String key;
  final String iv;
  final ParametersWithIV<KeyParameter> _params;
  final Salsa20Engine _cipher = Salsa20Engine();

  String encrypt(String plainText) {
    _cipher
      ..reset()
      ..init(true, _params);

    final Uint8List input = Uint8List.fromList(plainText.codeUnits);
    final Uint8List output = _cipher.process(input);

    return uint8ListToHex(output);
  }

  String decrypt(String cipherText) {
    _cipher
      ..reset()
      ..init(false, _params);

    final Uint8List input = AppHelpers.hexToBytes(cipherText);
    final Uint8List output = _cipher.process(input);

    return String.fromCharCodes(output);
  }
}
