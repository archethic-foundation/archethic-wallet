// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show Balance;
import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:archethic_mobile_wallet/model/available_currency.dart';
import 'package:archethic_mobile_wallet/model/recent_transaction.dart';
import 'package:archethic_mobile_wallet/util/numberutil.dart';

/// Main wallet object that's passed around the app via state
class AppWallet {
  AppWallet(
      {String? address,
      Balance? accountBalance,
      String? localCurrencyPrice,
      String? btcPrice,
      List<RecentTransaction>? history}) {
    _address = address;
    _accountBalance = accountBalance ?? Balance(uco: 0, nft: null);
    _localCurrencyPrice = localCurrencyPrice ?? '0';
    _btcPrice = btcPrice ?? '0';
    _history = history ?? List<RecentTransaction>.empty(growable: true);
  }

  String? _address;
  Balance? _accountBalance;
  String? _localCurrencyPrice;
  String? _btcPrice;
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
  String getAccountBalanceUCODisplay() {
    if (accountBalance.uco == null) {
      return '0';
    }
    return NumberUtil.getRawAsUsableString(_accountBalance!.uco.toString());
  }

  // Get pretty account balance version
  String getAccountBalanceMoinsFeesDisplay(double estimationFees) {
    if (accountBalance.uco == null) {
      return '0';
    }
    final double value = _accountBalance!.uco! - estimationFees;
    return NumberUtil.getRawAsUsableString(value.toString());
  }

  String getLocalCurrencyPrice(AvailableCurrency currency,
      {String locale = 'en_US'}) {
    final Decimal converted = Decimal.parse(_localCurrencyPrice!) *
        NumberUtil.getRawAsUsableDecimal(
            _accountBalance == null || _accountBalance!.uco == null
                ? '0'
                : _accountBalance!.uco.toString());
    return NumberFormat.currency(
            locale: locale, symbol: currency.getCurrencySymbol())
        .format(converted.toDouble());
  }

  String getLocalPrice(AvailableCurrency currency, {String locale = 'en_US'}) {
    final Decimal converted = Decimal.parse(_localCurrencyPrice!);
    return NumberFormat.currency(
            locale: locale, symbol: currency.getCurrencySymbol())
        .format(converted.toDouble());
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

  String get btcPrice {
    final Decimal converted = Decimal.parse(_btcPrice!) *
        NumberUtil.getRawAsUsableDecimal(_accountBalance!.uco == null
            ? '0'
            : _accountBalance!.uco.toString());
    // Show 4 decimal places for BTC price if its >= 0.0001 BTC, otherwise 6 decimals
    if (converted >= Decimal.parse('0.0001')) {
      return NumberFormat('#,##0.0000', 'en_US').format(converted.toDouble());
    } else {
      return NumberFormat('#,##0.000000000', 'en_US')
          .format(converted.toDouble());
    }
  }

  set btcPrice(String value) {
    _btcPrice = value;
  }

  List<RecentTransaction> get history => _history!;

  set history(List<RecentTransaction> value) {
    _history = value;
  }
}
