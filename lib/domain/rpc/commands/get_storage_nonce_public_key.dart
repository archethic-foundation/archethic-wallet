import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_storage_nonce_public_key.freezed.dart';

@freezed
class RPCGetStorageNoncePublicKeyCommandData
    with _$RPCGetStorageNoncePublicKeyCommandData {
  const factory RPCGetStorageNoncePublicKeyCommandData() =
      _RPCGetStorageNoncePublicKeyCommandData;
  const RPCGetStorageNoncePublicKeyCommandData._();
}

@freezed
class RPCGetStorageNoncePublicKeyResultData
    with _$RPCGetStorageNoncePublicKeyResultData {
  const factory RPCGetStorageNoncePublicKeyResultData({
    required String storageNoncePublicKey,
  }) = _RPCGetStorageNoncePublicKeyResultData;

  const RPCGetStorageNoncePublicKeyResultData._();
}
