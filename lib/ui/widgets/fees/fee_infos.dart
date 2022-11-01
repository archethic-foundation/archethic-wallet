/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/amount_formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FeeInfos extends ConsumerWidget {
  const FeeInfos({
    required this.feeEstimation,
    required this.tokenPrice,
    required this.currencyName,
    required this.estimatedFeesNote,
    super.key,
  });

  final AsyncValue<double> feeEstimation;
  final double tokenPrice;
  final String currencyName;
  final String estimatedFeesNote;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: feeEstimation.maybeWhen(
        loading: () => Row(
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
        data: (data) {
          if (data > 0) {
            return Text(
              '+ ${localizations.estimatedFees}: ${AmountFormatters.standardSmallValue(data, StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel())}\n(${CurrencyUtil.convertAmountFormatedWithNumberOfDigits(currencyName, tokenPrice, feeEstimation.valueOrNull ?? 0, 8)})',
              style: theme.textStyleSize14W100Primary,
              textAlign: TextAlign.center,
            );
          }
          return Text(
            estimatedFeesNote,
            style: theme.textStyleSize14W100Primary,
          );
        },
        orElse: SizedBox.new,
      ),
    );
  }
}
