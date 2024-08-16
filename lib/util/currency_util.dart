/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyUtil {
  static String getDisplayNameNoSymbol() {
    return 'US Dollar';
  }

  static String getCurrencySymbol() {
    return r'$';
  }

  static Locale getLocale() {
    return const Locale('en', 'US');
  }

  static String format(double amount) {
    return NumberFormat.currency(
      locale: CurrencyUtil.getLocale().toString(),
      symbol: CurrencyUtil.getCurrencySymbol(),
    ).format(amount);
  }

  static String formatWithNumberOfDigits(
    double amount,
    int numberOfDigits,
  ) {
    return NumberFormat.currency(
      locale: CurrencyUtil.getLocale().toString(),
      symbol: CurrencyUtil.getCurrencySymbol(),
      decimalDigits: numberOfDigits,
    ).format(amount);
  }

  static String getAmountPlusSymbol(double amount) {
    return '$amount ${CurrencyUtil.getCurrencySymbol()}';
  }

  static double convertAmount(double price, double amount) {
    return (Decimal.parse(amount.toString()) * Decimal.parse(price.toString()))
        .toDouble();
  }

  static String convertAmountFormated(
    double price,
    double amount,
  ) {
    final amountConverted = convertAmount(price, amount);
    return format(amountConverted);
  }

  static String convertAmountFormatedWithNumberOfDigits(
    double price,
    double amount,
    int numberOfDigits,
  ) {
    final amountConverted = convertAmount(price, amount);
    return formatWithNumberOfDigits(
      amountConverted,
      numberOfDigits,
    );
  }
}
