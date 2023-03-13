import 'package:freezed_annotation/freezed_annotation.dart';

part 'keychain_derive_keypair.freezed.dart';

@freezed
class RPCKeychainDeriveKeypairCommandData
    with _$RPCKeychainDeriveKeypairCommandData {
  const factory RPCKeychainDeriveKeypairCommandData({
    /// Service name to identify the derivation path to use
    required String serviceName,

    /// Chain index to derive (optional - default to 0)
    int? index,

    /// Additional information to add to a service derivation path (optional - default to empty)
    String? pathSuffix,
  }) = _RPCKeychainDeriveKeypairCommandData;
  const RPCKeychainDeriveKeypairCommandData._();
}

@freezed
class RPCKeychainDeriveKeypairResultData
    with _$RPCKeychainDeriveKeypairResultData {
  const factory RPCKeychainDeriveKeypairResultData({
    required String publicKey,
  }) = _RPCKeychainDeriveKeypairResultData;

  const RPCKeychainDeriveKeypairResultData._();
}
