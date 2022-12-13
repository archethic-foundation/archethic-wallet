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
}
