/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyUtil {
  static String getDisplayNameNoSymbol(String currency) {
    switch (currency) {
      case 'usd':
      default:
        return 'US Dollar';
    }
  }

  static String getCurrencySymbol(String currency) {
    switch (currency) {
      case 'usd':
      default:
        return r'$';
    }
  }

  static Locale getLocale(String currency) {
    switch (currency) {
      case 'usd':
      default:
        return const Locale('en', 'US');
    }
  }

  static String format(String currency, double amount) {
    return NumberFormat.currency(
      locale: CurrencyUtil.getLocale(currency).toString(),
      symbol: CurrencyUtil.getCurrencySymbol(currency),
    ).format(amount);
  }

  static String formatWithNumberOfDigits(
    String currency,
    double amount,
    int numberOfDigits,
  ) {
    return NumberFormat.currency(
      locale: CurrencyUtil.getLocale(currency).toString(),
      symbol: CurrencyUtil.getCurrencySymbol(currency),
      decimalDigits: numberOfDigits,
    ).format(amount);
  }

  static String getAmountPlusSymbol(String currency, double amount) {
    return '$amount ${CurrencyUtil.getCurrencySymbol(currency)}';
  }

  static double convertAmount(double price, double amount) {
    return (Decimal.parse(amount.toString()) * Decimal.parse(price.toString()))
        .toDouble();
  }

  static String convertAmountFormated(
    String currency,
    double price,
    double amount,
  ) {
    final amountConverted = convertAmount(price, amount);
    return format(currency, amountConverted);
  }

  static String convertAmountFormatedWithNumberOfDigits(
    String currency,
    double price,
    double amount,
    int numberOfDigits,
  ) {
    final amountConverted = convertAmount(price, amount);
    return formatWithNumberOfDigits(
      currency,
      amountConverted,
      numberOfDigits,
    );
  }
}
