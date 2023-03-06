/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/ui/views/transactions/components/template/transaction_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionHostingInformation extends ConsumerWidget {
  const TransactionHostingInformation({super.key, required this.transaction});

  final RecentTransaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;

    return TransactionInformation(
      isEmpty: false,
      message: localizations.aewebHosting,
    );
  }
}
