import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

// @freezed
// class RPCSuccess<T> with _$RPCSuccess<T> {
//   const factory RPCSuccess({
//     T? data,
//   }) = _RPCSuccess<T>;

//   const RPCSuccess._();
// }

@freezed
class RPCFailure with _$RPCFailure implements Exception {
  const factory RPCFailure({
    required int code,
    String? message,
    Map<String, dynamic>? data,
  }) = _RPCFailure;

  const RPCFailure._();

  factory RPCFailure.unsupportedMethod() => const RPCFailure(
        code: -32601,
        message: 'Unsupported method.',
      );
  factory RPCFailure.timeout() => const RPCFailure(
        code: 5001,
        message: 'Operation timeout.',
      );
  factory RPCFailure.connectivity() => const RPCFailure(
        code: 4901,
        message: 'Connectivity issue.',
      );
  factory RPCFailure.consensusNotReached() => const RPCFailure(
        code: 5002,
        message: 'Validation consensus not reached',
      );
  factory RPCFailure.invalidParams() => const RPCFailure(
        code: -32602,
        message: 'Invalid parameters',
      );
  factory RPCFailure.invalidTransaction() => const RPCFailure(
        code: 5003,
        message: 'Invalid transaction',
      );
  factory RPCFailure.invalidConfirmation() => const RPCFailure(
        code: 5006,
        message: 'Invalid node confirmation.',
      );
  factory RPCFailure.insufficientFunds() => const RPCFailure(
        code: 5004,
        message: 'Insufficient funds.',
      );
  factory RPCFailure.userRejected() => const RPCFailure(
        code: 4001,
        message: 'User rejected operation',
      );
  factory RPCFailure.unknownAccount() => const RPCFailure(
        code: 5005,
        message: 'Unknown account.',
      );
  factory RPCFailure.other() => const RPCFailure(
        code: 5000,
        message: 'Technical error',
      );

  factory RPCFailure.fromTransactionError(TransactionError transactionError) {
    return transactionError.map(
      timeout: (_) => RPCFailure.timeout(),
      connectivity: (_) => RPCFailure.connectivity(),
      consensusNotReached: (_) => RPCFailure.consensusNotReached(),
      invalidTransaction: (_) => RPCFailure.invalidTransaction(),
      invalidConfirmation: (_) => RPCFailure.invalidConfirmation(),
      insufficientFunds: (_) => RPCFailure.insufficientFunds(),
      userRejected: (_) => RPCFailure.userRejected(),
      unknownAccount: (_) => RPCFailure.unknownAccount(),
      other: (_) => RPCFailure.other(),
    );
  }
}
