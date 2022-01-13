// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:archethic_wallet/model/setting_item.dart';
import 'package:archethic_wallet/ui/themes/theme_dark.dart';
import 'package:archethic_wallet/ui/themes/theme_light.dart';
import 'package:archethic_wallet/ui/themes/themes.dart';

enum ThemeOptions { DARK, LIGHT }

/// Represent notification on/off setting
class ThemeSetting extends SettingSelectionItem {
  ThemeSetting(this.theme);

  ThemeOptions theme;

  @override
  String getDisplayName(BuildContext context) {
    switch (theme) {
      case ThemeOptions.LIGHT:
        return 'Light';
      case ThemeOptions.DARK:
        return 'Dark';
      default:
        return 'Dark';
    }
  }

  BaseTheme getTheme() {
    switch (theme) {
      case ThemeOptions.LIGHT:
        return LightTheme();
      case ThemeOptions.DARK:
        return DarkTheme();
      default:
        return DarkTheme();
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return theme.index;
  }
}
