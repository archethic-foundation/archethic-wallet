import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transfer.dart';
import 'package:aewallet/domain/repositories/transfer.dart';
import 'package:aewallet/domain/usecases/usecase.dart';

class CalculateFeesUsecase implements UseCase<Transfer, double, Failure> {
  const CalculateFeesUsecase({
    required this.repository,
  });

  final TransferRepositoryInterface repository;

  @override
  Future<Result<double, Failure>> run(Transfer transfer) async {
    if (transfer.amount <= 0) {
      return const Result.success(0);
    }

    if (!transfer.recipientAddress.isValid) {
      return const Result.failure(Failure.invalidValue());
    }

    return repository.calculateFees(transfer);
  }
}
