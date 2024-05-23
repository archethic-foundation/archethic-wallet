import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/repositories/transaction_local.dart';
import 'package:aewallet/infrastructure/datasources/account.hive.dart';
import 'package:aewallet/model/blockchain/recent_transaction.dart';

class HiveTransactionRepository implements TransactionLocalRepositoryInterface {
  final _accountDatasource = AccountHiveDatasource.instance();

  @override
  Future<List<RecentTransaction>> getRecentTransactions(
    String accountName,
  ) async {
    final localAccount = await _accountDatasource.getAccount(accountName);
    return localAccount?.recentTransactions ?? [];
  }

  @override
  Future<String?> getLastTransactionAddress(String accountName) async {
    final localAccount = await _accountDatasource.getAccount(accountName);
    return localAccount?.lastAddress;
  }

  @override
  Future<Failure?> saveRecentTransactions({
    required String accountName,
    required String lastAddress,
    required List<RecentTransaction> recentTransactions,
  }) async {
    final localAccount = await _accountDatasource.getAccount(accountName);

    if (localAccount == null) {
      return const Failure.invalidValue();
    }

    await _accountDatasource.updateAccount(
      localAccount.copyWith(
        lastAddress: lastAddress,
        recentTransactions: recentTransactions,
      ),
    );
    return null;
  }
}
