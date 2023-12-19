/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/account/providers.dart';

import 'package:aewallet/model/blockchain/recent_transaction.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/transactions/components/transaction_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class TxList extends ConsumerWidget {
  const TxList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentTransactions = ref.watch(
      AccountProviders.selectedAccount.select(
        (account) => account.valueOrNull?.recentTransactions,
      ),
    );

    return Column(
      key: const Key('recentTransactions'),
      children: [
        if (recentTransactions != null)
          recentTransactions.isEmpty
              ? const _TransactionsEmpty()
              : _TransactionsList(recentTransactions: recentTransactions),
      ],
    );
  }
}

class _TransactionsList extends ConsumerWidget {
  const _TransactionsList({
    required this.recentTransactions,
  });

  final List<RecentTransaction> recentTransactions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var index = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: recentTransactions.map((recentTransaction) {
        index++;
        return TxListLine(
          recentTransaction: recentTransaction,
        )
            .animate(delay: (100 * index).ms)
            .fadeIn(duration: 400.ms, delay: 200.ms)
            .move(
              begin: const Offset(-16, 0),
              curve: Curves.easeOutQuad,
            );
      }).toList(),
    );
  }
}

class TxListLine extends ConsumerWidget {
  const TxListLine({
    super.key,
    required this.recentTransaction,
  });

  final RecentTransaction recentTransaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: TransactionDetail(
            transaction: recentTransaction,
          ),
        ),
      );
}

class _TransactionsEmpty extends ConsumerWidget {
  const _TransactionsEmpty();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 6),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: ArchethicTheme.backgroundFungiblesTokensListCard,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        color: ArchethicTheme.backgroundFungiblesTokensListCard,
        child: Container(
          padding: const EdgeInsets.all(9.5),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Row(
            children: [
              const Icon(
                Symbols.info,
                size: 18,
                weight: IconSize.weightM,
                opticalSize: IconSize.opticalSizeM,
                grade: IconSize.gradeM,
              ),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!
                    .recentTransactionsNoTransactionYet,
                style: ArchethicThemeStyles.textStyleSize12W100Primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
