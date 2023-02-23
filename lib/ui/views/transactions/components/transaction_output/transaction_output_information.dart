/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/ui/util/address_formatters.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionOutputInformation extends ConsumerWidget {
  const TransactionOutputInformation({super.key, required this.transaction});

  final RecentTransaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;

    return Row(
      children: <Widget>[
        if (transaction.recipient == null)
          const Text('')
        else
          Text(
            '${localizations.txListTo} ${AddressFormatters(
              transaction.contactInformations == null
                  ? transaction.recipient!
                  : transaction.contactInformations!.format,
            ).getShortString4()}',
            style: theme.textStyleSize12W400Primary,
          )
      ],
    );
  }
}
