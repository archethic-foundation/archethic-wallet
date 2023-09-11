/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/model/setting_item.dart';
import 'package:aewallet/ui/themes/theme_byzantine_violet.dart';
import 'package:aewallet/ui/themes/theme_byzantine_violet_flat.dart';
import 'package:aewallet/ui/themes/theme_dark.dart';
import 'package:aewallet/ui/themes/theme_dark_flat.dart';
import 'package:aewallet/ui/themes/theme_emerald_green.dart';
import 'package:aewallet/ui/themes/theme_emerald_green_flat.dart';
import 'package:aewallet/ui/themes/theme_fire_red.dart';
import 'package:aewallet/ui/themes/theme_fire_red_flat.dart';
import 'package:aewallet/ui/themes/theme_flat.dart';
import 'package:aewallet/ui/themes/theme_honey_orange.dart';
import 'package:aewallet/ui/themes/theme_honey_orange_flat.dart';
import 'package:aewallet/ui/themes/theme_navy_blue.dart';
import 'package:aewallet/ui/themes/theme_navy_blue_flat.dart';
import 'package:aewallet/ui/themes/theme_pearl_grey.dart';
import 'package:aewallet/ui/themes/theme_pearl_grey_flat.dart';
import 'package:aewallet/ui/themes/theme_purple.dart';
import 'package:aewallet/ui/themes/theme_sapphire_blue.dart';
import 'package:aewallet/ui/themes/theme_sapphire_blue_flat.dart';
import 'package:aewallet/ui/themes/theme_sea_green.dart';
import 'package:aewallet/ui/themes/theme_sea_green_flat.dart';
import 'package:aewallet/ui/themes/themes.dart';
import 'package:flutter/material.dart';

enum ThemeOptions {
  byzantineViolet(false),
  byzantineVioletFlat(true),
  dark(false),
  darkFlat(true),
  emeraldGreen(false),
  emeraldGreenFlat(true),
  fireRed(false),
  fireRedFlat(true),
  flat(true),
  honeyOrange(false),
  honeyOrangeFlat(true),
  navyBlue(false),
  navyBlueFlat(true),
  pearlGrey(false),
  pearlGreyFlat(true),
  sapphireBlue(false),
  sapphireBlueFlat(true),
  seaGreen(false),
  seaGreenFlat(true),
  purple(false);

  const ThemeOptions(this.isFlat);
  final bool isFlat;
}

/// Represent notification on/off setting
@immutable
class ThemeSetting extends SettingSelectionItem {
  const ThemeSetting(this.theme);

  final ThemeOptions theme;

  @override
  String getDisplayName(BuildContext context) {
    switch (theme) {
      case ThemeOptions.dark:
        return 'Dark';
      case ThemeOptions.darkFlat:
        return 'Dark Flat';
      case ThemeOptions.byzantineViolet:
        return 'Byzantine Violet';
      case ThemeOptions.emeraldGreen:
        return 'Emerald Green';
      case ThemeOptions.fireRed:
        return 'Fire Red';
      case ThemeOptions.flat:
        return 'Flat';
      case ThemeOptions.honeyOrange:
        return 'Honey Orange';
      case ThemeOptions.navyBlue:
        return 'Navy Blue';
      case ThemeOptions.pearlGrey:
        return 'Pearl Grey';
      case ThemeOptions.sapphireBlue:
        return 'Sapphire Blue';
      case ThemeOptions.seaGreen:
        return 'Sea Green';
      case ThemeOptions.byzantineVioletFlat:
        return 'Byzantine Violet Flat';
      case ThemeOptions.emeraldGreenFlat:
        return 'Emerald Green Flat';
      case ThemeOptions.fireRedFlat:
        return 'Fire Red Flat';
      case ThemeOptions.honeyOrangeFlat:
        return 'Honey Orange Flat';
      case ThemeOptions.navyBlueFlat:
        return 'Navy Blue Flat';
      case ThemeOptions.pearlGreyFlat:
        return 'Pearl Grey Flat';
      case ThemeOptions.sapphireBlueFlat:
        return 'Sapphire Blue Flat';
      case ThemeOptions.seaGreenFlat:
        return 'Sea Green Flat';
      case ThemeOptions.purple:
        return 'Purple';
    }
  }

  BaseTheme getTheme() {
    switch (theme) {
      case ThemeOptions.dark:
        return DarkTheme();
      case ThemeOptions.darkFlat:
        return DarkFlatTheme();
      case ThemeOptions.byzantineViolet:
        return ByzantineVioletTheme();
      case ThemeOptions.emeraldGreen:
        return EmeraldGreenTheme();
      case ThemeOptions.fireRed:
        return FireRedTheme();
      case ThemeOptions.flat:
        return FlatTheme();
      case ThemeOptions.honeyOrange:
        return HoneyOrangeTheme();
      case ThemeOptions.navyBlue:
        return NavyBlueTheme();
      case ThemeOptions.pearlGrey:
        return PearlGreyTheme();
      case ThemeOptions.sapphireBlue:
        return SapphireBlueTheme();
      case ThemeOptions.seaGreen:
        return SeaGreenTheme();
      case ThemeOptions.byzantineVioletFlat:
        return ByzantineVioletFlatTheme();
      case ThemeOptions.emeraldGreenFlat:
        return EmeraldGreenFlatTheme();
      case ThemeOptions.fireRedFlat:
        return FireRedFlatTheme();
      case ThemeOptions.honeyOrangeFlat:
        return HoneyOrangeFlatTheme();
      case ThemeOptions.navyBlueFlat:
        return NavyBlueFlatTheme();
      case ThemeOptions.pearlGreyFlat:
        return PearlGreyFlatTheme();
      case ThemeOptions.sapphireBlueFlat:
        return SapphireBlueFlatTheme();
      case ThemeOptions.seaGreenFlat:
        return SeaGreenFlatTheme();
      case ThemeOptions.purple:
        return PurpleTheme();
    }
  }

  String getIcon() {
    return 'assets/themes/dark/logo_alone.png';
  }

  int getIndex() {
    return theme.index;
  }
}
