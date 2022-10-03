/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/util/preferences.dart';

class LanguageDialog {
  static Future<AvailableLanguage?> getDialog(BuildContext context) async {
    final Preferences preferences = await Preferences.getInstance();
    final List<PickerItem> pickerItemsList = List<PickerItem>.empty(growable: true);
    for (var value in AvailableLanguage.values) {
      pickerItemsList.add(
        PickerItem(
          LanguageSetting(value).getDisplayName(context),
          null,
          null,
          null,
          value,
          true,
        ),
      );
    }

    return showDialog<AvailableLanguage>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              AppLocalization.of(context)!.language,
              style: AppStyles.textStyleSize24W700EquinoxPrimary(context),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            side: BorderSide(
              color: StateContainer.of(context).curTheme.text45!,
            ),
          ),
          content: PickerWidget(
            pickerItems: pickerItemsList,
            selectedIndex: StateContainer.of(context).curLanguage.language.index,
            onSelected: (value) {
              preferences.setLanguage(
                LanguageSetting(value.value as AvailableLanguage),
              );
              if (StateContainer.of(context).curLanguage.language != value.value) {
                StateContainer.of(context).updateLanguage(
                  LanguageSetting(value.value as AvailableLanguage),
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
