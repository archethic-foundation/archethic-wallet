/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:math';

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/available_themes.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeDialog {
  static Future<ThemeSetting?> getDialog(
    BuildContext context,
    WidgetRef ref,
    ThemeSetting curThemeSetting,
  ) async {
    final pickerItemsList = ThemeOptions.values
        .map(
          (theme) => ThemePickerItemExt.fromThemeOption(context, theme),
        )
        .toList();

    return showDialog<ThemeSetting>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        final theme = ref.watch(ThemeProviders.selectedTheme);
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              AppLocalizations.of(context)!.themeHeader,
              style: theme.textStyleSize24W700EquinoxPrimary,
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
                final selectedThemeSettings = ThemeSetting(value.value as ThemeOptions);
                if (curThemeSetting != selectedThemeSettings) {
                  ref.read(SettingsProviders.settings.notifier).selectTheme(selectedThemeSettings.theme);
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

extension ThemePickerItemExt on PickerItem {
  static PickerItem fromThemeOption(
    BuildContext context,
    ThemeOptions themeOption,
  ) {
    final themeSetting = ThemeSetting(themeOption);
    // Flat theme
    if (themeOption.toString().toLowerCase().endsWith('flat')) {
      return PickerItem(
        themeSetting.getDisplayName(context),
        null,
        null,
        null,
        themeOption,
        true,
        decorationImageItem: DecorationImage(
          image: AssetImage(
            themeSetting.getTheme().background1Small!,
          ),
          opacity: 0.5,
          fit: BoxFit.fitWidth,
        ),
      );
    }

    return PickerItem(
      themeSetting.getDisplayName(context),
      null,
      null,
      null,
      themeOption,
      true,
      decorationImageItem: DecorationImage(
        image: AssetImage(
          '${themeSetting.getTheme().assetsFolder}v0${Random().nextInt(4) + 1}-waves.jpg',
        ),
        opacity: 0.5,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
