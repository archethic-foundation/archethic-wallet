/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:aeuniverse/ui/themes/theme_byzantine_violet.dart';
import 'package:aeuniverse/ui/themes/theme_sapphire_blue.dart';
import 'package:aeuniverse/ui/themes/theme_emerald_green.dart';
import 'package:aeuniverse/ui/themes/theme_sea_green.dart';
import 'package:aeuniverse/ui/themes/theme_navy_blue.dart';
import 'package:aeuniverse/ui/themes/theme_honey_orange.dart';
import 'package:aeuniverse/ui/themes/theme_fire_red.dart';
import 'package:aeuniverse/ui/themes/theme_pearl_grey.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/model/setting_item.dart';
import 'package:core_ui/ui/themes/themes.dart';

// Project imports:
import 'package:aeuniverse/ui/themes/theme_dark.dart';

enum ThemeOptions {
  sapphire_blue,
  dark,
  emerald_green,
  sea_green,
  navy_blue,
  honey_orange,
  byzantine_violet,
  fire_red,
  pearl_grey
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
      case ThemeOptions.byzantine_violet:
        return 'Byzantine violet';
      case ThemeOptions.emerald_green:
        return 'Emerald green';
      case ThemeOptions.fire_red:
        return 'Fire red';
      case ThemeOptions.honey_orange:
        return 'Honey orange';
      case ThemeOptions.navy_blue:
        return 'Navy Blue';
      case ThemeOptions.pearl_grey:
        return 'Pearl grey';
      case ThemeOptions.sapphire_blue:
        return 'Sapphire blue';
      case ThemeOptions.sea_green:
        return 'Sea green';
      default:
        return 'Dark';
    }
  }

  BaseTheme getTheme() {
    switch (theme) {
      case ThemeOptions.dark:
        return DarkTheme();
      case ThemeOptions.byzantine_violet:
        return ByzantineVioletTheme();
      case ThemeOptions.emerald_green:
        return EmeraldGreenTheme();
      case ThemeOptions.fire_red:
        return FireRedTheme();
      case ThemeOptions.honey_orange:
        return HoneyOrangeTheme();
      case ThemeOptions.navy_blue:
        return NavyBlueTheme();
      case ThemeOptions.pearl_grey:
        return PearlGreyTheme();
      case ThemeOptions.sapphire_blue:
        return SapphireBlueTheme();
      case ThemeOptions.sea_green:
        return SeaGreenTheme();
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
