/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/model/blockchain/recent_transaction.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenCreationInformation extends ConsumerWidget {
  const TokenCreationInformation({super.key, required this.transaction});

  final RecentTransaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return Row(
      children: [
        if (transaction.tokenInformation!.type == 'fungible')
          Expanded(
            child: AutoSizeText(
              '${localizations.tokenCreated} ${transaction.tokenInformation!.name}',
              style: ArchethicThemeStyles.textStyleSize12W100Primary,
            ),
          )
        else
          Expanded(
            child: AutoSizeText(
              '${localizations.nftCreated} ${transaction.tokenInformation!.name}',
              style: ArchethicThemeStyles.textStyleSize12W100Primary,
            ),
          ),
        const SizedBox(
          width: 2,
        ),
      ],
    );
  }
}
