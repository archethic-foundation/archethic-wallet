/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show Balance;
import 'package:core/model/available_currency.dart';
import 'package:core/model/recent_transaction.dart';
import 'package:core/util/number_util.dart';
import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

/// Main wallet object that's passed around the app via state
class AppWallet {
  AppWallet(
      {String? address,
      Balance? accountBalance,
      String? localCurrencyPrice,
      List<RecentTransaction>? history}) {
    _address = address;
    _accountBalance = accountBalance ?? Balance(uco: 0, nft: null);
    _localCurrencyPrice = localCurrencyPrice ?? '0';
    _history = history ?? List<RecentTransaction>.empty(growable: true);
  }

  String? _address;
  Balance? _accountBalance;
  String? _localCurrencyPrice;
  List<RecentTransaction>? _history;

  String get address => _address!;

  set address(String address) {
    _address = address;
  }

  Balance get accountBalance => _accountBalance!;

  set accountBalance(Balance accountBalance) {
    _accountBalance = accountBalance;
  }

  // Get pretty account balance version
  String getAccountBalanceDisplay() {
    if (accountBalance.uco == null) {
      return '0';
    }
    return _accountBalance!.uco.toString();
  }

  // Get pretty account balance version
  String getAccountBalanceMoinsFeesDisplay(double estimationFees) {
    if (accountBalance.uco == null) {
      return '0';
    }
    final double value = _accountBalance!.uco! - estimationFees;
    return value.toString();
  }

  String getLocalCurrencyPrice(AvailableCurrency currency,
      {String locale = 'en_US'}) {
    if (currency.getIso4217Code() == 'BTC') {
      final Decimal converted = Decimal.parse(_localCurrencyPrice!) *
          NumberUtil.getRawAsUsableDecimal(
              _accountBalance == null || _accountBalance!.uco == null
                  ? '0'
                  : _accountBalance!.uco.toString());
      return converted.toStringAsFixed(8) + ' ' + currency.getCurrencySymbol();
    } else if (currency.getIso4217Code() == 'EUR') {
      final Decimal converted = Decimal.parse(_localCurrencyPrice!) *
          NumberUtil.getRawAsUsableDecimal(
              _accountBalance == null || _accountBalance!.uco == null
                  ? '0'
                  : _accountBalance!.uco.toString());
      return converted.toStringAsFixed(2) + ' ' + currency.getCurrencySymbol();
    } else {
      final Decimal converted = Decimal.parse(_localCurrencyPrice!) *
          NumberUtil.getRawAsUsableDecimal(
              _accountBalance == null || _accountBalance!.uco == null
                  ? '0'
                  : _accountBalance!.uco.toString());
      return NumberFormat.currency(
              locale: locale, symbol: currency.getCurrencySymbol())
          .format(converted.toDouble());
    }
  }

  String getLocalPrice(AvailableCurrency currency, {String locale = 'en_US'}) {
    if (currency.getIso4217Code() == 'BTC') {
      return _localCurrencyPrice! + ' ' + currency.getCurrencySymbol();
    } else if (currency.getIso4217Code() == 'EUR') {
      final Decimal converted = Decimal.parse(_localCurrencyPrice!);
      return converted.toStringAsFixed(2) + ' ' + currency.getCurrencySymbol();
    } else {
      final Decimal converted = Decimal.parse(_localCurrencyPrice!);
      return NumberFormat.currency(
              locale: locale, symbol: currency.getCurrencySymbol())
          .format(converted.toDouble());
    }
  }

  String getLocalCurrencyPriceMoinsFees(
      AvailableCurrency currency, double estimationFees,
      {String locale = 'en_US'}) {
    final double value = _accountBalance!.uco! - estimationFees;
    final Decimal converted = Decimal.parse(_localCurrencyPrice!) *
        NumberUtil.getRawAsUsableDecimal(value.toString());
    return NumberFormat.currency(
            locale: locale,
            symbol: currency.getCurrencySymbol(),
            decimalDigits: 5)
        .format(converted.toDouble());
  }

  set localCurrencyPrice(String value) {
    _localCurrencyPrice = value;
  }

  String get localCurrencyConversion {
    return _localCurrencyPrice!;
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
