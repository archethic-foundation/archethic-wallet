import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/hive_app_wallet_dto.dart';
import 'package:hive/hive.dart';

class AccountHiveDatasource {
  AccountHiveDatasource._();

  factory AccountHiveDatasource.instance() {
    return _instance ?? (_instance = AccountHiveDatasource._());
  }

  static AccountHiveDatasource? _instance;

  static const String appWalletTable = 'appWallet';

  Future<List<Account>> getAccounts() async {
    final box = await Hive.openBox<HiveAppWalletDTO>(appWalletTable);
    final appWallet = box.get(0)!;
    return appWallet.appKeychain.accounts;
  }

  Future<Account?> getAccount(String name) async {
    final box = await Hive.openBox<HiveAppWalletDTO>(appWalletTable);
    final appWallet = box.get(0)!;
    for (final account in appWallet.appKeychain.accounts) {
      if (account.name == name) return account;
    }
    return null;
  }

  Future<HiveAppWalletDTO> addAccount(Account account) async {
    final box = await Hive.openBox<HiveAppWalletDTO>(appWalletTable);
    final appWallet = box.get(0)!;
    appWallet.appKeychain.accounts.add(account);
    await box.putAt(0, appWallet);
    return appWallet;
  }

  Future<HiveAppWalletDTO> clearAccount() async {
    final box = await Hive.openBox<HiveAppWalletDTO>(appWalletTable);
    final appWallet = box.get(0)!;
    appWallet.appKeychain.accounts.clear();
    await box.putAt(0, appWallet);
    return appWallet;
  }

  Future<HiveAppWalletDTO> changeAccount(String accountName) async {
    final box = await Hive.openBox<HiveAppWalletDTO>(appWalletTable);
    final appWallet = box.get(0)!;
    for (var i = 0; i < appWallet.appKeychain.accounts.length; i++) {
      if (appWallet.appKeychain.accounts[i].name == accountName) {
        appWallet.appKeychain.accounts[i].selected = true;
      } else {
        appWallet.appKeychain.accounts[i].selected = false;
      }
    }
    await box.putAt(0, appWallet);
    return appWallet;
  }

  Future<void> updateAccountBalance(
    Account selectedAccount,
    AccountBalance balance,
  ) async {
    final box = await Hive.openBox<HiveAppWalletDTO>(appWalletTable);
    final appWallet = box.get(0)!;
    final accounts = appWallet.appKeychain.accounts;
    for (final account in accounts) {
      if (selectedAccount.name == account.name) {
        account.balance = balance;
        await box.putAt(0, appWallet);
        return;
      }
    }
  }

  Future<void> updateAccount(Account selectedAccount) async {
    final box = await Hive.openBox<HiveAppWalletDTO>(appWalletTable);
    final appWallet = box.get(0)!;
    appWallet.appKeychain.accounts = appWallet.appKeychain.accounts.map(
      (account) {
        if (account.name == selectedAccount.name) return selectedAccount;
        return account;
      },
    ).toList();
    await box.putAt(0, appWallet);
  }
}
