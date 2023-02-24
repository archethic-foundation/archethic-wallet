/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionInformation extends ConsumerWidget {
  const TransactionInformation({
    super.key,
    required this.isEmpty,
    required this.message,
  });

  final bool isEmpty;
  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Row(
      children: <Widget>[
        if (isEmpty)
          const Text('')
        else
          Text(
            message,
            style: theme.textStyleSize12W400Primary,
          )
      ],
    );
  }
}
