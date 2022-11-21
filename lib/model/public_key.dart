/// SPDX-License-Identifier: AGPL-3.0-or-later

// Object to represent an public key,
// and provide useful utilities
class PublicKey {
  const PublicKey(this._publicKey);

  final String _publicKey;

  String get publicKey => _publicKey;

  // TODO(reddwarf03): Add control (1)
  bool get isValid {
    return true;
  }
}
