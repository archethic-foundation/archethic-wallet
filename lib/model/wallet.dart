// @dart=2.9

import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';
import 'package:uniris_mobile_wallet/model/available_currency.dart';
import 'package:uniris_mobile_wallet/model/balance.dart';
import 'package:uniris_mobile_wallet/network/model/response/address_txs_response.dart';
import 'package:uniris_mobile_wallet/util/numberutil.dart';

/// Main wallet object that's passed around the app via state
class AppWallet {


  AppWallet(
      {String address,
      Balance accountBalance,
      String localCurrencyPrice,
      String btcPrice,
      List<AddressTxsResponseResult> history,
      bool loading,
      bool historyLoading}) {
    _address = address;
    _accountBalance = accountBalance ??
        Balance(uco: 0, nftList: null);
    _localCurrencyPrice = localCurrencyPrice ?? '0';
    _btcPrice = btcPrice ?? '0';
    _history =
        history ?? List<AddressTxsResponseResult>.empty(growable: true);
    _loading = loading ?? true;
    _historyLoading = historyLoading ?? true;
  }


  bool _loading; // Whether or not app is initially loading
  bool
      _historyLoading; // Whether or not we have received initial account history response
  String _address;
  Balance _accountBalance;
  String _localCurrencyPrice;
  String _btcPrice;
  List<AddressTxsResponseResult> _history;

  String get address => _address;

  set address(String address) {
    _address = address;
  }

  Balance get accountBalance => _accountBalance;

  set accountBalance(Balance accountBalance) {
    _accountBalance = accountBalance;
  }

  // Get pretty account balance version
  String getAccountBalanceUCODisplay() {
    if (accountBalance == null || accountBalance.uco == null) {
      return '0';
    }
    return NumberUtil.getRawAsUsableString(_accountBalance.uco.toString());
  }

  // Get pretty account balance version
  String getAccountBalanceMoinsFeesDisplay(estimationFees) {
    if (accountBalance == null) {
      return '0';
    }
    final double value = _accountBalance.uco - estimationFees;
    return NumberUtil.getRawAsUsableString(value.toString());
  }

  String getLocalCurrencyPrice(AvailableCurrency currency,
      {String locale = 'en_US'}) {
    final Decimal converted = Decimal.parse(_localCurrencyPrice) *
        NumberUtil.getRawAsUsableDecimal(_accountBalance.uco.toString());
    return NumberFormat.currency(
            locale: locale, symbol: currency.getCurrencySymbol())
        .format(converted.toDouble());
  }

  String getLocalCurrencyPriceMoinsFees(
      AvailableCurrency currency, double estimationFees,
      {String locale = 'en_US'}) {
    final double value = _accountBalance.uco - estimationFees;
    final Decimal converted = Decimal.parse(_localCurrencyPrice) *
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
    return _localCurrencyPrice;
  }

  String get btcPrice {
    final Decimal converted = Decimal.parse(_btcPrice) *
        NumberUtil.getRawAsUsableDecimal(_accountBalance.uco.toString());
    // Show 4 decimal places for BTC price if its >= 0.0001 BTC, otherwise 6 decimals
    if (converted >= Decimal.parse('0.0001')) {
      return NumberFormat('#,##0.0000', 'en_US')
          .format(converted.toDouble());
    } else {
      return NumberFormat('#,##0.000000000', 'en_US')
          .format(converted.toDouble());
    }
  }

  set btcPrice(String value) {
    _btcPrice = value;
  }

  List<AddressTxsResponseResult> get history => _history;

  set history(List<AddressTxsResponseResult> value) {
    _history = value;
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
  }

  bool get historyLoading => _historyLoading;

  set historyLoading(bool value) {
    _historyLoading = value;
  }
}
