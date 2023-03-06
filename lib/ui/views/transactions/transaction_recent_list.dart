/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/transactions/components/transaction_detail.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: recentTransactions
          .map(
            (recentTransaction) => TxListLine(
              recentTransaction: recentTransaction,
            ),
          )
          .toList(),
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
          padding: const EdgeInsets.only(left: 5, right: 5, top: 6),
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
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Container(
      alignment: Alignment.center,
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 6),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: theme.backgroundFungiblesTokensListCard!,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          color: theme.backgroundFungiblesTokensListCard,
          child: Container(
            padding: const EdgeInsets.all(9.5),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Row(
              children: [
                const Icon(
                  UiIcons.about,
                  size: 16,
                ),
                const SizedBox(width: 5),
                Text(
                  AppLocalization.of(context)!
                      .recentTransactionsNoTransactionYet,
                  style: theme.textStyleSize12W100Primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
