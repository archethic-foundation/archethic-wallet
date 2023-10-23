/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/application/settings/primary_currency.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/amount_formatters.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
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
    final localizations = AppLocalizations.of(context)!;
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);

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

    return SizedBox(
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            localizations.estimatedFees,
          ),
          if (primaryCurrency.primaryCurrency ==
              AvailablePrimaryCurrencyEnum.native)
            Text(
              '${AmountFormatters.standardSmallValue(
                nativeFeeEstimation,
                AccountBalance.cryptoCurrencyLabel,
                decimal: 2,
              )} / ${CurrencyUtil.formatWithNumberOfDigits(
                currencyName,
                fiatFeeEstimation,
                2,
              )}',
              style: ArchethicThemeStyles.textStyleSize14W100Primary,
            )
          else
            Text(
              '${CurrencyUtil.formatWithNumberOfDigits(
                currencyName,
                fiatFeeEstimation,
                2,
              )} / ${AmountFormatters.standardSmallValue(
                nativeFeeEstimation,
                AccountBalance.cryptoCurrencyLabel,
                decimal: 2,
              )}',
              style: ArchethicThemeStyles.textStyleSize14W100Primary,
            ),
        ],
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
    return SizedBox(
      height: 40,
      child: Text(
        estimatedFeesNote,
        style: ArchethicThemeStyles.textStyleSize14W100Primary,
      ),
    );
  }
}

class _LoadingFeeInfos extends ConsumerWidget {
  const _LoadingFeeInfos();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return SizedBox(
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.estimatedFeesCalculationNote,
            style: ArchethicThemeStyles.textStyleSize14W100Primary,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 3,
              top: 10,
            ),
            child: LoadingAnimationWidget.prograssiveDots(
              color: ArchethicTheme.text,
              size: 10,
            ),
          ),
        ],
      ),
    );
  }
}
