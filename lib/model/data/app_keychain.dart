/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:hive/hive.dart';

part 'app_keychain.g.dart';

@HiveType(typeId: 3)
class AppKeychain extends HiveObject {
  AppKeychain({required this.address, this.seed, this.accounts});

  /// Address
  @HiveField(0)
  String? address;

  /// Seed
  @HiveField(1)
  String? seed;

  /// Accounts
  @HiveField(2)
  List<Account>? accounts;

  Account? getAccountSelected() {
    if (accounts != null) {
      for (final account in accounts!) {
        if (account.selected!) {
          return account;
        }
      }
    }
    return null;
  }

  Future<void> setAccountSelected(Account accountToSelected) async {
    await sl.get<DBHelper>().changeAccount(accountToSelected);
  }

  Account? getAccount(Account accountToSelected) {
    if (accounts != null) {
      for (final account in accounts!) {
        if (accountToSelected.name == account.name) {
          return account;
        }
      }
    }
    return null;
  }

  Account? getAccountWithName(String name) {
    for (final account in accounts!) {
      if (name == account.name) {
        return account;
      }
    }
    return null;
  }
}
