import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/repositories/transaction_local.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/util/get_it_instance.dart';

class HiveTransactionRepository implements TransactionLocalRepositoryInterface {
  final DBHelper _dbHelper = sl.get<DBHelper>();

  @override
  Future<List<RecentTransaction>> getRecentTransactions(
    String accountName,
  ) async {
    final localAccount = await _dbHelper.getAccount(accountName);
    return localAccount?.recentTransactions ?? [];
  }

  @override
  Future<String?> getLastTransactionAddress(String accountName) async {
    final localAccount = await _dbHelper.getAccount(accountName);
    return localAccount?.lastAddress;
  }

  @override
  Future<Failure?> saveRecentTransactions({
    required String accountName,
    required String lastAddress,
    required List<RecentTransaction> recentTransactions,
  }) async {
    final localAccount = await _dbHelper.getAccount(accountName);

    if (localAccount == null) {
      return const Failure.invalidValue();
    }

    await _dbHelper.updateAccount(
      localAccount.copyWith(
        lastAddress: lastAddress,
        recentTransactions: recentTransactions,
      ),
    );
    return null;
  }
}
