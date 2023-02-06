import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rpc_sign_transaction_result.freezed.dart';
part 'rpc_sign_transaction_result.g.dart';

@freezed
class RpcSignTransactionResult with _$RpcSignTransactionResult {
  const factory RpcSignTransactionResult({
    required String transactionAddress,
    required int nbConfirmations,
    required int maxConfirmations,
  }) = _RpcSignTransactionResult;
  const RpcSignTransactionResult._();

  factory RpcSignTransactionResult.fromJson(Map<String, dynamic> json) =>
      _$RpcSignTransactionResultFromJson(json);

  factory RpcSignTransactionResult.fromModel(TransactionConfirmation result) =>
      RpcSignTransactionResult(
        maxConfirmations: result.maxConfirmations,
        nbConfirmations: result.nbConfirmations,
        transactionAddress: result.transactionAddress,
      );
}
