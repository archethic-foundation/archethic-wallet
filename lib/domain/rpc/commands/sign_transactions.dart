import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_transactions.freezed.dart';

@freezed
class RPCSignTransactionsCommandData with _$RPCSignTransactionsCommandData {
  const factory RPCSignTransactionsCommandData({
    /// Service name to identify the derivation path to use
    required String serviceName,

    /// Additional information to add to a service derivation path (optional - default to empty)
    String? pathSuffix,

    /// Last index of the transaction in the chain
    int? index,

    /// - List of transaction's infos
    required List<RPCSignTransactionCommandData> rpcSignTransactionCommandData,
  }) = _RPCSignTransactionsCommandData;
  const RPCSignTransactionsCommandData._();
}

@freezed
class RPCSignTransactionsResultData with _$RPCSignTransactionsResultData {
  const factory RPCSignTransactionsResultData({
    required List<RPCSignTransactionResultDetailData> signedTxs,
  }) = _RPCSignTransactionsResultData;

  const RPCSignTransactionsResultData._();
}

@freezed
class RPCSignTransactionCommandData with _$RPCSignTransactionCommandData {
  const factory RPCSignTransactionCommandData({
    /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
    required Data data,

    /// - Type: transaction type
    required String type,

    /// - Version: version of the transaction (used for backward compatiblity)
    required int version,
  }) = _RPCSignTransactionCommandData;
  const RPCSignTransactionCommandData._();
}

@freezed
class RPCSignTransactionResultDetailData
    with _$RPCSignTransactionResultDetailData {
  const factory RPCSignTransactionResultDetailData({
    /// Address: hash of the new generated public key for the given transaction
    required String address,

    /// Previous generated public key matching the previous signature
    required String previousPublicKey,

    /// Signature from the previous public key
    required String previousSignature,

    /// Signature from the device which originated the transaction (used in the Proof of work)
    required String originSignature,
  }) = _RPCSignTransactionResultDetailData;
  const RPCSignTransactionResultDetailData._();
}
