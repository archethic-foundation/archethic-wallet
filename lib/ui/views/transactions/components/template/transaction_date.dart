import 'package:aewallet/ui/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TransactionDate extends ConsumerWidget {
  const TransactionDate({super.key, required this.timestamp});

  final int? timestamp;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          style: ArchethicThemeStyles.textStyleSize12W100Primary,
        ),
      ],
    );
  }
}
