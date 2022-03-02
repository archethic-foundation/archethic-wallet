// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/model/setting_item.dart';
import 'package:core_ui/ui/themes/themes.dart';
import 'package:dapp_bin/ui/themes/theme_dark.dart';
import 'package:dapp_bin/ui/themes/theme_light.dart';

enum ThemeOptions { dark, light }

/// Represent notification on/off setting
class ThemeSetting extends SettingSelectionItem {
  ThemeSetting(this.theme);

  ThemeOptions theme;

  @override
  String getDisplayName(BuildContext context) {
    switch (theme) {
      case ThemeOptions.light:
        return 'Light';
      case ThemeOptions.dark:
        return 'Dark';
      default:
        return 'Dark';
    }
  }

  BaseTheme getTheme() {
    switch (theme) {
      case ThemeOptions.light:
        return LightTheme();
      case ThemeOptions.dark:
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
