import 'package:freezed_annotation/freezed_annotation.dart';

part 'keychain_derive_address.freezed.dart';

@freezed
class RPCKeychainDeriveAddressCommandData
    with _$RPCKeychainDeriveAddressCommandData {
  const factory RPCKeychainDeriveAddressCommandData({
    /// Service name to identify the derivation path to use
    required String serviceName,

    /// Chain index to derive (optional - default to 0)
    int? index,

    /// Additional information to add to a service derivation path (optional - default to empty)
    String? pathSuffix,
  }) = _RPCKeychainDeriveAddressCommandData;
  const RPCKeychainDeriveAddressCommandData._();
}

@freezed
class RPCKeychainDeriveAddressResultData
    with _$RPCKeychainDeriveAddressResultData {
  const factory RPCKeychainDeriveAddressResultData({
    required String address,
  }) = _RPCKeychainDeriveAddressResultData;

  const RPCKeychainDeriveAddressResultData._();
}
