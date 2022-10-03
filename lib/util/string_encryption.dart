/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

// Package imports:
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:tuple/tuple.dart';

Uint8List _genRandomWithNonZero(int seedLength) {
  final random = Random.secure();
  const int randomMax = 245;
  final Uint8List uint8list = Uint8List(seedLength);
  for (int i = 0; i < seedLength; i++) {
    uint8list[i] = random.nextInt(randomMax) + 1;
  }
  return uint8list;
}

Uint8List _createUint8ListFromString(String s) {
  final ret = Uint8List(s.length);
  for (var i = 0; i < s.length; i++) {
    ret[i] = s.codeUnitAt(i);
  }
  return ret;
}

Tuple2<Uint8List, Uint8List> _deriveKeyAndIV(
  String passphrase,
  Uint8List salt,
) {
  final password = _createUint8ListFromString(passphrase);
  Uint8List concatenatedHashes = Uint8List(0);
  Uint8List currentHash = Uint8List(0);
  bool enoughBytesForKey = false;
  Uint8List preHash = Uint8List(0);

  while (!enoughBytesForKey) {
    if (currentHash.isNotEmpty) {
      preHash = Uint8List.fromList(currentHash + password + salt);
    } else {
      preHash = Uint8List.fromList(password + salt);
    }

    currentHash = Uint8List.fromList(md5.convert(preHash).bytes);
    concatenatedHashes = Uint8List.fromList(concatenatedHashes + currentHash);
    if (concatenatedHashes.length >= 48) enoughBytesForKey = true;
  }

  final keyBtyes = concatenatedHashes.sublist(0, 32);
  final ivBtyes = concatenatedHashes.sublist(32, 48);
  return Tuple2(keyBtyes, ivBtyes);
}

String stringEncryptBase64(String string, String? seed) {
  final salt = _genRandomWithNonZero(8);
  final keyndIV = _deriveKeyAndIV(seed!, salt);
  final key = Key(keyndIV.item1);
  final iv = IV(keyndIV.item2);
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
  final encrypted = encrypter.encrypt(string, iv: iv);
  final Uint8List encryptedBytesWithSalt = Uint8List.fromList(
    _createUint8ListFromString('Salted__') + salt + encrypted.bytes,
  );
  return base64.encode(encryptedBytesWithSalt);
}

String stringDecryptBase64(String string, String? seed) {
  final Uint8List encryptedBytesWithSalt = base64.decode(string);
  final Uint8List encryptedBytes =
      encryptedBytesWithSalt.sublist(16, encryptedBytesWithSalt.length);
  final salt = encryptedBytesWithSalt.sublist(8, 16);
  final keyndIV = _deriveKeyAndIV(seed!, salt);
  final key = Key(keyndIV.item1);
  final iv = IV(keyndIV.item2);
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
  return encrypter.decrypt64(base64.encode(encryptedBytes), iv: iv);
}
