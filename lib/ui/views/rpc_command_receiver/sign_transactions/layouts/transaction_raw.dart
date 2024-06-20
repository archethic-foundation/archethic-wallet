import 'package:aewallet/application/settings/language.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionRaw extends ConsumerStatefulWidget {
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

class TransactionRawState extends ConsumerState<TransactionRaw> {
  @override
  Widget build(BuildContext context) {
    final language = ref.watch(
      LanguageProviders.selectedLanguage,
    );
    final transactionData = widget.command.value.data;
    final localizations = AppLocalizations.of(context)!;

    List<Widget> buildTransactionData() {
      final widgets = <Widget>[];

      if (transactionData.code?.isNotEmpty ?? false) {
        widgets.add(
          ListTile(
            title: const Text('Code'),
            subtitle: Text(transactionData.code!),
          ),
        );
      }
      if (transactionData.content?.isNotEmpty ?? false) {
        widgets.add(
          ListTile(
            title: const Text('Content'),
            subtitle: Text(transactionData.content!),
          ),
        );
      }

      if (transactionData.ledger != null) {
        if (transactionData.ledger!.token != null &&
            transactionData.ledger!.token!.transfers.isNotEmpty) {
          widgets.add(
            ListTile(
              title: SelectableText(
                'Token Transfers',
                style: ArchethicThemeStyles.textStyleSize12W400Highlighted,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: transactionData.ledger!.token!.transfers
                    .map(
                      (transfer) => Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectionArea(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Amount: ',
                                      style: ArchethicThemeStyles
                                          .textStyleSize12W400Highlighted,
                                    ),
                                    TextSpan(
                                      text: fromBigInt(transfer.amount)
                                          .toDouble()
                                          .formatNumber(
                                            language
                                                .getLocaleStringWithoutDefault(),
                                          ),
                                      style: ArchethicThemeStyles
                                          .textStyleSize12W100Primary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SelectionArea(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'To: ',
                                      style: ArchethicThemeStyles
                                          .textStyleSize12W400Highlighted,
                                    ),
                                    TextSpan(
                                      text: '${transfer.to}',
                                      style: ArchethicThemeStyles
                                          .textStyleSize12W100Primary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        }
        if (transactionData.ledger!.uco != null &&
            transactionData.ledger!.uco!.transfers.isNotEmpty) {
          widgets.add(
            ListTile(
              title: SelectableText(
                'UCO Transfers',
                style: ArchethicThemeStyles.textStyleSize12W400Highlighted,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: transactionData.ledger!.uco!.transfers
                    .map(
                      (transfer) => Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectionArea(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Amount: ',
                                      style: ArchethicThemeStyles
                                          .textStyleSize12W400Highlighted,
                                    ),
                                    TextSpan(
                                      text: fromBigInt(transfer.amount)
                                          .toDouble()
                                          .formatNumber(
                                            language
                                                .getLocaleStringWithoutDefault(),
                                          ),
                                      style: ArchethicThemeStyles
                                          .textStyleSize12W100Primary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SelectionArea(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'To: ',
                                      style: ArchethicThemeStyles
                                          .textStyleSize12W400Highlighted,
                                    ),
                                    TextSpan(
                                      text: '${transfer.to}',
                                      style: ArchethicThemeStyles
                                          .textStyleSize12W100Primary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        }
      }

      if (transactionData.ownerships.isNotEmpty) {
        widgets.add(
          ListTile(
            title: SelectableText(
              'Ownerships',
              style: ArchethicThemeStyles.textStyleSize12W400Highlighted,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: transactionData.ownerships
                  .map(
                    (ownership) => Text(
                      ownership.toString(),
                      style: ArchethicThemeStyles.textStyleSize12W100Primary,
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      }

      if (transactionData.actionRecipients.isNotEmpty) {
        widgets.add(
          ListTile(
            title: SelectableText(
              'Smart contract calls',
              style: ArchethicThemeStyles.textStyleSize12W400Highlighted,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: transactionData.actionRecipients
                  .map(
                    (actionRecipient) => Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectionArea(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Action: ',
                                    style: ArchethicThemeStyles
                                        .textStyleSize12W400Highlighted,
                                  ),
                                  TextSpan(
                                    text: actionRecipient.action ?? '',
                                    style: ArchethicThemeStyles
                                        .textStyleSize12W100Primary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SelectionArea(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Address: ',
                                    style: ArchethicThemeStyles
                                        .textStyleSize12W400Highlighted,
                                  ),
                                  TextSpan(
                                    text: actionRecipient.address ?? '',
                                    style: ArchethicThemeStyles
                                        .textStyleSize12W100Primary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SelectionArea(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Arguments: ',
                                    style: ArchethicThemeStyles
                                        .textStyleSize12W400Highlighted,
                                  ),
                                  TextSpan(
                                    text: actionRecipient.args!.join(', '),
                                    style: ArchethicThemeStyles
                                        .textStyleSize12W100Primary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      }

      return widgets;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buildTransactionData(),
        ),
      ),
    );
  }
}
