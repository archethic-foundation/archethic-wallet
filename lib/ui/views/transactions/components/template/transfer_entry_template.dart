/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/transactions/components/template/transaction_value_template.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransferEntryTemplate extends ConsumerWidget {
  const TransferEntryTemplate({
    super.key,
    required this.hasTransactionInfo,
    required this.label,
    required this.icon,
  });

  final bool hasTransactionInfo;
  final String label;
  final Widget icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Row(
      children: [
        if (hasTransactionInfo)
          TransactionValueTemplate(
            label: label,
            icon: icon,
          )
        else
          AutoSizeText(
            label,
            style: theme.textStyleSize12W400Primary,
          )
      ],
    );
  }
}
