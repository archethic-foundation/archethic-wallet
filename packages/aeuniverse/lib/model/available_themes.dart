/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:aeuniverse/ui/themes/theme_orange.dart';
import 'package:aeuniverse/ui/themes/theme_white.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/model/setting_item.dart';
import 'package:core_ui/ui/themes/themes.dart';

// Project imports:
import 'package:aeuniverse/ui/themes/theme_dark.dart';

enum ThemeOptions { dark, white, orange }

/// Represent notification on/off setting
class ThemeSetting extends SettingSelectionItem {
  ThemeSetting(this.theme);

  ThemeOptions theme;

  @override
  String getDisplayName(BuildContext context) {
    switch (theme) {
      case ThemeOptions.dark:
        return 'Dark';
      case ThemeOptions.white:
        return 'White';
      case ThemeOptions.orange:
        return 'Orange';
      default:
        return 'Dark';
    }
  }

  BaseTheme getTheme() {
    switch (theme) {
      case ThemeOptions.dark:
        return DarkTheme();
      case ThemeOptions.white:
        return WhiteTheme();
      case ThemeOptions.orange:
        return OrangeTheme();
      default:
        return DarkTheme();
    }
  }

  String getLabel(BuildContext context) {
    switch (theme) {
      case ThemeOptions.dark:
        return 'A beautiful theme from Archethic eco-system';
      default:
        return 'A beautiful theme from Archethic eco-system';
    }
  }

  String getIcon() {
    switch (theme) {
      case ThemeOptions.dark:
        return 'packages/core_ui/assets/themes/dark/logo_alone.png';
      default:
        return 'packages/core_ui/assets/themes/dark/logo_alone.png';
    }
  }

  int getIndex() {
    return theme.index;
  }
}
