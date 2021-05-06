// @dart=2.9

import 'dart:typed_data';

import 'package:uniris_mobile_wallet/util/helpers.dart';
import 'package:uniris_mobile_wallet/util/app_ffi/encrypt/kdf/kdf.dart';
import 'package:uniris_mobile_wallet/util/app_ffi/encrypt/model/keyiv.dart';
import 'package:pointycastle/export.dart';

/// pbkdf2 Key derivation function with a random salt
class PBKDF2 extends KDF {
  /// Derive a KeyIV with given password and optional salt
  /// Expects password to be a utf-8 string
  /// If salt is not provided, a random 8-byte one will be generated
  KeyIV deriveKey(String password, {Uint8List salt}) {
    Uint8List pwBytes = AppHelpers.stringToBytesUtf8(password);
    Uint8List saltBytes = salt == null ? Uint8List(1) : salt;

    // Use pbkdf2 from pointycastle
    KeyDerivator kdf = KeyDerivator("SHA-1/HMAC/PBKDF2");
    Pbkdf2Parameters params = Pbkdf2Parameters(saltBytes, 100, 48);
    kdf.init(params);
    Uint8List pbkdfKey = kdf.process(pwBytes);

    return KeyIV(pbkdfKey.sublist(0, 32), pbkdfKey.sublist(32, 48));
  }
}
