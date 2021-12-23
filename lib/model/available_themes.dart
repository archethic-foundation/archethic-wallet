// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:archethic_mobile_wallet/model/setting_item.dart';
import 'package:archethic_mobile_wallet/ui/themes/theme_archethic.dart';
import 'package:archethic_mobile_wallet/ui/themes/theme_uniris.dart';
import 'package:archethic_mobile_wallet/ui/themes/themes.dart';

enum ThemeOptions { UNIRIS, ARCHETHIC }

/// Represent notification on/off setting
class ThemeSetting extends SettingSelectionItem {
  ThemeOptions theme;

  ThemeSetting(this.theme);

  String getDisplayName(BuildContext context) {
    switch (theme) {
      case ThemeOptions.UNIRIS:
        return "Uniris";
      case ThemeOptions.ARCHETHIC:
        return "Archethic";
      default:
        return "Uniris";
    }
  }

  BaseTheme getTheme() {
    switch (theme) {
      case ThemeOptions.UNIRIS:
        return UnirisTheme();
      case ThemeOptions.ARCHETHIC:
        return ArchEthicTheme();
      default:
        return UnirisTheme();
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return theme.index;
  }
}
