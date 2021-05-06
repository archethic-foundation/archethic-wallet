// @dart=2.9

import 'dart:typed_data';

import 'package:pointycastle/pointycastle.dart';

class Sha {
  /// Calculates the sha256 hash from the given buffers.
  ///
  /// @param {List<Uint8List>} byte arrays
  /// @returns {Uint8List}
  static Uint8List sha256(List<Uint8List> byteArrays) {
    Digest digest = Digest("SHA-256");
    Uint8List hashed = Uint8List(32);
    byteArrays.forEach((byteArray) {
      digest.update(byteArray, 0, byteArray.lengthInBytes);
    });
    digest.doFinal(hashed, 0);
    return hashed;
  }

  /// Calculates the sha512 hash from the given buffers.
  ///
  /// @param {List<Uint8List>} byte arrays
  /// @returns {Uint8List}
  static Uint8List sha512(List<Uint8List> byteArrays) {
    Digest digest = Digest("SHA-512");
    Uint8List hashed = Uint8List(64);
    byteArrays.forEach((byteArray) {
      digest.update(byteArray, 0, byteArray.lengthInBytes);
    });
    digest.doFinal(hashed, 0);

    return hashed;
  }
}