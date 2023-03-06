/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/primary_currency.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/domain/models/market_price.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionFees extends ConsumerWidget {
  const TransactionFees({
    super.key,
    required this.transaction,
    required this.marketPrice,
  });

  final RecentTransaction transaction;
  final MarketPrice marketPrice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final settings = ref.watch(SettingsProviders.settings);
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);

    final amountConverted =
        CurrencyUtil.convertAmountFormatedWithNumberOfDigits(
      settings.currency.name,
      marketPrice.amount,
      transaction.fee!,
      8,
    );

    return Row(
      children: <Widget>[
        if (settings.showBalances == true)
          primaryCurrency.primaryCurrency == AvailablePrimaryCurrencyEnum.native
              ? Text(
                  '${localizations.txListFees} ${transaction.fee!} ${AccountBalance.cryptoCurrencyLabel} ($amountConverted)',
                  style: theme.textStyleSize12W400Primary,
                )
              : Text(
                  '${localizations.txListFees} $amountConverted (${transaction.fee!} ${AccountBalance.cryptoCurrencyLabel})',
                  style: theme.textStyleSize12W400Primary,
                )
        else
          Text(
            '···········',
            style: theme.textStyleSize12W600Primary60,
          )
      ],
    );
  }
}
