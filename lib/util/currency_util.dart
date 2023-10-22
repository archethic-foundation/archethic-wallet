/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyUtil {
  static String getDisplayNameNoSymbol(String currency) {
    switch (currency) {
      case 'ars':
        return 'Argentine Peso';
      case 'aud':
        return 'Australian Dollar';
      case 'brl':
        return 'Brazilian Real';
      case 'cad':
        return 'Canadian Dollar';
      case 'chf':
        return 'Swiss Franc';
      case 'clp':
        return 'Chilean Peso';
      case 'cny':
        return 'Chinese Yuan';
      case 'czk':
        return 'Czech Koruna';
      case 'dkk':
        return 'Danish Krone';
      case 'eur':
        return 'Euro';
      case 'gbp':
        return 'Great Britain Pound';
      case 'hkd':
        return 'Hong Kong Dollar';
      case 'huf':
        return 'Hungarian Forint';
      case 'idr':
        return 'Indonesian Rupiah';
      case 'ils':
        return 'Israeli Shekel';
      case 'inr':
        return 'Indian Rupee';
      case 'jpy':
        return 'Japanese Yen';
      case 'krw':
        return 'South Korean Won';
      case 'kwd':
        return 'Kuwaiti Dinar';
      case 'mxn':
        return 'Mexican Peso';
      case 'myr':
        return 'Malaysian Ringgit';
      case 'nok':
        return 'Norwegian Krone';
      case 'nzd':
        return 'New Zealand Dollar';
      case 'php':
        return 'Philippine Peso';
      case 'pkr':
        return 'Pakistani Rupee';
      case 'pln':
        return 'Polish Zloty';
      case 'rub':
        return 'Russian Ruble';
      case 'sar':
        return 'Saudi Riyal';
      case 'sek':
        return 'Swedish Krona';
      case 'sgd':
        return 'Singapore Dollar';
      case 'thb':
        return 'Thai Baht';
      case 'tli':
        return 'Turkish Lira';
      case 'twd':
        return 'Taiwan Dollar';
      case 'aed':
        return 'UAE Dirham';
      case 'zar':
        return 'South African Rand';
      case 'btc':
        return 'Bitcoin';
      case 'usd':
      default:
        return 'US Dollar';
    }
  }

  static String getCurrencySymbol(String currency) {
    switch (currency) {
      case 'ars':
        return r'$';
      case 'aud':
        return r'$';
      case 'brl':
        return r'R$';
      case 'cad':
        return r'$';
      case 'chf':
        return 'chf';
      case 'clp':
        return r'$';
      case 'cny':
        return '¥';
      case 'czk':
        return 'Kč';
      case 'dkk':
        return 'kr.';
      case 'eur':
        return '€';
      case 'gbp':
        return '£';
      case 'hkd':
        return r'HK$';
      case 'huf':
        return 'Ft';
      case 'idr':
        return 'Rp';
      case 'ils':
        return '₪';
      case 'inr':
        return '₹';
      case 'jpy':
        return '¥';
      case 'krw':
        return '₩';
      case 'kwd':
        return 'KD';
      case 'mxn':
        return r'$';
      case 'myr':
        return 'RM';
      case 'nok':
        return 'kr';
      case 'nzd':
        return r'$';
      case 'php':
        return '₱';
      case 'pkr':
        return 'Rs';
      case 'pln':
        return 'zł';
      case 'rub':
        return '\u20BD';
      case 'sar':
        return 'SR';
      case 'sek':
        return 'kr';
      case 'sgd':
        return r'$';
      case 'thb':
        return 'thb';
      case 'tli':
        return '₺';
      case 'twd':
        return r'NT$';
      case 'aed':
        return 'د.إ';
      case 'zar':
        return r'R$';
      case 'btc':
        return 'btc';
      case 'usd':
      default:
        return r'$';
    }
  }

  static Locale getLocale(String currency) {
    switch (currency) {
      case 'ars':
        return const Locale('es', 'AR');
      case 'aud':
        return const Locale('en', 'AU');
      case 'brl':
        return const Locale('pt', 'BR');
      case 'cad':
        return const Locale('en', 'CA');
      case 'chf':
        return const Locale('de', 'CH');
      case 'clp':
        return const Locale('es', 'CL');
      case 'cny':
        return const Locale('zh', 'CN');
      case 'czk':
        return const Locale('cs', 'CZ');
      case 'dkk':
        return const Locale('da', 'DK');
      case 'eur':
        return const Locale('fr', 'FR');
      case 'gbp':
        return const Locale('en', 'GB');
      case 'hkd':
        return const Locale('zh', 'HK');
      case 'huf':
        return const Locale('hu', 'HU');
      case 'idr':
        return const Locale('id', 'ID');
      case 'ils':
        return const Locale('he', 'IL');
      case 'inr':
        return const Locale('hi', 'IN');
      case 'jpy':
        return const Locale('ja', 'JP');
      case 'krw':
        return const Locale('ko', 'KR');
      case 'kwd':
        return const Locale('ar', 'KW');
      case 'mxn':
        return const Locale('es', 'MX');
      case 'myr':
        return const Locale('ta', 'MY');
      case 'nok':
        return const Locale('no', 'NO');
      case 'nzd':
        return const Locale('en', 'NZ');
      case 'php':
        return const Locale('tl', 'PH');
      case 'pkr':
        return const Locale('ur', 'PK');
      case 'pln':
        return const Locale('pl', 'PL');
      case 'rub':
        return const Locale('ru', 'RU');
      case 'sar':
        return const Locale('ar', 'SA');
      case 'sek':
        return const Locale('sv', 'SE');
      case 'sgd':
        return const Locale('zh', 'SG');
      case 'thb':
        return const Locale('th', 'TH');
      case 'tli':
        return const Locale('tr', 'TR');
      case 'twd':
        return const Locale('en', 'TW');
      case 'aed':
        return const Locale('ar', 'AE');
      case 'VES':
        return const Locale('es', 'VE');
      case 'zar':
        return const Locale('en', 'ZA');
      case 'usd':
      default:
        return const Locale('en', 'US');
    }
  }

  static String format(String currency, double amount) {
    if (currency == 'btc') {
      return '${amount.toStringAsFixed(8)} ${CurrencyUtil.getCurrencySymbol(currency)}';
    } else if (currency == 'eur') {
      return '${amount.toStringAsFixed(
        NumberFormat.currency(
          locale: CurrencyUtil.getLocale(currency).toString(),
          symbol: CurrencyUtil.getCurrencySymbol(currency),
        ).decimalDigits!,
      )} ${CurrencyUtil.getCurrencySymbol(currency)}';
    } else {
      return NumberFormat.currency(
        locale: CurrencyUtil.getLocale(currency).toString(),
        symbol: CurrencyUtil.getCurrencySymbol(currency),
      ).format(amount);
    }
  }

  static String formatWithNumberOfDigits(
    String currency,
    double amount,
    int numberOfDigits,
  ) {
    if (currency == 'btc') {
      return '${amount.toStringAsFixed(8)} ${CurrencyUtil.getCurrencySymbol(currency)}';
    } else {
      return NumberFormat.currency(
        locale: CurrencyUtil.getLocale(currency).toString(),
        symbol: CurrencyUtil.getCurrencySymbol(currency),
        decimalDigits: numberOfDigits,
      ).format(amount);
    }
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
