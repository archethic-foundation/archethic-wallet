// @dart=2.9

// Dart imports:
import 'dart:typed_data';

// Project imports:
import 'package:archethic_mobile_wallet/util/app_ffi/crypto/sha.dart';
import 'package:archethic_mobile_wallet/util/app_ffi/encrypt/kdf/kdf.dart';
import 'package:archethic_mobile_wallet/util/app_ffi/encrypt/model/keyiv.dart';
import 'package:archethic_mobile_wallet/util/helpers.dart';

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
    final Uint8List key = Sha.sha256(<Uint8List>[pwBytes, saltBytes]);
    // iv = sha256 (KEY + password + salt);
    final Uint8List iv = Sha.sha256(<Uint8List>[key, pwBytes, saltBytes]).sublist(0, 16);

    return KeyIV(key, iv);
  }
}
