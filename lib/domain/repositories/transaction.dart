import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transaction.dart';
import 'package:aewallet/domain/models/transaction_event.dart';

typedef TransactionConfirmationHandler = Future<void> Function(
  TransactionConfirmation confirmation,
);
typedef TransactionErrorHandler = Future<void> Function(TransactionError error);

abstract class TransactionRepositoryInterface {
  const TransactionRepositoryInterface();

  Future<Result<double, Failure>> calculateFees(Transaction transaction);

  Future<void> send({
    required Transaction transaction,
    Duration timeout = const Duration(seconds: 10),
    required TransactionConfirmationHandler onConfirmation,
    required TransactionErrorHandler onError,
  });
}
