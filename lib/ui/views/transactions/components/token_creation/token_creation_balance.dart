/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/transactions/components/template/transaction_hidden_value.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenCreationBalance extends ConsumerWidget {
  const TokenCreationBalance({super.key, required this.transaction});

  final RecentTransaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final settings = ref.watch(SettingsProviders.settings);

    final currency =
        NumberUtil.formatThousands(transaction.tokenInformations!.supply!);

    final symbol = transaction.tokenInformations!.symbol! == ''
        ? 'NFT'
        : transaction.tokenInformations!.symbol!;

    return settings.showBalances
        ? AutoSizeText(
            '$currency $symbol',
            style: theme.textStyleSize12W400Primary,
          )
        : const TransactionHiddenValue();
  }
}
