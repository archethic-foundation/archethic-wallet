/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:aewallet/util/encrypt/encrypt.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:crypto/crypto.dart';
import 'package:tuple/tuple.dart';

Uint8List _genRandomWithNonZero(int seedLength) {
  final random = Random.secure();
  const randomMax = 245;
  final uint8list = Uint8List(seedLength);
  for (var i = 0; i < seedLength; i++) {
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
  var concatenatedHashes = Uint8List(0);
  var currentHash = Uint8List(0);
  var enoughBytesForKey = false;
  var preHash = Uint8List(0);

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
  final encryptedBytesWithSalt = Uint8List.fromList(
    _createUint8ListFromString('Salted__') + salt + encrypted.bytes,
  );
  return base64.encode(encryptedBytesWithSalt);
}

String stringDecryptBase64(String string, String? seed) {
  final encryptedBytesWithSalt = base64.decode(string);
  final encryptedBytes =
      encryptedBytesWithSalt.sublist(16, encryptedBytesWithSalt.length);
  final salt = encryptedBytesWithSalt.sublist(8, 16);
  final keyndIV = _deriveKeyAndIV(seed!, salt);
  final key = Key(keyndIV.item1);
  final iv = IV(keyndIV.item2);
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
  return encrypter.decrypt64(base64.encode(encryptedBytes), iv: iv);
}

Uint8List stringEncryptBytes(String string, String? seed) {
  final salt = _genRandomWithNonZero(8);
  final keyndIV = _deriveKeyAndIV(seed!, salt);
  final key = Key(keyndIV.item1);
  final iv = IV(keyndIV.item2);
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
  final encrypted = encrypter.encryptBytes(utf8.encode(string), iv: iv);
  final encryptedBytesWithSalt = Uint8List.fromList(
    _createUint8ListFromString('Salted__') + salt + encrypted.bytes,
  );
  return encryptedBytesWithSalt;
}

Uint8List stringDecryptBytes(String string, String? seed) {
  final encryptedBytesWithSalt = base64.decode(string);
  final encryptedBytes =
      encryptedBytesWithSalt.sublist(16, encryptedBytesWithSalt.length);
  final salt = encryptedBytesWithSalt.sublist(8, 16);
  final keyndIV = _deriveKeyAndIV(seed!, salt);
  final key = Key(keyndIV.item1);
  final iv = IV(keyndIV.item2);
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
  return Uint8List.fromList(
    encrypter.decryptBytes(
      Encrypted.fromBase16(uint8ListToHex(encryptedBytes)),
      iv: iv,
    ),
  );
}
