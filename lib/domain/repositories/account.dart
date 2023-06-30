import 'package:aewallet/model/data/account.dart';

abstract class AccountLocalRepositoryInterface {
  Future<List<Account>> accounts();

  Future<Account?> getAccount(String name);

  Future<void> saveAccount(Account account);

  Future<Account?> getSelectedAccount();

  Future<void> selectAccount(String name);
}
