import 'package:aewallet/ui/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionInformation extends ConsumerWidget {
  const TransactionInformation({
    super.key,
    required this.isEmpty,
    required this.message,
    this.prefixMessage = '',
  });

  final bool isEmpty;
  final String message;
  final String prefixMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: <Widget>[
        if (isEmpty)
          Text(
            AppLocalizations.of(context)!.executionSC,
            style: ArchethicThemeStyles.textStyleSize12W100Primary,
          )
        else
          Row(
            children: [
              if (prefixMessage.isNotEmpty)
                Text(
                  '$prefixMessage ',
                  style: ArchethicThemeStyles.textStyleSize12W100Primary60,
                ),
              Text(
                message,
                style: ArchethicThemeStyles.textStyleSize12W100Primary,
              ),
            ],
          ),
      ],
    );
  }
}
