/// SPDX-License-Identifier: AGPL-3.0-or-later
///

// Package imports:
import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:core/model/available_currency.dart';

class BalanceWallet {
  BalanceWallet(this.networkCurrencyValue, this.selectedCurrency);

  double? networkCurrencyValue;
  AvailableCurrency? selectedCurrency;
  double? _localCurrencyPrice;
  double? _selectedCurrencyValue;

  set localCurrencyPrice(double? localCurrencyPrice) {
    _localCurrencyPrice = localCurrencyPrice;
    _selectedCurrencyValue = (Decimal.parse(_localCurrencyPrice!.toString()) *
            Decimal.parse(networkCurrencyValue!.toString()))
        .toDouble();
  }

  double get localCurrencyPrice => _localCurrencyPrice!;

  double get selectedCurrencyValue => _selectedCurrencyValue!;

  String getNetworkAccountBalanceDisplay(
      {String? networkCryptoCurrencyLabel = ''}) {
    if (networkCurrencyValue == null) {
      return '0';
    }
    if (networkCryptoCurrencyLabel!.isEmpty) {
      return networkCurrencyValue!.toString();
    } else {
      return networkCurrencyValue!.toString() +
          ' ' +
          networkCryptoCurrencyLabel;
    }
  }

  String getLocalCurrencyPriceDisplay() {
    if (_localCurrencyPrice == null) {
      return '';
    }
    return NumberFormat.currency(
            locale: selectedCurrency!.getLocale().toString(),
            symbol: selectedCurrency!.getCurrencySymbol())
        .format(_localCurrencyPrice);
  }

  String getConvertedAccountBalanceDisplay() {
    if (_selectedCurrencyValue == null) {
      return '0';
    }
    if (selectedCurrency!.getIso4217Code() == 'BTC') {
      return _selectedCurrencyValue!.toStringAsFixed(8) +
          ' ' +
          selectedCurrency!.getCurrencySymbol();
    } else if (selectedCurrency!.getIso4217Code() == 'EUR') {
      return _selectedCurrencyValue!.toStringAsFixed(NumberFormat.currency(
                  locale: selectedCurrency!.getLocale().toString(),
                  symbol: selectedCurrency!.getCurrencySymbol())
              .decimalDigits!) +
          ' ' +
          selectedCurrency!.getCurrencySymbol();
    } else {
      return NumberFormat.currency(
              locale: selectedCurrency!.getLocale().toString(),
              symbol: selectedCurrency!.getCurrencySymbol())
          .format(_selectedCurrencyValue);
    }
  }
}
