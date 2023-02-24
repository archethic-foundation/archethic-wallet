/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/token.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/ui/views/transactions/components/template/transaction_date.dart';
import 'package:aewallet/ui/views/transactions/components/template/transaction_warning.dart';
import 'package:aewallet/ui/views/transactions/transaction_infos_sheet.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class TransactionTemplate extends ConsumerWidget {
  const TransactionTemplate({
    super.key,
    required this.transaction,
    this.onLongPress,
    required this.borderColor,
    required this.backgroundColor,
    required this.right,
    required this.information,
    this.fees,
  });

  final RecentTransaction transaction;
  final Function()? onLongPress;
  final Color borderColor;
  final Color backgroundColor;
  final Widget right;
  final Widget information;
  final Widget? fees;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(SettingsProviders.settings);
    final localizations = AppLocalization.of(context)!;

    final hasWarning = transaction.tokenInformations != null &&
        (kTokenFordiddenName.contains(
              transaction.tokenInformations!.name!.toUpperCase(),
            ) ||
            kTokenFordiddenName.contains(
              transaction.tokenInformations!.symbol!.toUpperCase(),
            ));

    return GestureDetector(
      onTap: () {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              settings.activeVibrations,
            );
        Sheets.showAppHeightNineSheet(
          context: context,
          ref: ref,
          widget: TransactionInfosSheet(transaction.address!),
        );
      },
      onLongPress: onLongPress,
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            color: backgroundColor,
            child: Container(
              padding: const EdgeInsets.all(9.5),
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[right],
                  ),
                  Column(
                    children: <Widget>[
                      information,
                      TransactionDate(timestamp: transaction.timestamp),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
