/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/model/blockchain/recent_transaction.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/transactions/components/transaction_output/transaction_output_icon.dart';
import 'package:aewallet/ui/widgets/tokens/verified_token_icon.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
    final hasTransactionInfo = transaction.tokenInformation != null;

    final amountFormatted = NumberUtil.formatThousandsStr(
      transaction.amount!.toStringAsFixed(
        hasTransactionInfo &&
                transaction.tokenInformation!.type == 'non-fungible'
            ? 0
            : 2,
      ),
    );

    return Row(
      children: [
        AutoSizeText(
          hasTransactionInfo
              ? '-$amountFormatted ${isCurrencyNative ? (transaction.tokenInformation!.symbol! == '' ? 'NFT' : transaction.tokenInformation!.symbol!) : transaction.tokenInformation!.symbol!}'
              : '-$amountFormatted ${AccountBalance.cryptoCurrencyLabel}',
          style: ArchethicThemeStyles.textStyleSize12W400Primary,
        ),
        if (transaction.tokenInformation != null &&
            transaction.tokenInformation!.type == 'fungible' &&
            transaction.tokenAddress != null)
          Row(
            children: [
              const SizedBox(
                width: 2,
              ),
              VerifiedTokenIcon(
                address: transaction.tokenAddress!,
              ),
            ],
          ),
        const SizedBox(
          width: 2,
        ),
        const TransactionOutputIcon(),
      ],
    );
  }
}
