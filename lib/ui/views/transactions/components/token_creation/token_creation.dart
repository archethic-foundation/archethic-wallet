/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/domain/models/market_price.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/ui/views/transactions/components/template/transaction_fees.dart';
import 'package:aewallet/ui/views/transactions/components/template/transaction_template.dart';
import 'package:aewallet/ui/views/transactions/components/token_creation/token_creation_balance.dart';
import 'package:aewallet/ui/views/transactions/components/token_creation/token_creation_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenCreation extends ConsumerWidget {
  const TokenCreation({
    required this.transaction,
    required this.marketPrice,
    super.key,
  });

  final RecentTransaction transaction;
  final MarketPrice marketPrice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return TransactionTemplate(
      transaction: transaction,
      borderColor: theme.backgroundRecentTxListCardTokenCreation!,
      backgroundColor: theme.backgroundRecentTxListCardTokenCreation!,
      right: TokenCreationBalance(
        transaction: transaction,
      ),
      information: TokenCreationInformation(
        transaction: transaction,
      ),
      fees: TransactionFees(transaction: transaction, marketPrice: marketPrice),
    );
  }
}
