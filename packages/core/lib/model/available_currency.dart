/// SPDX-License-Identifier: AGPL-3.0-or-later

// ignore_for_file: constant_identifier_names

// Flutter imports:
import 'package:core/util/currency_util.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:core/model/setting_item.dart';

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

  AvailableCurrencyEnum currency;

  @override
  String getDisplayName(BuildContext context) {
    return CurrencyUtil.getCurrencySymbol(currency.name) +
        ' ' +
        CurrencyUtil.getDisplayNameNoSymbol(currency.name);
  }

  // For saving to shared prefs
  int getIndex() {
    return currency.index;
  }

  // Get best currency for a given locale
  // Default to USD
  static AvailableCurrency getBestForLocale(Locale locale) {
    for (AvailableCurrencyEnum value in AvailableCurrencyEnum.values) {
      final AvailableCurrency currency = AvailableCurrency(value);
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
}
