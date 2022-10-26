/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/currency.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class SelectedPrimaryCurrencyNotifier
    extends StateNotifier<AvailablePrimaryCurrency>
    with PrimaryCurrencyConverter {
  SelectedPrimaryCurrencyNotifier(this.ref)
      : super(
          const AvailablePrimaryCurrency(AvailablePrimaryCurrencyEnum.native),
        ) {
    _loadInitialValue();
  }

  final Ref ref;

  Future<void> _loadInitialValue() async {
    state = ref
        .read(SettingsProviders.localSettingsRepository)
        .getPrimaryCurrency();
  }

  Future<void> selectPrimaryCurrency({
    required AvailablePrimaryCurrency primaryCurrency,
  }) async {
    await ref
        .read(SettingsProviders.localSettingsRepository)
        .setPrimaryCurrency(primaryCurrency);
    state = primaryCurrency;
  }

  Future<void> switchSelectedPrimaryCurrency() async {
    await selectPrimaryCurrency(
      primaryCurrency: AvailablePrimaryCurrency(
        state.primaryCurrency == AvailablePrimaryCurrencyEnum.native
            ? AvailablePrimaryCurrencyEnum.fiat
            : AvailablePrimaryCurrencyEnum.native,
      ),
    );
  }

  double getValueConverted({
    required double amount,
    required double tokenPrice,
  }) {
    if (state.primaryCurrency == AvailablePrimaryCurrencyEnum.native) {
      return _convertNetworkCurrencyToSelectedCurrency(
        amount,
        tokenPrice,
        ref,
      );
    } else {
      return _convertSelectedCurrencyToNetworkCurrency(
        amount,
        tokenPrice,
      );
    }
  }

  String getValueConvertedLabel({
    required double amount,
    required double tokenPrice,
    required BuildContext context,
  }) {
    final amountConverted =
        getValueConverted(amount: amount, tokenPrice: tokenPrice);
    if (state.primaryCurrency == AvailablePrimaryCurrencyEnum.native) {
      final currency = ref.watch(CurrencyProviders.selectedCurrency);
      final localCurrencyFormat = NumberFormat.currency(
        locale: CurrencyUtil.getLocale(currency.currency.name).toString(),
        symbol: CurrencyUtil.getCurrencySymbol(
          currency.currency.name,
        ),
      );
      return localCurrencyFormat.format(amountConverted);
    } else {
      return '${amountConverted.toStringAsFixed(8)} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}';
    }
  }
}

final _selectedPrimaryCurrencyProvider = StateNotifierProvider<
    SelectedPrimaryCurrencyNotifier, AvailablePrimaryCurrency>(
  SelectedPrimaryCurrencyNotifier.new,
);

// @Riverpod(keepAlive: true)
// AvailablePrimaryCurrency _selectedPrimaryCurrency(
//   _SelectedPrimaryCurrencyRef ref,
// ) {
//   return ref
//       .read(SettingsProviders.localSettingsRepository)
//       .getPrimaryCurrency();
// }

// @Riverpod(keepAlive: true)
// Future<void> _selectPrimaryCurrency(
//   _SelectPrimaryCurrencyRef ref, {
//   required AvailablePrimaryCurrency primaryCurrency,
// }) async {
//   await ref
//       .read(SettingsProviders.localSettingsRepository)
//       .setPrimaryCurrency(primaryCurrency);
//   ref.refresh(_selectedPrimaryCurrencyProvider);
// }

abstract class PrimaryCurrencyProviders {
  static final selectedPrimaryCurrency = _selectedPrimaryCurrencyProvider;
}

mixin PrimaryCurrencyConverter {
  double _convertSelectedCurrencyToNetworkCurrency(
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

  double _convertNetworkCurrencyToSelectedCurrency(
    double amountEntered,
    double tokenPriceAmount,
    Ref ref,
  ) {
    if (amountEntered == 0 || tokenPriceAmount == 0) {
      return 0;
    }
    final currency = ref.watch(CurrencyProviders.selectedCurrency);
    final localCurrencyFormat = NumberFormat.currency(
      locale: CurrencyUtil.getLocale(currency.currency.name).toString(),
      symbol: CurrencyUtil.getCurrencySymbol(
        currency.currency.name,
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
