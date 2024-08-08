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

  Future<Box<HiveAppWalletDTO>> get _box =>
      Hive.openBox<HiveAppWalletDTO>(appWalletTable);

  Future<HiveAppWalletDTO> _readAppWallet() async {
    final box = await _box;
    return box.get(0)!;
  }

  Future<HiveAppWalletDTO> _writeAppWallet(HiveAppWalletDTO appWallet) async {
    final box = await _box;
    await box.putAt(0, appWallet);
    return appWallet;
  }

  Future<List<Account>> getAccounts() async {
    final appWallet = await _readAppWallet();
    return appWallet.appKeychain.accounts;
  }

  Future<Account?> getAccount(String name) async {
    final appWallet = await _readAppWallet();
    for (final account in appWallet.appKeychain.accounts) {
      if (account.name == name) return account;
    }
    return null;
  }

  Future<HiveAppWalletDTO> addAccount(Account account) async {
    final appWallet = await _readAppWallet();
    appWallet.appKeychain.accounts.add(account);
    return _writeAppWallet(appWallet);
  }

  Future<HiveAppWalletDTO> clearAccount() async {
    final appWallet = await _readAppWallet();
    appWallet.appKeychain.accounts.clear();
    return _writeAppWallet(appWallet);
  }

  Future<HiveAppWalletDTO> changeAccount(String accountName) async {
    final appWallet = await _readAppWallet();
    for (var i = 0; i < appWallet.appKeychain.accounts.length; i++) {
      if (appWallet.appKeychain.accounts[i].name == accountName) {
        appWallet.appKeychain.accounts[i].selected = true;
      } else {
        appWallet.appKeychain.accounts[i].selected = false;
      }
    }
    return _writeAppWallet(appWallet);
  }

  Future<void> updateAccountBalance(
    Account selectedAccount,
    AccountBalance balance,
  ) async {
    final appWallet = await _readAppWallet();
    final accounts = appWallet.appKeychain.accounts;
    for (final account in accounts) {
      if (selectedAccount.name == account.name) {
        account.balance = balance;
        await _writeAppWallet(appWallet);
        return;
      }
    }
  }

  Future<void> updateAccount(Account selectedAccount) async {
    final appWallet = await _readAppWallet();
    appWallet.appKeychain.accounts = appWallet.appKeychain.accounts.map(
      (account) {
        if (account.name == selectedAccount.name) return selectedAccount;
        return account;
      },
    ).toList();
    await _writeAppWallet(appWallet);
  }
}
