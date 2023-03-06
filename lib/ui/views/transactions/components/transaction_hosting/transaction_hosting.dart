import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/domain/models/market_price.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/ui/views/contacts/layouts/add_contact.dart';
import 'package:aewallet/ui/views/transactions/components/template/transaction_fees.dart';
import 'package:aewallet/ui/views/transactions/components/template/transaction_template.dart';
import 'package:aewallet/ui/views/transactions/components/transaction_hosting/transaction_hosting_information.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionHosting extends ConsumerWidget {
  const TransactionHosting({
    required this.transaction,
    required this.marketPrice,
    super.key,
  });

  final RecentTransaction transaction;
  final MarketPrice marketPrice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return TransactionTemplate(
      transaction: transaction,
      borderColor: theme.backgroundRecentTxListCardTokenCreation!,
      backgroundColor: theme.backgroundRecentTxListCardTokenCreation!,
      onLongPress: () {
        if (transaction.contactInformations == null &&
            transaction.recipient != null) {
          Sheets.showAppHeightNineSheet(
            context: context,
            ref: ref,
            widget: AddContactSheet(address: transaction.recipient),
          );
        }
      },
      right: const SizedBox(),
      information: TransactionHostingInformation(
        transaction: transaction,
      ),
      fees: TransactionFees(transaction: transaction, marketPrice: marketPrice),
    );
  }
}
