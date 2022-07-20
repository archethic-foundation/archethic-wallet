/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/localization.dart';
import 'package:core/model/primary_currency.dart';

// Project imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/picker_item.dart';
import 'package:aeuniverse/util/preferences.dart';

class PrimaryCurrencyDialog {
  static Future<AvailablePrimaryCurrency?> getDialog(
      BuildContext context) async {
    final Preferences preferences = await Preferences.getInstance();
    final List<PickerItem> pickerItemsList =
        List<PickerItem>.empty(growable: true);
    for (var value in AvailablePrimaryCurrency.values) {
      pickerItemsList.add(PickerItem(
          PrimaryCurrencySetting(value).getDisplayName(context),
          null,
          null,
          null,
          value,
          true));
    }

    return await showDialog<AvailablePrimaryCurrency>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                AppLocalization.of(context)!.primaryCurrency,
                style: AppStyles.textStyleSize24W700EquinoxPrimary(context),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                side: BorderSide(
                    color: StateContainer.of(context).curTheme.text45!)),
            content: PickerWidget(
              pickerItems: pickerItemsList,
              selectedIndex: StateContainer.of(context)
                  .curPrimaryCurrency
                  .primaryCurrency
                  .index,
              onSelected: (value) {
                preferences.setPrimaryCurrency(PrimaryCurrencySetting(
                    value.value as AvailablePrimaryCurrency));
                if (StateContainer.of(context)
                        .curPrimaryCurrency
                        .primaryCurrency !=
                    value.value) {
                  StateContainer.of(context).updatePrimaryCurrency(
                      PrimaryCurrencySetting(
                          value.value as AvailablePrimaryCurrency));
                }
                Navigator.pop(context, value.value);
              },
            ),
          );
        });
  }
}
