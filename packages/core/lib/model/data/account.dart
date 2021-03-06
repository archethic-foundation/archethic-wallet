/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:hive/hive.dart';

// Project imports:
import 'package:core/model/data/account_balance.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/model/data/price.dart';
import 'package:core/model/data/recent_transaction.dart';
import 'package:core/service/app_service.dart';
import 'package:core/util/get_it_instance.dart';

part 'account.g.dart';

@HiveType(typeId: 1)
class Account extends HiveObject {
  Account(
      {this.name,
      this.genesisAddress,
      this.lastLoadingTransactionInputs,
      this.selected = false,
      this.lastAddress,
      this.balance,
      this.recentTransactions});

  /// Account name - Primary Key
  @HiveField(0)
  String? name;

  /// Genesis Address
  @HiveField(1)
  String? genesisAddress;

  /// Last loading of transaction inputs
  @HiveField(2)
  int? lastLoadingTransactionInputs;

  /// Whether this is the currently selected account
  @HiveField(3)
  bool? selected;

  /// Last address
  @HiveField(4)
  String? lastAddress;

  /// Balance
  @HiveField(5)
  AccountBalance? balance;

  /// Recent transactions
  @HiveField(6)
  List<RecentTransaction>? recentTransactions;

  Future<void> updateLastAddress() async {
    String lastAddressFromAddress =
        await sl.get<AddressService>().lastAddressFromAddress(genesisAddress!);
    lastAddress =
        lastAddressFromAddress == '' ? genesisAddress! : lastAddressFromAddress;
    await updateAccount();
  }

  Future<void> updateBalance(
      String tokenName, String fiatCurrencyCode, Price price) async {
    final Balance balanceGetResponse =
        await sl.get<AppService>().getBalanceGetResponse(lastAddress!);
    double fiatCurrencyValue = 0;
    if (balanceGetResponse.uco != null && price.amount != null) {
      fiatCurrencyValue = balanceGetResponse.uco! * price.amount!;
    }
    final AccountBalance accountBalance = AccountBalance(
        nativeTokenName: tokenName,
        nativeTokenValue: balanceGetResponse.uco,
        fiatCurrencyCode: fiatCurrencyCode,
        fiatCurrencyValue: fiatCurrencyValue,
        tokenPrice: price);
    balance = accountBalance;
    await updateAccount();
  }

  Future<void> updateLastLoadingTransactionInputs() async {
    lastLoadingTransactionInputs =
        DateTime.now().millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;
    await updateAccount();
  }

  Future<void> updateRecentTransactions(
      String pagingAddress, String seed) async {
    recentTransactions = await sl
        .get<AppService>()
        .getRecentTransactions(genesisAddress!, lastAddress!, seed, name!);
    await updateLastLoadingTransactionInputs();
    await updateAccount();
  }

  Future<void> updateAccount() async {
    await sl.get<DBHelper>().updateAccount(this);
  }
}
