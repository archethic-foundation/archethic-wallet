// @dart=2.9

import 'dart:typed_data';

import 'package:uniris_mobile_wallet/util/app_ffi/crypto/sha.dart';
import 'package:uniris_mobile_wallet/util/helpers.dart';
import 'package:uniris_mobile_wallet/util/app_ffi/encrypt/kdf/kdf.dart';
import 'package:uniris_mobile_wallet/util/app_ffi/encrypt/model/keyiv.dart';

/// Sha256 Key Derivation Function
/// It's not very anti-brute forceable, but it's fast which is an important feature
/// Anti-brute forceable is a lower priority than speed, because key security is on the individual user
/// there's no centralized database of key
class Sha256KDF extends KDF {
  /// Gets the key and iv
  @override
  KeyIV deriveKey(String password, {Uint8List salt}) {
    final Uint8List pwBytes = AppHelpers.stringToBytesUtf8(password);
    final Uint8List saltBytes = salt ?? Uint8List(1);

    // Key = sha256 (password + salt);
    final Uint8List key = Sha.sha256([pwBytes, saltBytes]);
    // iv = sha256 (KEY + password + salt);
    final Uint8List iv = Sha.sha256([key, pwBytes, saltBytes]).sublist(0, 16);

    return KeyIV(key, iv);
  }
}
