/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TransactionDate extends ConsumerWidget {
  const TransactionDate({super.key, required this.timestamp});

  final int? timestamp;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Row(
      children: <Widget>[
        Text(
          DateFormat.yMMMEd(
            Localizations.localeOf(context).languageCode,
          ).add_Hms().format(
                DateTime.fromMillisecondsSinceEpoch(
                  timestamp! * 1000,
                ).toLocal(),
              ),
          style: theme.textStyleSize12W400Primary,
        ),
      ],
    );
  }
}
