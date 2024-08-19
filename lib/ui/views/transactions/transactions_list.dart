import 'package:aewallet/model/blockchain/recent_transaction.dart';

import 'package:aewallet/ui/views/transactions/components/transaction_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionsList extends ConsumerStatefulWidget {
  const TransactionsList({super.key, required this.transactionsList});

  final List<RecentTransaction> transactionsList;

  @override
  ConsumerState<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends ConsumerState<TransactionsList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(
    BuildContext context,
  ) {
    super.build(context);

    return Column(
      children: widget.transactionsList.map((transaction) {
        return TransactionDetail(
          transaction: transaction,
        );
      }).toList(),
    );
  }
}
