// @dart=2.9

import 'dart:typed_data';

import 'package:pointycastle/pointycastle.dart';

class Sha {
  /// Calculates the sha256 hash from the given buffers.
  ///
  /// @param {List<Uint8List>} byte arrays
  /// @returns {Uint8List}
  static Uint8List sha256(List<Uint8List> byteArrays) {
    final Digest digest = Digest('SHA-256');
    final Uint8List hashed = Uint8List(32);
    for (Uint8List byteArray in byteArrays) {
      digest.update(byteArray, 0, byteArray.lengthInBytes);
    }
    digest.doFinal(hashed, 0);
    return hashed;
  }

  /// Calculates the sha512 hash from the given buffers.
  ///
  /// @param {List<Uint8List>} byte arrays
  /// @returns {Uint8List}
  static Uint8List sha512(List<Uint8List> byteArrays) {
    final Digest digest = Digest('SHA-512');
    final Uint8List hashed = Uint8List(64);
    for (Uint8List byteArray in byteArrays) {
      digest.update(byteArray, 0, byteArray.lengthInBytes);
    }
    digest.doFinal(hashed, 0);

    return hashed;
  }
}
