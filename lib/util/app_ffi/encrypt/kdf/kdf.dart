// @dart=2.9

// Dart imports:
import 'dart:typed_data';

// Project imports:
import 'package:archethic_mobile_wallet/util/app_ffi/encrypt/model/keyiv.dart';

/// KDF (Key derivator function) base class
abstract class KDF {
  /// Derive a KeyIV with given password and optional salt
  KeyIV deriveKey(String password, {Uint8List salt});
}
