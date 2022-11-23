import 'package:archethic_lib_dart/archethic_lib_dart.dart';

/// SPDX-License-Identifier: AGPL-3.0-or-later

// Object to represent an public key,
// and provide useful utilities
class PublicKey {
  const PublicKey(this._publicKey);

  final String _publicKey;

  String get publicKey => _publicKey;

  bool get isValid {
    return addressFormatControl(_publicKey);
  }
}
