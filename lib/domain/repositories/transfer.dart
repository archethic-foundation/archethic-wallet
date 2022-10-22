import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transfer.dart';

abstract class TransferRepositoryInterface {
  Future<Result<double, Failure>> calculateFees(Transfer transfer);
}
