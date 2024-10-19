/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/market_price.dart';
import 'package:aewallet/model/blockchain/recent_transaction.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/transactions/components/template/transaction_hidden_value.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
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
    final settings = ref.watch(SettingsProviders.settings);

    return Row(
      verticalDirection:
          isCurrencyNative ? VerticalDirection.down : VerticalDirection.up,
      children: [
        AutoSizeText(
          '${AppLocalizations.of(context)!.txListAmount} ',
          style: ArchethicThemeStyles.textStyleSize12W100Primary60,
        ),
        if (transaction.amount != null)
          if (settings.showBalances == true)
            child
          else
            const TransactionHiddenValue(),
        if (transaction.tokenInformation == null && transaction.amount != null)
          if (settings.showBalances == true)
            Text(
              ' (${CurrencyUtil.convertAmountFormated(
                marketPrice.amount,
                transaction.amount!,
              )})',
              style: ArchethicThemeStyles.textStyleSize12W100Primary,
            ),
      ],
    );
  }
}
