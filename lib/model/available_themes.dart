/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:aewallet/ui/themes/theme_byzantine_violet_flat.dart';
import 'package:aewallet/ui/themes/theme_dark_flat.dart';
import 'package:aewallet/ui/themes/theme_emerald_green_flat.dart';
import 'package:aewallet/ui/themes/theme_fire_red_flat.dart';
import 'package:aewallet/ui/themes/theme_honey_orange_flat.dart';
import 'package:aewallet/ui/themes/theme_navy_blue_flat.dart';
import 'package:aewallet/ui/themes/theme_pearl_grey_flat.dart';
import 'package:aewallet/ui/themes/theme_sapphire_blue_flat.dart';
import 'package:aewallet/ui/themes/theme_sea_green_flat.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:aewallet/model/setting_item.dart';
import 'package:aewallet/ui/themes/theme_byzantine_violet.dart';
import 'package:aewallet/ui/themes/theme_dark.dart';
import 'package:aewallet/ui/themes/theme_emerald_green.dart';
import 'package:aewallet/ui/themes/theme_fire_red.dart';
import 'package:aewallet/ui/themes/theme_flat.dart';
import 'package:aewallet/ui/themes/theme_honey_orange.dart';
import 'package:aewallet/ui/themes/theme_navy_blue.dart';
import 'package:aewallet/ui/themes/theme_pearl_grey.dart';
import 'package:aewallet/ui/themes/theme_sapphire_blue.dart';
import 'package:aewallet/ui/themes/theme_sea_green.dart';
import 'package:aewallet/ui/themes/themes.dart';

enum ThemeOptions {
  byzantine_violet,
  byzantine_violet_flat,
  dark,
  dark_flat,
  emerald_green,
  emerald_green_flat,
  fire_red,
  fire_red_flat,
  flat,
  honey_orange,
  honey_orange_flat,
  navy_blue,
  navy_blue_flat,
  pearl_grey,
  pearl_grey_flat,
  sapphire_blue,
  sapphire_blue_flat,
  sea_green,
  sea_green_flat,
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
      case ThemeOptions.dark_flat:
        return 'Dark Flat';
      case ThemeOptions.byzantine_violet:
        return 'Byzantine Violet';
      case ThemeOptions.emerald_green:
        return 'Emerald Green';
      case ThemeOptions.fire_red:
        return 'Fire Red';
      case ThemeOptions.flat:
        return 'Flat';
      case ThemeOptions.honey_orange:
        return 'Honey Orange';
      case ThemeOptions.navy_blue:
        return 'Navy Blue';
      case ThemeOptions.pearl_grey:
        return 'Pearl Grey';
      case ThemeOptions.sapphire_blue:
        return 'Sapphire Blue';
      case ThemeOptions.sea_green:
        return 'Sea Green';
      case ThemeOptions.byzantine_violet_flat:
        return 'Byzantine Violet Flat';
      case ThemeOptions.emerald_green_flat:
        return 'Emerald Green Flat';
      case ThemeOptions.fire_red_flat:
        return 'Fire Red Flat';
      case ThemeOptions.honey_orange_flat:
        return 'Honey Orange Flat';
      case ThemeOptions.navy_blue_flat:
        return 'Navy Blue Flat';
      case ThemeOptions.pearl_grey_flat:
        return 'Pearl Grey Flat';
      case ThemeOptions.sapphire_blue_flat:
        return 'Sapphire Blue Flat';
      case ThemeOptions.sea_green_flat:
        return 'Sea Green Flat';
      default:
        return 'Dark';
    }
  }

  BaseTheme getTheme() {
    switch (theme) {
      case ThemeOptions.dark:
        return DarkTheme();
      case ThemeOptions.dark_flat:
        return DarkFlatTheme();
      case ThemeOptions.byzantine_violet:
        return ByzantineVioletTheme();
      case ThemeOptions.emerald_green:
        return EmeraldGreenTheme();
      case ThemeOptions.fire_red:
        return FireRedTheme();
      case ThemeOptions.flat:
        return FlatTheme();
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
      case ThemeOptions.byzantine_violet_flat:
        return ByzantineVioletFlatTheme();
      case ThemeOptions.emerald_green_flat:
        return EmeraldGreenFlatTheme();
      case ThemeOptions.fire_red_flat:
        return FireRedFlatTheme();
      case ThemeOptions.honey_orange_flat:
        return HoneyOrangeFlatTheme();
      case ThemeOptions.navy_blue_flat:
        return NavyBlueFlatTheme();
      case ThemeOptions.pearl_grey_flat:
        return PearlGreyFlatTheme();
      case ThemeOptions.sapphire_blue_flat:
        return SapphireBlueFlatTheme();
      case ThemeOptions.sea_green_flat:
        return SeaGreenFlatTheme();
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
