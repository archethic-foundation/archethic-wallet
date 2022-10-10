/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrimaryCurrencyDialog {
  static Future<AvailablePrimaryCurrency?> getDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final preferences = await Preferences.getInstance();
    final pickerItemsList = List<PickerItem>.empty(growable: true);
    for (final value in AvailablePrimaryCurrency.values) {
      pickerItemsList.add(
        PickerItem(
          PrimaryCurrencySetting(value).getDisplayName(context),
          null,
          null,
          null,
          value,
          true,
        ),
      );
    }

    return showDialog<AvailablePrimaryCurrency>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        final theme = ref.watch(ThemeProviders.theme);
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              AppLocalization.of(context)!.primaryCurrency,
              style: theme.textStyleSize24W700EquinoxPrimary,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            side: BorderSide(
              color: theme.text45!,
            ),
          ),
          content: PickerWidget(
            pickerItems: pickerItemsList,
            selectedIndex: StateContainer.of(context).curPrimaryCurrency.primaryCurrency.index,
            onSelected: (value) {
              preferences.setPrimaryCurrency(
                PrimaryCurrencySetting(
                  value.value as AvailablePrimaryCurrency,
                ),
              );
              if (StateContainer.of(context).curPrimaryCurrency.primaryCurrency != value.value) {
                StateContainer.of(context).updatePrimaryCurrency(
                  PrimaryCurrencySetting(
                    value.value as AvailablePrimaryCurrency,
                  ),
                );
              }
              Navigator.pop(context, value.value);
            },
          ),
        );
      },
    );
  }
}
