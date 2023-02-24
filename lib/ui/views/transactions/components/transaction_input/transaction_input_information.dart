/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/ui/util/address_formatters.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/views/transactions/components/template/transaction_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionInputInformation extends ConsumerWidget {
  const TransactionInputInformation({super.key, required this.transaction});

  final RecentTransaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;

    return TransactionInformation(
      isEmpty: transaction.from == null,
      message: '${localizations.txListFrom} ${AddressFormatters(
        transaction.contactInformations == null
            ? transaction.from!
            : transaction.contactInformations!.format,
      ).getShortString4()}',
    );
  }
}
