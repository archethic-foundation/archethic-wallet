/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:ui';

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/token.dart';
import 'package:aewallet/model/blockchain/recent_transaction.dart';
import 'package:aewallet/ui/views/transactions/components/template/transaction_comment.dart';
import 'package:aewallet/ui/views/transactions/components/template/transaction_date.dart';
import 'package:aewallet/ui/views/transactions/components/template/transaction_warning.dart';
import 'package:aewallet/ui/views/transactions/components/transaction_input/transaction_input_icon.dart';
import 'package:aewallet/ui/views/transactions/components/transaction_output/transaction_output_icon.dart';
import 'package:aewallet/ui/views/transactions/transaction_infos_sheet.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';

class TransactionTemplate extends ConsumerWidget {
  const TransactionTemplate({
    super.key,
    required this.transaction,
    this.onLongPress,
    required this.borderColor,
    required this.backgroundColor,
    required this.content,
    required this.information,
    this.fees,
  });

  final RecentTransaction transaction;
  final Function()? onLongPress;
  final Color borderColor;
  final Color backgroundColor;
  final Widget content;
  final Widget information;
  final Widget? fees;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(SettingsProviders.settings);
    final localizations = AppLocalizations.of(context)!;

    final hasWarning = transaction.tokenInformation != null &&
        (kTokenFordiddenName.contains(
              transaction.tokenInformation!.name!.toUpperCase(),
            ) ||
            kTokenFordiddenName.contains(
              transaction.tokenInformation!.symbol!.toUpperCase(),
            ));

    return GestureDetector(
      onTap: () {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              settings.activeVibrations,
            );
        context.go(
          TransactionInfosSheet.routerPage,
          extra: transaction.address,
        );
      },
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: borderColor,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(9.5),
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Column(
                      children: <Widget>[
                        TransactionDate(timestamp: transaction.timestamp),
                        information,
                        content,
                        if (fees != null) fees!,
                        Row(
                          children: [
                            if (hasWarning)
                              TransactionWarning(
                                message: localizations.notOfficialUCOWarning,
                              ),
                          ],
                        ),
                      ],
                    ),
                    if (transaction.typeTx == 1)
                      const TransactionInputIcon()
                    else
                      transaction.typeTx == 2
                          ? TransactionOutputIcon(transaction.recipient!)
                          : const SizedBox.shrink(),
                    if (transaction.decryptedSecret != null &&
                        transaction.decryptedSecret!.isNotEmpty)
                      Positioned(
                        top: 13,
                        child: TransactionComment(transaction: transaction),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
