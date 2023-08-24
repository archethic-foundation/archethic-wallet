import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/model/blockchain/recent_transaction.dart';

abstract class TransactionLocalRepositoryInterface {
  Future<List<RecentTransaction>> getRecentTransactions(String accountName);

  Future<String?> getLastTransactionAddress(String accountName);

  Future<Failure?> saveRecentTransactions({
    required String accountName,
    required String lastAddress,
    required List<RecentTransaction> recentTransactions,
  });
}
