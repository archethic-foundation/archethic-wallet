/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'primary_currency.g.dart';

@riverpod
double _convertedValue(
  AutoDisposeRef ref, {
  required double amount,
  required double tokenPrice,
}) {
  final primaryCurrency = ref.watch(
    SettingsProviders.settings
        .select((settings) => settings.primaryCurrency.primaryCurrency),
  );
  if (primaryCurrency == AvailablePrimaryCurrencyEnum.native) {
    return PrimaryCurrencyConverter.networkCurrencyToSelectedCurrency(
      amount,
      tokenPrice,
      ref,
    );
  } else {
    return PrimaryCurrencyConverter.selectedCurrencyToNetworkCurrency(
      amount,
      tokenPrice,
    );
  }
}

@riverpod
String _convertedValueLabel(
  AutoDisposeRef ref, {
  required double amount,
  required double tokenPrice,
  required BuildContext context,
}) {
  final amountConverted = ref.watch(
    _convertedValueProvider(
      amount: amount,
      tokenPrice: tokenPrice,
    ),
  );

  final primaryCurrency = ref.watch(_selectedPrimaryCurrencyProvider);
  if (primaryCurrency.primaryCurrency == AvailablePrimaryCurrencyEnum.native) {
    final currency = ref.watch(
      SettingsProviders.settings.select((settings) => settings.currency),
    );
    final localCurrencyFormat = NumberFormat.currency(
      locale: CurrencyUtil.getLocale(currency.name).toString(),
      symbol: CurrencyUtil.getCurrencySymbol(
        currency.name,
      ),
    );
    return localCurrencyFormat.format(amountConverted);
  } else {
    return '${amountConverted.toStringAsFixed(8)} ${AccountBalance.cryptoCurrencyLabel}';
  }
}

@riverpod
AvailablePrimaryCurrency _selectedPrimaryCurrency(Ref ref) => ref.watch(
      SettingsProviders.settings.select((settings) => settings.primaryCurrency),
    );

abstract class PrimaryCurrencyProviders {
  // TODO(Chralu): merge conversion providers with [MarketPriceProviders] ones.
  static final convertedValue = _convertedValueProvider;

  // TODO(Chralu): merge conversion providers with [MarketPriceProviders] ones.
  static final convertedValueLabel = _convertedValueLabelProvider;
  static final selectedPrimaryCurrency = _selectedPrimaryCurrencyProvider;
}

abstract class PrimaryCurrencyConverter {
  static double selectedCurrencyToNetworkCurrency(
    double amountEntered,
    double tokenPriceAmount,
  ) {
    if (amountEntered == 0 || tokenPriceAmount == 0) {
      return 0;
    }
    return (Decimal.parse(amountEntered.toString()) /
            Decimal.parse(
              tokenPriceAmount.toString(),
            ))
        .toDouble();
  }

  static double networkCurrencyToSelectedCurrency(
    double amountEntered,
    double tokenPriceAmount,
    Ref ref,
  ) {
    if (amountEntered == 0 || tokenPriceAmount == 0) {
      return 0;
    }
    final currency = ref.watch(
      SettingsProviders.settings.select((settings) => settings.currency),
    );
    final localCurrencyFormat = NumberFormat.currency(
      locale: CurrencyUtil.getLocale(currency.name).toString(),
      symbol: CurrencyUtil.getCurrencySymbol(
        currency.name,
      ),
    );

    final convertedAmt = NumberUtil.sanitizeNumber(
      amountEntered.toString(),
      maxDecimalDigits: localCurrencyFormat.decimalDigits!,
    );
    if (convertedAmt.isEmpty) {
      return 0;
    }
    return (Decimal.parse(
              tokenPriceAmount.toString(),
            ) *
            Decimal.parse(convertedAmt))
        .toDouble();
  }
}
