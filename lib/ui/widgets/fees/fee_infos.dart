/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/ui/util/amount_formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FeeInfos extends ConsumerWidget {
  const FeeInfos({
    required this.asyncFeeEstimation,
    required this.estimatedFeesNote,
    super.key,
  });

  final AsyncValue<double> asyncFeeEstimation;
  final String estimatedFeesNote;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;

    final nativeFeeEstimation = asyncFeeEstimation.valueOrNull;
    if (nativeFeeEstimation == null) {
      return const _LoadingFeeInfos();
    }

    if (nativeFeeEstimation <= 0) {
      return _CannotLoadFeeInfos(estimatedFeesNote: estimatedFeesNote);
    }

    final fiatFeeEstimation = ref
        .watch(
          MarketPriceProviders.convertedToSelectedCurrency(
            nativeAmount: nativeFeeEstimation,
          ),
        )
        .valueOrNull;
    if (fiatFeeEstimation == null) {
      return const _LoadingFeeInfos();
    }

    final currencyName = ref
        .watch(
          SettingsProviders.settings.select((settings) => settings.currency),
        )
        .name;

    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Text(
        '+ ${localizations.estimatedFees} ${AmountFormatters.standardSmallValue(
          nativeFeeEstimation,
          AccountBalance.cryptoCurrencyLabel,
        )}\n(${CurrencyUtil.formatWithNumberOfDigits(
          currencyName,
          fiatFeeEstimation,
          8,
        )})',
        style: theme.textStyleSize14W100Primary,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _CannotLoadFeeInfos extends ConsumerWidget {
  const _CannotLoadFeeInfos({
    required this.estimatedFeesNote,
  });
  final String estimatedFeesNote;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Text(
        estimatedFeesNote,
        style: theme.textStyleSize14W100Primary,
      ),
    );
  }
}

class _LoadingFeeInfos extends ConsumerWidget {
  const _LoadingFeeInfos();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            localizations.estimatedFeesCalculationNote,
            style: theme.textStyleSize14W100Primary,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 3,
              top: 10,
            ),
            child: LoadingAnimationWidget.prograssiveDots(
              color: theme.text!,
              size: 12,
            ),
          ),
        ],
      ),
    );
  }
}
