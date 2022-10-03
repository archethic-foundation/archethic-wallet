/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

class CurrencyUtil {
  static String getDisplayNameNoSymbol(String currency) {
    switch (currency) {
      case 'ARS':
        return 'Argentine Peso';
      case 'AUD':
        return 'Australian Dollar';
      case 'BRL':
        return 'Brazilian Real';
      case 'CAD':
        return 'Canadian Dollar';
      case 'CHF':
        return 'Swiss Franc';
      case 'CLP':
        return 'Chilean Peso';
      case 'CNY':
        return 'Chinese Yuan';
      case 'CZK':
        return 'Czech Koruna';
      case 'DKK':
        return 'Danish Krone';
      case 'EUR':
        return 'Euro';
      case 'GBP':
        return 'Great Britain Pound';
      case 'HKD':
        return 'Hong Kong Dollar';
      case 'HUF':
        return 'Hungarian Forint';
      case 'IDR':
        return 'Indonesian Rupiah';
      case 'ILS':
        return 'Israeli Shekel';
      case 'INR':
        return 'Indian Rupee';
      case 'JPY':
        return 'Japanese Yen';
      case 'KRW':
        return 'South Korean Won';
      case 'KWD':
        return 'Kuwaiti Dinar';
      case 'MXN':
        return 'Mexican Peso';
      case 'MYR':
        return 'Malaysian Ringgit';
      case 'NOK':
        return 'Norwegian Krone';
      case 'NZD':
        return 'New Zealand Dollar';
      case 'PHP':
        return 'Philippine Peso';
      case 'PKR':
        return 'Pakistani Rupee';
      case 'PLN':
        return 'Polish Zloty';
      case 'RUB':
        return 'Russian Ruble';
      case 'SAR':
        return 'Saudi Riyal';
      case 'SEK':
        return 'Swedish Krona';
      case 'SGD':
        return 'Singapore Dollar';
      case 'THB':
        return 'Thai Baht';
      case 'TRY':
        return 'Turkish Lira';
      case 'TWD':
        return 'Taiwan Dollar';
      case 'AED':
        return 'UAE Dirham';
      case 'ZAR':
        return 'South African Rand';
      case 'BTC':
        return 'Bitcoin';
      case 'USD':
      default:
        return 'US Dollar';
    }
  }

  static String getCurrencySymbol(String currency) {
    switch (currency) {
      case 'ARS':
        return r'$';
      case 'AUD':
        return r'$';
      case 'BRL':
        return r'R$';
      case 'CAD':
        return r'$';
      case 'CHF':
        return 'CHF';
      case 'CLP':
        return r'$';
      case 'CNY':
        return '¥';
      case 'CZK':
        return 'Kč';
      case 'DKK':
        return 'kr.';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'HKD':
        return r'HK$';
      case 'HUF':
        return 'Ft';
      case 'IDR':
        return 'Rp';
      case 'ILS':
        return '₪';
      case 'INR':
        return '₹';
      case 'JPY':
        return '¥';
      case 'KRW':
        return '₩';
      case 'KWD':
        return 'KD';
      case 'MXN':
        return r'$';
      case 'MYR':
        return 'RM';
      case 'NOK':
        return 'kr';
      case 'NZD':
        return r'$';
      case 'PHP':
        return '₱';
      case 'PKR':
        return 'Rs';
      case 'PLN':
        return 'zł';
      case 'RUB':
        return '\u20BD';
      case 'SAR':
        return 'SR';
      case 'SEK':
        return 'kr';
      case 'SGD':
        return r'$';
      case 'THB':
        return 'THB';
      case 'TRY':
        return '₺';
      case 'TWD':
        return r'NT$';
      case 'AED':
        return 'د.إ';
      case 'ZAR':
        return r'R$';
      case 'BTC':
        return 'BTC';
      case 'USD':
      default:
        return r'$';
    }
  }

