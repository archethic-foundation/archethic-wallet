/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/model/setting_item.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:flutter/material.dart';

enum AvailableCurrencyEnum {
  usd,
  ars,
  aud,
  brl,
  btc,
  cad,
  chf,
  clp,
  cny,
  czk,
  dkk,
  eur,
  gbp,
  hkd,
  huf,
  idr,
  ils,
  inr,
  jpy,
  krw,
  kwd,
  mxn,
  myr,
  nok,
  nzd,
  php,
  pkr,
  pln,
  rub,
  sar,
  sek,
  sgd,
  thb,
  tli,
  twd,
  aed,
  zar
}

/// Represent the available authentication methods our app supports
@immutable
class AvailableCurrency extends SettingSelectionItem {
  const AvailableCurrency(this.currency);

  // Get best currency for a given locale
  // Default to usd
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
          return const AvailableCurrency(AvailableCurrencyEnum.eur);
        } else if (CurrencyUtil.getLocale(currency.toString()).countryCode!.toUpperCase() ==
            locale.countryCode!.toUpperCase()) {
          return currency;
        }
      }
    }

    return const AvailableCurrency(AvailableCurrencyEnum.usd);
  }

  final AvailableCurrencyEnum currency;

  @override
  String getDisplayName(BuildContext context) {
    return '${CurrencyUtil.getCurrencySymbol(currency.name)} ${CurrencyUtil.getDisplayNameNoSymbol(currency.name)}';
  }

  // For saving to shared prefs
  int getIndex() {
    return currency.index;
  }
}
