/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:math';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/available_themes.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/util/preferences.dart';
// Flutter imports:
import 'package:flutter/material.dart';

class ThemeDialog {
  static Future<ThemeSetting?> getDialog(
    BuildContext context,
    ThemeSetting curThemeSetting,
  ) async {
    final preferences = await Preferences.getInstance();
    final pickerItemsList = List<PickerItem>.empty(growable: true);
    for (final value in ThemeOptions.values) {
      value == ThemeOptions.flat ||
              value == ThemeOptions.byzantineVioletFlat ||
              value == ThemeOptions.darkFlat ||
              value == ThemeOptions.emeraldGreenFlat ||
              value == ThemeOptions.honeyOrangeFlat ||
              value == ThemeOptions.navyBlueFlat ||
              value == ThemeOptions.pearlGreyFlat ||
              value == ThemeOptions.fireRedFlat ||
              value == ThemeOptions.sapphireBlueFlat ||
              value == ThemeOptions.seaGreenFlat
          ? pickerItemsList.add(
              PickerItem(
                ThemeSetting(value).getDisplayName(context),
                null,
                null,
                null,
                value,
                true,
                decorationImageItem: DecorationImage(
                  image: AssetImage(
                    ThemeSetting(value).getTheme().background1Small!,
                  ),
                  opacity: 0.5,
                  fit: BoxFit.fitWidth,
                ),
              ),
            )
          : pickerItemsList.add(
              PickerItem(
                ThemeSetting(value).getDisplayName(context),
                null,
                null,
                null,
                value,
                true,
                decorationImageItem: DecorationImage(
                  image: AssetImage(
                    'assets/themes/${value.name}/v0${Random().nextInt(4) + 1}-waves-1100.jpg',
                  ),
                  opacity: 0.5,
                  fit: BoxFit.fitWidth,
                ),
              ),
            );
    }
    return showDialog<ThemeSetting>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        final theme = StateContainer.of(context).curTheme;
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              AppLocalization.of(context)!.themeHeader,
              style: AppStyles.textStyleSize24W700EquinoxPrimary(context),
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
              selectedIndex: curThemeSetting.getIndex(),
              onSelected: (value) async {
                final selectedThemeSettings =
                    ThemeSetting(value.value as ThemeOptions);
                if (curThemeSetting != selectedThemeSettings) {
                  preferences.setTheme(selectedThemeSettings);
                  await StateContainer.of(context)
                      .updateTheme(selectedThemeSettings);
                }
                Navigator.pop(context, selectedThemeSettings);
              },
            ),
          ),
        );
      },
    );
  }
}
