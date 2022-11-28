import 'package:aewallet/application/check_transaction_worker/provider.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/util/notifications_util.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncomingTransactionsNotifier extends ConsumerWidget {
  const IncomingTransactionsNotifier({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _listenCheckTransactions(context, ref);
    return child;
  }

  void _listenCheckTransactions(BuildContext context, WidgetRef ref) {
    final receivedTransactionList =
        ref.watch(CheckTransactionsProvider.provider).valueOrNull;

    if (receivedTransactionList == null || receivedTransactionList.isEmpty) {
      return;
    }
    final message = AppLocalization.of(context)!.transactionInputNotification;

    for (final receivedTransaction in receivedTransactionList) {
      NotificationsUtil.showNotification(
        title: 'Archethic',
        body: message
            .replaceAll(
              '%1',
              NumberUtil.formatThousands(
                  fromBigInt(receivedTransaction.amount),),
            )
            .replaceAll('%2', receivedTransaction.currencySymbol)
            .replaceAll('%3', receivedTransaction.accountName),
        payload: receivedTransaction.accountName,
      ).then((value) {
        ref.read(CheckTransactionsProvider.provider.notifier).clear();
      });
    }
  }
}
