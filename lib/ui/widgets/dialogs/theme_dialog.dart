/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/available_themes.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/util/preferences.dart';

class ThemeDialog {
  static Future<ThemeSetting?> getDialog(
      BuildContext context, ThemeSetting curThemeSetting) async {
    final Preferences preferences = await Preferences.getInstance();
    final List<PickerItem> pickerItemsList =
        List<PickerItem>.empty(growable: true);
    for (var value in ThemeOptions.values) {
      value == ThemeOptions.flat ||
              value == ThemeOptions.byzantine_violet_flat ||
              value == ThemeOptions.dark_flat ||
              value == ThemeOptions.emerald_green_flat ||
              value == ThemeOptions.honey_orange_flat ||
              value == ThemeOptions.navy_blue_flat ||
              value == ThemeOptions.pearl_grey_flat ||
              value == ThemeOptions.fire_red_flat ||
              value == ThemeOptions.sapphire_blue_flat ||
              value == ThemeOptions.sea_green_flat
          ? pickerItemsList.add(PickerItem(
              ThemeSetting(value).getDisplayName(context), null, null, null, value, true,
              decorationImageItem: DecorationImage(
                  image: AssetImage(
                      ThemeSetting(value).getTheme().background1Small!),
                  opacity: 0.5,
                  fit: BoxFit.fitWidth)))
          : pickerItemsList.add(PickerItem(
              ThemeSetting(value).getDisplayName(context), null, null, null, value, true,
              decorationImageItem: DecorationImage(
                  image: AssetImage('assets/themes/${value.name}/v0${Random().nextInt(4) + 1}-waves-1100.jpg'),
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
            content: SingleChildScrollView(
              child: PickerWidget(
                pickerItems: pickerItemsList,
                selectedIndex: curThemeSetting.getIndex(),
                onSelected: (value) async {
                  if (curThemeSetting !=
                      ThemeSetting(value.value as ThemeOptions)) {
                    preferences
                        .setTheme(ThemeSetting(value.value as ThemeOptions));
                    await StateContainer.of(context)
                        .updateTheme(ThemeSetting(value.value as ThemeOptions));
                    curThemeSetting = ThemeSetting(value.value as ThemeOptions);
                  }
                  Navigator.pop(context, curThemeSetting);
                },
              ),
            ),
          );
        });
  }
}
