/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aewallet/model/setting_item.dart';
import 'package:aewallet/ui/themes/theme_byzantine_violet.dart';
import 'package:aewallet/ui/themes/theme_dark.dart';
import 'package:aewallet/ui/themes/theme_emerald_green.dart';
import 'package:aewallet/ui/themes/theme_fire_red.dart';
import 'package:aewallet/ui/themes/theme_honey_orange.dart';
import 'package:aewallet/ui/themes/theme_navy_blue.dart';
import 'package:aewallet/ui/themes/theme_pearl_grey.dart';
import 'package:aewallet/ui/themes/theme_sapphire_blue.dart';
import 'package:aewallet/ui/themes/theme_sea_green.dart';
import 'package:aewallet/ui/themes/themes.dart';

enum ThemeOptions {
  byzantine_violet,
  dark,
  emerald_green,
  fire_red,
  honey_orange,
  navy_blue,
  pearl_grey,
  sapphire_blue,
  sea_green,
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
        return 'assets/themes/dark/logo_alone.png';
    }
  }

  int getIndex() {
    return theme.index;
  }
}
