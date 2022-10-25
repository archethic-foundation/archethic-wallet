import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/domain/models/transfer.dart';

typedef TransactionConfirmationHandler = Future<void> Function(
  TransactionConfirmation confirmation,
);
typedef TransactionErrorHandler = Future<void> Function(TransactionError error);

abstract class TransferRepositoryInterface {
  const TransferRepositoryInterface();

  Future<Result<double, Failure>> calculateFees(Transfer transfer);

  Future<void> send({
    required Transfer transfer,
    Duration timeout = const Duration(seconds: 10),
    required TransactionConfirmationHandler onConfirmation,
    required TransactionErrorHandler onError,
  });
}
