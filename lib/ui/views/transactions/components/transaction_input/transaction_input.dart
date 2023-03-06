/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/primary_currency.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/domain/models/market_price.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/views/contacts/layouts/add_contact.dart';
import 'package:aewallet/ui/views/transactions/components/template/transaction_comment.dart';
import 'package:aewallet/ui/views/transactions/components/template/transaction_template.dart';
import 'package:aewallet/ui/views/transactions/components/template/transfer_balance.dart';
import 'package:aewallet/ui/views/transactions/components/transaction_input/transaction_input_information.dart';
import 'package:aewallet/ui/views/transactions/components/transaction_input/transfer_input.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);

    return TransactionTemplate(
      transaction: transaction,
      borderColor: theme.backgroundRecentTxListCardTransferInput!,
      backgroundColor: theme.backgroundRecentTxListCardTransferInput!,
      onLongPress: () {
        if (transaction.contactInformations == null &&
            transaction.from != null) {
          Sheets.showAppHeightNineSheet(
            context: context,
            ref: ref,
            widget: AddContactSheet(address: transaction.from),
          );
        }
      },
      right: Column(
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
          if (transaction.decryptedSecret != null &&
              transaction.decryptedSecret!.isNotEmpty)
            TransactionComment(transaction: transaction)
          else
            const SizedBox()
        ],
      ),
      information: TransactionInputInformation(
        transaction: transaction,
      ),
    );
  }
}
