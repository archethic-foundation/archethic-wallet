/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:hive/hive.dart';

part 'app_keychain.g.dart';

@HiveType(typeId: HiveTypeIds.appKeychain)

/// Next field available : 3
class AppKeychain extends HiveObject {
  AppKeychain({
    required this.address,
    required this.accounts,
  });

  /// Address
  @HiveField(0)
  String address;

  /// Accounts
  @HiveField(2, defaultValue: [])
  List<Account> accounts;

  Account? getAccountSelected() {
    for (final account in accounts) {
      if (account.selected!) {
        return account;
      }
    }
    return null;
  }

  Account? getAccount(Account accountToSelected) {
    for (final account in accounts) {
      if (accountToSelected.name == account.name) {
        return account;
      }
    }
    return null;
  }

  Account? getAccountWithName(String name) {
    for (final account in accounts) {
      if (name == account.name) {
        return account;
      }
    }
    return null;
  }
}
