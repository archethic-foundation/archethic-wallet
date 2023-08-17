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

  /// Get best currency for a given locale
  /// Default to usd
  factory AvailableCurrency.getBestForLocale(Locale locale) {
    return AvailableCurrency(_currencyForLocale(locale));
  }

  static AvailableCurrencyEnum _currencyForLocale(Locale locale) {
    final countryCode = locale.countryCode;
    if (countryCode == null) return AvailableCurrencyEnum.usd;

    const eurCountries = [
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
      'ES',
    ];
    if (eurCountries.contains(countryCode)) return AvailableCurrencyEnum.eur;

    switch (countryCode) {
      case 'AR':
        return AvailableCurrencyEnum.ars;
      case 'AU':
        return AvailableCurrencyEnum.aud;
      case 'BR':
        return AvailableCurrencyEnum.brl;
      case 'CA':
        return AvailableCurrencyEnum.cad;
      case 'CH':
        return AvailableCurrencyEnum.chf;
      case 'CL':
        return AvailableCurrencyEnum.clp;
      case 'CN':
        return AvailableCurrencyEnum.cny;
      case 'CZ':
        return AvailableCurrencyEnum.czk;
      case 'DK':
        return AvailableCurrencyEnum.dkk;
      case 'GB':
        return AvailableCurrencyEnum.gbp;
      case 'HK':
        return AvailableCurrencyEnum.hkd;
      case 'HU':
        return AvailableCurrencyEnum.huf;
      case 'ID':
        return AvailableCurrencyEnum.idr;
      case 'IL':
        return AvailableCurrencyEnum.ils;
      case 'IN':
        return AvailableCurrencyEnum.inr;
      case 'JP':
        return AvailableCurrencyEnum.jpy;
      case 'KR':
        return AvailableCurrencyEnum.krw;
      case 'KW':
        return AvailableCurrencyEnum.kwd;
      case 'MX':
        return AvailableCurrencyEnum.mxn;
      case 'MY':
        return AvailableCurrencyEnum.myr;
      case 'NO':
        return AvailableCurrencyEnum.nok;
      case 'NZ':
        return AvailableCurrencyEnum.nzd;
      case 'PH':
        return AvailableCurrencyEnum.php;
      case 'PK':
        return AvailableCurrencyEnum.pkr;
      case 'PL':
        return AvailableCurrencyEnum.pln;
      case 'RU':
        return AvailableCurrencyEnum.rub;
      case 'SA':
        return AvailableCurrencyEnum.sar;
      case 'SE':
        return AvailableCurrencyEnum.sek;
      case 'SG':
        return AvailableCurrencyEnum.sgd;
      case 'TH':
        return AvailableCurrencyEnum.thb;
      case 'TR':
        return AvailableCurrencyEnum.tli;
      case 'TW':
        return AvailableCurrencyEnum.twd;
      case 'AE':
        return AvailableCurrencyEnum.aed;
      case 'ZA':
        return AvailableCurrencyEnum.zar;
    }
    return AvailableCurrencyEnum.usd;
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
