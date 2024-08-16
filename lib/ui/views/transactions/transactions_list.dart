import 'package:aewallet/model/blockchain/recent_transaction.dart';

import 'package:aewallet/ui/views/transactions/components/transaction_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionsList extends ConsumerWidget {
  const TransactionsList({super.key, required this.transactionsList});

  final List<RecentTransaction> transactionsList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => const SizedBox.shrink(),
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: MediaQuery.of(context).padding.bottom + 40,
      ),
      itemCount: transactionsList.length,
      itemBuilder: (BuildContext context, int index) {
        return TransactionDetail(
          transaction: transactionsList[index],
        );
      },
    );
  }
}
