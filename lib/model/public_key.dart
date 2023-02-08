import 'package:archethic_lib_dart/archethic_lib_dart.dart';

/// SPDX-License-Identifier: AGPL-3.0-or-later

// Object to represent an public key,
// and provide useful utilities

const kPublicKeyLength = 68;

class PublicKey {
  const PublicKey(this._publicKey);

  final String _publicKey;

  String get publicKey => _publicKey;

  bool get isValid {
    if (!isHex(_publicKey)) {
      return false;
    }
    if (_publicKey.length != kPublicKeyLength) {
      return false;
    }
    return true;
  }
}
