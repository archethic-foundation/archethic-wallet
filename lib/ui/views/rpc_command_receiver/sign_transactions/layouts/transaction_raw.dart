import 'dart:convert';

import 'package:aewallet/domain/rpc/commands/sign_transactions.dart';
import 'package:aewallet/ui/themes/themes.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:material_symbols_icons/symbols.dart';

class TransactionRaw extends StatefulWidget {
  const TransactionRaw(
    this.command,
    this.theme, {
    super.key,
  });

  final MapEntry<int, RPCSignTransactionCommandData> command;
  final BaseTheme theme;

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
          child: Row(
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
                localizations.signTransactionListTransactionsHeader.replaceAll(
                  '%1',
                  (widget.command.key + 1).toString(),
                ),
                style: widget.theme.textStyleSize12W400Primary,
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
                        color: widget.theme.backgroundTransferListOutline!,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    color: widget.theme.backgroundTransferListCard,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SelectableText(
                        const JsonEncoder.withIndent('  ')
                            .convert(widget.command.value.data),
                        style: widget.theme.textStyleSize12W400Primary,
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
