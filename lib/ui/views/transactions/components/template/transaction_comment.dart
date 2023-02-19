/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/ui/util/raw_info_popup.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionComment extends ConsumerWidget {
  const TransactionComment({super.key, required this.transaction});

  final RecentTransaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;

    return GestureDetector(
      onLongPressEnd: (details) {
        RawInfoPopup.getPopup(
          context,
          ref,
          details,
          transaction.decryptedSecret![0],
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.only(top: 5),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              localizations.messageInTxTransfer,
              style: theme.textStyleSize12W400Primary,
            ),
            const SizedBox(width: 10),
            FaIcon(
              FontAwesomeIcons.commentDots,
              size: 12,
              color: theme.text,
            ),
          ],
        ),
      ),
    );
  }
}
