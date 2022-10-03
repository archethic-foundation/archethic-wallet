/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/model/setting_item.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:flutter/material.dart';

enum AvailableCurrencyEnum {
  USD,
  ARS,
  AUD,
  BRL,
  BTC,
  CAD,
  CHF,
  CLP,
  CNY,
  CZK,
  DKK,
  EUR,
  GBP,
  HKD,
  HUF,
  IDR,
  ILS,
  INR,
  JPY,
  KRW,
  KWD,
  MXN,
  MYR,
  NOK,
  NZD,
  PHP,
  PKR,
  PLN,
  RUB,
  SAR,
  SEK,
  SGD,
  THB,
  TRY,
  TWD,
  AED,
  ZAR
}

/// Represent the available authentication methods our app supports
class AvailableCurrency extends SettingSelectionItem {
  AvailableCurrency(this.currency);

  // Get best currency for a given locale
  // Default to USD
  factory AvailableCurrency.getBestForLocale(Locale locale) {
    for (final value in AvailableCurrencyEnum.values) {
      final currency = AvailableCurrency(value);
      if (locale.countryCode == null) {
        // Special cases
        if (<String>[
          'AT',
          'BE',
          'CY',
          'EE',
          'FI',
          'FR',
          'DE',
          'GR',
          'IE',
          'IT',
          'LV',
          'LT',
          'LU',
          'MT',
          'NL',
          'PT',
          'SK',
          'SI',
          'ES'
        ].contains(locale.countryCode)) {
          return AvailableCurrency(AvailableCurrencyEnum.EUR);
        } else if (CurrencyUtil.getLocale(currency.toString())
                .countryCode!
                .toUpperCase() ==
            locale.countryCode!.toUpperCase()) {
          return currency;
        }
      }
    }

    return AvailableCurrency(AvailableCurrencyEnum.USD);
  }

  AvailableCurrencyEnum currency;

  @override
  String getDisplayName(BuildContext context) {
    return '${CurrencyUtil.getCurrencySymbol(currency.name)} ${CurrencyUtil.getDisplayNameNoSymbol(currency.name)}';
  }

  // For saving to shared prefs
  int getIndex() {
    return currency.index;
  }
}
