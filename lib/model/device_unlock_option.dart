/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/setting_item.dart';
import 'package:flutter/material.dart';

enum UnlockOption { yes, no }

/// Represent authenticate to open setting
class UnlockSetting extends SettingSelectionItem {
  UnlockSetting(this.setting);

  UnlockOption setting;

  @override
  String getDisplayName(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    switch (setting) {
      case UnlockOption.yes:
        return localizations.yes;
      case UnlockOption.no:
        return localizations.no;
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return setting.index;
  }
}
