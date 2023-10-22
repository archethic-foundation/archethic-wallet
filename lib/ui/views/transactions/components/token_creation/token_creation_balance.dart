/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/model/blockchain/recent_transaction.dart';
import 'package:aewallet/ui/themes/styles.dart';
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
    final settings = ref.watch(SettingsProviders.settings);

    final currency =
        NumberUtil.formatThousands(transaction.tokenInformation!.supply!);

    final symbol = transaction.tokenInformation!.symbol! == ''
        ? 'NFT'
        : transaction.tokenInformation!.symbol!;

    return settings.showBalances
        ? AutoSizeText(
            '$currency $symbol',
            style: ArchethicThemeStyles.textStyleSize12W400Primary,
          )
        : const TransactionHiddenValue();
  }
}
