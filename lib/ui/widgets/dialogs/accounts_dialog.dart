/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          account.name,
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
      builder: (BuildContext context) {
        final localizations = AppLocalization.of(context)!;
        final theme = ref.read(ThemeProviders.selectedTheme);
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.keychainHeader,
                  style: theme.textStyleSize24W700EquinoxPrimary,
                ),
                const SizedBox(
                  height: 5,
                ),
                if (accounts.length > 1)
                  Text(
                    localizations.selectAccountDescSeveral,
                    style: theme.textStyleSize12W100Primary,
                  )
                else
                  Text(
                    localizations.selectAccountDescOne,
                    style: theme.textStyleSize12W100Primary,
                  ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            side: BorderSide(
              color: theme.text45!,
            ),
          ),
          content: SingleChildScrollView(
            child: PickerWidget(
              pickerItems: pickerItemsList,
              selectedIndex: selectedIndex,
              onSelected: (value) {
                Navigator.pop(context, value.value);
              },
            ),
          ),
        );
      },
    );
  }
}
