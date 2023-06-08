import 'dart:typed_data';

import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// Holds a key pair (private and public key) for each service
part 'keychain_service_keypair.freezed.dart';
part 'keychain_service_keypair.g.dart';

@freezed
class KeychainServiceKeyPair with _$KeychainServiceKeyPair {
  const factory KeychainServiceKeyPair({
    required List<int> privateKey,
    required List<int> publicKey,
  }) = _KeychainServiceKeyPair;
  const KeychainServiceKeyPair._();

  factory KeychainServiceKeyPair.fromJson(Map<String, dynamic> json) =>
      _$KeychainServiceKeyPairFromJson(json);

  KeyPair get toKeyPair => KeyPair(
        privateKey: Uint8List.fromList(
          privateKey,
        ),
        publicKey: Uint8List.fromList(
          publicKey,
        ),
      );
}
