/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/settings/primary_currency.dart';
import 'package:aewallet/domain/models/market_price.dart';
import 'package:aewallet/model/blockchain/recent_transaction.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/contacts/layouts/add_contact.dart';
import 'package:aewallet/ui/views/transactions/components/template/transaction_fees.dart';
import 'package:aewallet/ui/views/transactions/components/template/transaction_template.dart';
import 'package:aewallet/ui/views/transactions/components/template/transfer_balance.dart';
import 'package:aewallet/ui/views/transactions/components/transaction_output/transaction_output_information.dart';
import 'package:aewallet/ui/views/transactions/components/transaction_output/transfer_output.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TransactionOuput extends ConsumerWidget {
  const TransactionOuput({
    required this.transaction,
    required this.marketPrice,
    super.key,
  });

  final RecentTransaction transaction;
  final MarketPrice marketPrice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);

    return TransactionTemplate(
      transaction: transaction,
      borderColor: ArchethicTheme.backgroundRecentTxListCardTransferOutput,
      backgroundColor: ArchethicTheme.backgroundRecentTxListCardTransferOutput,
      onLongPress: () {
        if (transaction.contactInformation == null &&
            transaction.recipient != null) {
          context.push(
            AddContactSheet.routerPage,
            extra: transaction.recipient,
          );
        }
      },
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TransfertBalance(
            isCurrencyNative: primaryCurrency.primaryCurrency ==
                AvailablePrimaryCurrencyEnum.native,
            transaction: transaction,
            marketPrice: marketPrice,
            child: TransferOutput(
              isCurrencyNative: primaryCurrency.primaryCurrency ==
                  AvailablePrimaryCurrencyEnum.native,
              transaction: transaction,
            ),
          ),
        ],
      ),
      information: TransactionOutputInformation(
        transaction: transaction,
      ),
      fees: TransactionFees(transaction: transaction, marketPrice: marketPrice),
    );
  }
}
