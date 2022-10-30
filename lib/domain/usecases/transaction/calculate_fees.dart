import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transaction.dart';
import 'package:aewallet/domain/repositories/transaction.dart';
import 'package:aewallet/domain/usecases/usecase.dart';

class CalculateFeesUsecase
    implements UseCase<Transaction, Result<double, Failure>> {
  const CalculateFeesUsecase({
    required this.repository,
  });

  final TransactionRepositoryInterface repository;

  @override
  Future<Result<double, Failure>> run(Transaction transaction) async {
    transaction.map(
      transfer: (transaction) {
        if (transaction.transfer.amount <= 0) {
          return const Result.success(0);
        }

        if (transaction.transfer.recipientAddress.isValid) {
          return const Result.failure(Failure.invalidValue());
        }
      },
      token: (transaction) {
        if (transaction.token.initialSupply <= 0) {
          return const Result.success(0);
        }
      },
    );

    return repository.calculateFees(transaction);
  }
}
