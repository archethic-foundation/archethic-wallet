import 'package:aewallet/application/check_transaction_worker/provider.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/util/notifications_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncomingTransactionsNotifier extends ConsumerStatefulWidget {
  const IncomingTransactionsNotifier({required this.child, super.key});
  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IncomingTransactionsWatcherState();
}

class _IncomingTransactionsWatcherState
    extends ConsumerState<IncomingTransactionsNotifier> {
  ReceivedTransaction? previousReceivedTransaction;

  @override
  Widget build(BuildContext context) {
    _listenCheckTransactions(context, ref);
    return widget.child;
  }

  void _listenCheckTransactions(BuildContext context, WidgetRef ref) {
    final element = ref.watch(CheckTransactionsProvider.provider).valueOrNull;

    if (element == null) return;
    if (element == previousReceivedTransaction) return;
    previousReceivedTransaction = element;

    final message = AppLocalization.of(context)!.transactionInputNotification;
    NotificationsUtil.showNotification(
      title: 'Archethic',
      body: message
          .replaceAll(
            '%1',
            fromBigInt(element.amount).toString(),
          )
          .replaceAll('%2', element.currencySymbol)
          .replaceAll('%3', element.accountName),
      payload: element.accountName,
    );
  }
}
