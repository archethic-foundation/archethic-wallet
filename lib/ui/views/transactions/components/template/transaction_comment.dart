/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/blockchain/recent_transaction.dart';
import 'package:aewallet/ui/util/raw_info_popup.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class TransactionComment extends ConsumerWidget {
  const TransactionComment({super.key, required this.transaction});

  final RecentTransaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

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
        padding: const EdgeInsets.only(top: 5),
        alignment: Alignment.centerRight,
        width: 60,
        child: Icon(
          Symbols.chat,
          size: 18,
          color: theme.text,
          weight: IconSize.weightM,
          opticalSize: IconSize.opticalSizeM,
          grade: IconSize.gradeM,
        ),
      ),
    );
  }
}
