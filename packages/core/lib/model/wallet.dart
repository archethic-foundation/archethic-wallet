/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:core/model/available_currency.dart';
import 'package:core/model/balance_wallet.dart';
import 'package:core/model/recent_transaction.dart';

/// Main wallet object that's passed around the app via state
class AppWallet {
  AppWallet(
      {String? address,
      BalanceWallet? accountBalance,
      List<RecentTransaction>? history}) {
    _address = address;
    _accountBalance = accountBalance ??
        BalanceWallet(0, AvailableCurrency(AvailableCurrencyEnum.USD));
    _history = history ?? List<RecentTransaction>.empty(growable: true);
  }

  String? _address;
  BalanceWallet? _accountBalance;
  List<RecentTransaction>? _history;

  String get address => _address!;

  set address(String address) {
    _address = address;
  }

  BalanceWallet get accountBalance => _accountBalance!;

  set accountBalance(BalanceWallet accountBalance) {
    _accountBalance = accountBalance;
  }

  List<RecentTransaction> get history => _history!;

  List<RecentTransaction> get recentHistory {
    if (_history != null && _history!.length >= 3) {
      return _history!.sublist(0, 3);
    } else {
      return _history!;
    }
  }

  set history(List<RecentTransaction> value) {
    _history = value;
  }
}
