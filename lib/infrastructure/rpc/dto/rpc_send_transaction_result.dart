import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rpc_send_transaction_result.freezed.dart';
part 'rpc_send_transaction_result.g.dart';

@freezed
class RpcSendTransactionResult with _$RpcSendTransactionResult {
  const factory RpcSendTransactionResult({
    required String transactionAddress,
    required int nbConfirmations,
    required int maxConfirmations,
  }) = _RpcSendTransactionResult;
  const RpcSendTransactionResult._();

  factory RpcSendTransactionResult.fromJson(Map<String, dynamic> json) =>
      _$RpcSendTransactionResultFromJson(json);

  factory RpcSendTransactionResult.fromModel(TransactionConfirmation result) =>
      RpcSendTransactionResult(
        maxConfirmations: result.maxConfirmations,
        nbConfirmations: result.nbConfirmations,
        transactionAddress: result.transactionAddress,
      );
}
