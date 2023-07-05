import 'package:aewallet/domain/repositories/account.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/util/get_it_instance.dart';

class AccountLocalRepository implements AccountLocalRepositoryInterface {
  final DBHelper _dbHelper = sl.get<DBHelper>();

  @override
  Future<List<String>> accountNames() async {
    final accounts = await _dbHelper.getAccounts();
    return accounts
        .map(
          (account) => account.name,
        )
        .toList();
  }

  @override
  Future<void> saveAccount(Account account) async {
    await _dbHelper.updateAccount(account);
  }

  @override
  Future<Account?> getAccount(String name) async {
    return _dbHelper.getAccount(name);
  }

  @override
  Future<Account?> getSelectedAccount() async {
    final accounts = await _dbHelper.getAccounts();

    for (final account in accounts) {
      if (account.selected == true) return account;
    }
    return null;
  }

  @override
  Future<void> selectAccount(String name) async {
    await sl.get<DBHelper>().changeAccount(name);
  }
}
