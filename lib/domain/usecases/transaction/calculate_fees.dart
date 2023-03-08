/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transaction.dart';
import 'package:aewallet/domain/repositories/transaction_remote.dart';
import 'package:aewallet/domain/usecases/usecase.dart';

class CalculateFeesUsecase
    implements UseCase<Transaction, Result<double, Failure>> {
  const CalculateFeesUsecase({
    required this.repository,
  });

  final TransactionRemoteRepositoryInterface repository;

  @override
  Future<Result<double, Failure>> run(
    Transaction transaction, {
    UseCaseProgressListener? onProgress,
  }) async {
    transaction.map(
      transfer: (transaction) {
        if (transaction.transfer.amount <= 0) {
          return const Result.success(0);
        }

        if (transaction.transfer.recipientAddress.isValid()) {
          return const Result.failure(Failure.invalidValue());
        }
      },
      token: (transaction) {
        if (transaction.token.initialSupply <= 0) {
          return const Result.success(0);
        }
      },
      keychain: (transaction) {
        // No fees for keychain tx
        return const Result.success(0);
      },
    );

    return repository.calculateFees(transaction);
  }
}
