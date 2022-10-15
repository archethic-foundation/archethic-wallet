/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/transactions/components/transaction_detail.dart';
// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TxList extends ConsumerWidget {
  const TxList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSelected = StateContainer.of(context)
        .appWallet!
        .appKeychain!
        .getAccountSelected()!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (accountSelected.recentTransactions!.isEmpty)
          Container(
            alignment: Alignment.center,
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 26),
              child: Text(
                AppLocalization.of(context)!.recentTransactionsNoTransactionYet,
                style: theme.textStyleSize14W600Primary,
              ),
            ),
          ),
        _TxListLine(num: 0, accountSelected: accountSelected),
        _TxListLine(num: 1, accountSelected: accountSelected),
        _TxListLine(num: 2, accountSelected: accountSelected),
        _TxListLine(num: 3, accountSelected: accountSelected),
        _TxListLine(num: 4, accountSelected: accountSelected),
        _TxListLine(num: 5, accountSelected: accountSelected),
        _TxListLine(num: 6, accountSelected: accountSelected),
        _TxListLine(num: 7, accountSelected: accountSelected),
        _TxListLine(num: 8, accountSelected: accountSelected),
        _TxListLine(num: 9, accountSelected: accountSelected)
      ],
    );
  }
}

class _TxListLine extends ConsumerWidget {
  const _TxListLine({
    required this.num,
    required this.accountSelected,
  });

  final int num;
  final Account accountSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 26, right: 26, top: 6),
        child: (accountSelected.recentTransactions!.isNotEmpty &&
                    accountSelected.recentTransactions!.length > num) ||
                (StateContainer.of(context).recentTransactionsLoading == true &&
                    accountSelected.recentTransactions!.length > num)
            ? TransactionDetail(
                transaction: accountSelected.recentTransactions![num],
              )
            : const SizedBox(),
      ),
    );
  }
}
