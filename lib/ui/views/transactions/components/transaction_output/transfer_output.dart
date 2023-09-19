/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/model/blockchain/recent_transaction.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/ui/views/transactions/components/template/transfer_entry_template.dart';
import 'package:aewallet/ui/views/transactions/components/transaction_output/transaction_output_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransferOutput extends ConsumerWidget {
  const TransferOutput({
    super.key,
    required this.transaction,
    required this.isCurrencyNative,
  });

  final RecentTransaction transaction;
  final bool isCurrencyNative;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amountFormatted = transaction.amount!.toStringAsFixed(2);

    final hasTransactionInfo = transaction.tokenInformation != null;

    return TransferEntryTemplate(
      label: hasTransactionInfo
          ? '-$amountFormatted ${isCurrencyNative ? (transaction.tokenInformation!.symbol! == '' ? 'NFT' : transaction.tokenInformation!.symbol!) : transaction.tokenInformation!.symbol!}'
          : '-$amountFormatted ${AccountBalance.cryptoCurrencyLabel}',
      icon: const TransactionOutputIcon(),
    );
  }
}
