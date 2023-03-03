/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/ui/views/transactions/components/template/transfer_entry_template.dart';
import 'package:aewallet/ui/views/transactions/components/transaction_input/transaction_input_icon.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransferInput extends ConsumerWidget {
  const TransferInput({
    super.key,
    required this.transaction,
    required this.isCurrencyNative,
  });

  final RecentTransaction transaction;
  final bool isCurrencyNative;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amountFormatted = isCurrencyNative
        ? NumberUtil.formatThousands(transaction.amount!, round: true)
        : NumberUtil.formatThousands(transaction.amount!);

    final hasTransactionInfo = transaction.tokenInformations != null;

    return TransferEntryTemplate(
      label: hasTransactionInfo
          ? '$amountFormatted ${isCurrencyNative ? (transaction.tokenInformations!.symbol! == '' ? 'NFT' : transaction.tokenInformations!.symbol!) : transaction.tokenInformations!.symbol!}'
          : '$amountFormatted ${AccountBalance.cryptoCurrencyLabel}',
      icon: const TransactionInputIcon(),
    );
  }
}
