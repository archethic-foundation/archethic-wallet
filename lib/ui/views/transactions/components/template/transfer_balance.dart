/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/domain/models/market_price.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/transactions/components/template/transaction_hidden_value.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransfertBalance extends ConsumerWidget {
  const TransfertBalance({
    super.key,
    required this.transaction,
    required this.marketPrice,
    required this.isCurrencyNative,
    required this.child,
  });

  final RecentTransaction transaction;
  final MarketPrice marketPrice;
  final bool isCurrencyNative;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final settings = ref.watch(SettingsProviders.settings);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      verticalDirection:
          isCurrencyNative ? VerticalDirection.down : VerticalDirection.up,
      children: [
        if (transaction.amount != null)
          if (settings.showBalances == true)
            child
          else
            const TransactionHiddenValue(),
        if (transaction.tokenInformations == null && transaction.amount != null)
          if (settings.showBalances == true)
            Text(
              CurrencyUtil.convertAmountFormated(
                settings.currency.name,
                marketPrice.amount,
                transaction.amount!,
              ),
              style: theme.textStyleSize12W400Primary,
            )
          else
            const TransactionHiddenValue(),
      ],
    );
  }
}
