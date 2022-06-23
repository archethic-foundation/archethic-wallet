/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:math';

import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/model/available_themes.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/picker_item.dart';
import 'package:aeuniverse/util/preferences.dart';
import 'package:core/localization.dart';
import 'package:flutter/material.dart';

class ThemeDialog {
  static Future<ThemeSetting?> getDialog(
      BuildContext context, ThemeSetting curThemeSetting) async {
    final Preferences preferences = await Preferences.getInstance();
    final List<PickerItem> pickerItemsList =
        List<PickerItem>.empty(growable: true);
    for (var value in ThemeOptions.values) {
      pickerItemsList.add(PickerItem(
          ThemeSetting(value).getDisplayName(context),
          null,
          null,
          null,
          value,
          true,
          decorationImageItem: DecorationImage(
              image: AssetImage(
                  'packages/core_ui/assets/themes/${value.name}/v0${Random().nextInt(4) + 1}-waves-1100.jpg'),
              opacity: 0.5,
              fit: BoxFit.fitWidth)));
    }
    return await showDialog<ThemeSetting>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                AppLocalization.of(context)!.themeHeader,
                style: AppStyles.textStyleSize24W700EquinoxPrimary(context),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                side: BorderSide(
                    color: StateContainer.of(context).curTheme.text45!)),
            content: PickerWidget(
              pickerItems: pickerItemsList,
              selectedIndex: curThemeSetting.getIndex(),
              onSelected: (value) {
                if (curThemeSetting !=
                    ThemeSetting(value.value as ThemeOptions)) {
                  preferences
                      .setTheme(ThemeSetting(value.value as ThemeOptions));
                  StateContainer.of(context)
                      .updateTheme(ThemeSetting(value.value as ThemeOptions));
                  curThemeSetting = ThemeSetting(value.value as ThemeOptions);
                }
                Navigator.pop(context, curThemeSetting);
              },
            ),
          );
        });
  }
}
