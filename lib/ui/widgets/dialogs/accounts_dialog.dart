/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AccountsDialog {
  static Future<Account?> getDialog(
    BuildContext context,
    WidgetRef ref,
    Account selectedAccount,
    List<Account> accounts,
  ) async {
    final pickerItemsList = List<PickerItem>.empty(growable: true);

    for (final account in accounts) {
      pickerItemsList.add(
        PickerItem(
          account.nameDisplayed,
          null,
          null,
          null,
          account,
          true,
          key: Key('accountName${account.name}'),
        ),
      );
    }
    final selectedIndex =
        accounts.indexWhere((account) => account.name == selectedAccount.name);
    return showDialog<Account>(
      context: context,
      useRootNavigator: false,
      builder: (BuildContext context) {
        final localizations = AppLocalizations.of(context)!;

        return AlertDialog(
          backgroundColor: ArchethicTheme.backgroundPopupColor,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.accountHeader,
                  style: ArchethicThemeStyles.textStyleSize24W700Primary,
                ),
                const SizedBox(
                  height: 5,
                ),
                if (accounts.length > 1)
                  Text(
                    localizations.selectAccountDescSeveral,
                    style: ArchethicThemeStyles.textStyleSize12W100Primary,
                  )
                else
                  Text(
                    localizations.selectAccountDescOne,
                    style: ArchethicThemeStyles.textStyleSize12W100Primary,
                  ),
              ],
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          content: SingleChildScrollView(
            child: PickerWidget(
              pickerItems: pickerItemsList,
              selectedIndexes: [selectedIndex],
              onSelected: (value) {
                context.pop(value.value);
              },
            ),
          ),
        );
      },
    );
  }
}
