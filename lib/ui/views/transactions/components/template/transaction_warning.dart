/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class TransactionWarning extends ConsumerWidget {
  const TransactionWarning({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Icon(
          Symbols.warning,
          size: 10,
          weight: 300,
          opticalSize: 48,
          grade: -25,
        ),
        const SizedBox(width: 5),
        Text(
          message,
          style: theme.textStyleSize12W400Primary,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
