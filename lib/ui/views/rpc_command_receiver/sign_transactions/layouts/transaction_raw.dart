import 'dart:convert';

import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:material_symbols_icons/symbols.dart';

class TransactionRaw extends StatefulWidget {
  const TransactionRaw(
    this.address,
    this.command, {
    super.key,
  });

  final MapEntry<int, awc.SignTransactionRequestData> command;
  final String? address;

  @override
  TransactionRawState createState() => TransactionRawState();
}

class TransactionRawState extends State<TransactionRaw> {
  bool isExpanded = false;

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: toggleExpanded,
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    isExpanded
                        ? Symbols.keyboard_arrow_down
                        : Symbols.keyboard_arrow_right,
                    size: 16,
                    weight: IconSize.weightM,
                    opticalSize: IconSize.opticalSizeM,
                    grade: IconSize.gradeM,
                  ),
                  Text(
                    localizations.signTransactionListTransactionsHeader
                        .replaceAll('%1', (widget.command.key + 1).toString()),
                    style: ArchethicThemeStyles.textStyleSize12W100Primary,
                  ),
                ],
              ),
              if (widget.address != null)
                Row(
                  children: [
                    Expanded(
                      child: SelectableText(
                        widget.address!.toUpperCase(),
                        style: ArchethicThemeStyles.textStyleSize12W100Primary,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isExpanded
              ? SizedBox.fromSize(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: ArchethicTheme.backgroundTransferListOutline,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    color: ArchethicTheme.backgroundTransferListCard,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SelectableText(
                        const JsonEncoder.withIndent('  ')
                            .convert(widget.command.value.data),
                        style: ArchethicThemeStyles.textStyleSize12W100Primary,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
