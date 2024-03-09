/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/settings/primary_currency.dart';
import 'package:aewallet/domain/models/market_price.dart';
import 'package:aewallet/model/blockchain/recent_transaction.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/contacts/layouts/add_contact.dart';
import 'package:aewallet/ui/views/transactions/components/template/transaction_template.dart';
import 'package:aewallet/ui/views/transactions/components/template/transfer_balance.dart';
import 'package:aewallet/ui/views/transactions/components/transaction_input/transaction_input_information.dart';
import 'package:aewallet/ui/views/transactions/components/transaction_input/transfer_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TransactionInput extends ConsumerWidget {
  const TransactionInput({
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
      borderColor: ArchethicTheme.backgroundRecentTxListCardTransferInput,
      backgroundColor: ArchethicTheme.backgroundRecentTxListCardTransferInput,
      onLongPress: () {
        if (transaction.contactInformation == null &&
            transaction.from != null) {
          context.push(
            AddContactSheet.routerPage,
            extra: transaction.from,
          );
        }
      },
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TransfertBalance(
            transaction: transaction,
            marketPrice: marketPrice,
            isCurrencyNative: primaryCurrency.primaryCurrency ==
                AvailablePrimaryCurrencyEnum.native,
            child: TransferInput(
              transaction: transaction,
              isCurrencyNative: primaryCurrency.primaryCurrency ==
                  AvailablePrimaryCurrencyEnum.native,
            ),
          ),
        ],
      ),
      information: TransactionInputInformation(
        transaction: transaction,
      ),
    );
  }
}
