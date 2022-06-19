/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:aeuniverse/ui/themes/theme_blue.dart';
import 'package:aeuniverse/ui/themes/theme_emerald_green.dart';
import 'package:aeuniverse/ui/themes/theme_green.dart';
import 'package:aeuniverse/ui/themes/theme_orange.dart';
import 'package:aeuniverse/ui/themes/theme_red.dart';
import 'package:aeuniverse/ui/themes/theme_red_fire.dart';
import 'package:aeuniverse/ui/themes/theme_white.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/model/setting_item.dart';
import 'package:core_ui/ui/themes/themes.dart';

// Project imports:
import 'package:aeuniverse/ui/themes/theme_dark.dart';

enum ThemeOptions {
  blue,
  dark,
  emerald_green,
  green,
  navy_blue,
  orange,
  red,
  red_fire,
  white
}

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
      case ThemeOptions.blue:
        return 'Blue';
      case ThemeOptions.emerald_green:
        return 'Emerald green';
      case ThemeOptions.green:
        return 'Green';
      case ThemeOptions.navy_blue:
        return 'Navy Blue';
      case ThemeOptions.red:
        return 'Red';
      case ThemeOptions.red_fire:
        return 'Red Fire';
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
      case ThemeOptions.blue:
        return BlueTheme();
      case ThemeOptions.emerald_green:
        return EmeraldGreenTheme();
      case ThemeOptions.green:
        return GreenTheme();
      case ThemeOptions.red:
        return RedTheme();
      case ThemeOptions.red_fire:
        return RedFireTheme();
      default:
        return DarkTheme();
    }
  }

  String getIcon() {
    switch (theme) {
      default:
        return 'packages/core_ui/assets/themes/dark/logo_alone.png';
    }
  }

  int getIndex() {
    return theme.index;
  }
}