  static Locale getLocale(String currency) {
    switch (currency) {
      case 'ARS':
        return const Locale('es', 'AR');
      case 'AUD':
        return const Locale('en', 'AU');
      case 'BRL':
        return const Locale('pt', 'BR');
      case 'CAD':
        return const Locale('en', 'CA');
      case 'CHF':
        return const Locale('de', 'CH');
      case 'CLP':
        return const Locale('es', 'CL');
      case 'CNY':
        return const Locale('zh', 'CN');
      case 'CZK':
        return const Locale('cs', 'CZ');
      case 'DKK':
        return const Locale('da', 'DK');
      case 'EUR':
        return const Locale('fr', 'FR');
      case 'GBP':
        return const Locale('en', 'GB');
      case 'HKD':
        return const Locale('zh', 'HK');
      case 'HUF':
        return const Locale('hu', 'HU');
      case 'IDR':
        return const Locale('id', 'ID');
      case 'ILS':
        return const Locale('he', 'IL');
      case 'INR':
        return const Locale('hi', 'IN');
      case 'JPY':
        return const Locale('ja', 'JP');
      case 'KRW':
        return const Locale('ko', 'KR');
      case 'KWD':
        return const Locale('ar', 'KW');
      case 'MXN':
        return const Locale('es', 'MX');
      case 'MYR':
        return const Locale('ta', 'MY');
      case 'NOK':
        return const Locale('no', 'NO');
      case 'NZD':
        return const Locale('en', 'NZ');
      case 'PHP':
        return const Locale('tl', 'PH');
      case 'PKR':
        return const Locale('ur', 'PK');
      case 'PLN':
        return const Locale('pl', 'PL');
      case 'RUB':
        return const Locale('ru', 'RU');
      case 'SAR':
        return const Locale('ar', 'SA');
      case 'SEK':
        return const Locale('sv', 'SE');
      case 'SGD':
        return const Locale('zh', 'SG');
      case 'THB':
        return const Locale('th', 'TH');
      case 'TRY':
        return const Locale('tr', 'TR');
      case 'TWD':
        return const Locale('en', 'TW');
      case 'AED':
        return const Locale('ar', 'AE');
      case 'VES':
        return const Locale('es', 'VE');
      case 'ZAR':
        return const Locale('en', 'ZA');
      case 'USD':
      default:
        return const Locale('en', 'US');
    }
  }

  static String getConvertedAmount(String currency, double amount) {
    if (currency == 'BTC') {
      return '${amount.toStringAsFixed(8)} ${CurrencyUtil.getCurrencySymbol(currency)}';
    } else if (currency == 'EUR') {
      return '${amount.toStringAsFixed(NumberFormat.currency(locale: CurrencyUtil.getLocale(currency).toString(), symbol: CurrencyUtil.getCurrencySymbol(currency)).decimalDigits!)} ${CurrencyUtil.getCurrencySymbol(currency)}';
    } else {
      return NumberFormat.currency(
        locale: CurrencyUtil.getLocale(currency).toString(),
        symbol: CurrencyUtil.getCurrencySymbol(currency),
      ).format(amount);
    }
  }

  static String getConvertedAmountWithNumberOfDigits(
    String currency,
    double amount,
    int numberOfDigits,
  ) {
    if (currency == 'BTC') {
      return '${amount.toStringAsFixed(8)} ${CurrencyUtil.getCurrencySymbol(currency)}';
    } else {
      return NumberFormat.currency(
        locale: CurrencyUtil.getLocale(currency).toString(),
        symbol: CurrencyUtil.getCurrencySymbol(currency),
        decimalDigits: numberOfDigits,
      ).format(amount);
    }
  }

  static String getAmountDisplay(
    double amount, {
    String? networkCryptoCurrencyLabel = '',
  }) {
    if (networkCryptoCurrencyLabel!.isEmpty) {
      return amount.toString();
    } else {
      return '$amount $networkCryptoCurrencyLabel';
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
    return getConvertedAmount(currency, amountConverted);
  }

  static String convertAmountFormatedWithNumberOfDigits(
    String currency,
    double price,
    double amount,
    int numberOfDigits,
  ) {
    final amountConverted = convertAmount(price, amount);
    return getConvertedAmountWithNumberOfDigits(
      currency,
      amountConverted,
      numberOfDigits,
    );
  }
}
