/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/setting_item.dart';
import 'package:flutter/material.dart';

enum LockTimeoutOption { zero, one, five, fifteen, thirty, sixty }

/// Represent auto-lock delay when requiring auth to open
class LockTimeoutSetting extends SettingSelectionItem {
  LockTimeoutSetting(this.setting);

  LockTimeoutOption setting;

  @override
  String getDisplayName(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    switch (setting) {
      case LockTimeoutOption.zero:
        return localizations.instantly;
      case LockTimeoutOption.one:
        return localizations.xMinute.replaceAll('%1', '1');
      case LockTimeoutOption.five:
        return localizations.xMinutes.replaceAll('%1', '5');
      case LockTimeoutOption.fifteen:
        return localizations.xMinutes.replaceAll('%1', '15');
      case LockTimeoutOption.thirty:
        return localizations.xMinutes.replaceAll('%1', '30');
      case LockTimeoutOption.sixty:
        return localizations.xMinutes.replaceAll('%1', '60');
    }
  }

  Duration getDuration() {
    switch (setting) {
      case LockTimeoutOption.zero:
        return const Duration(seconds: 3);
      case LockTimeoutOption.one:
        return const Duration(minutes: 1);
      case LockTimeoutOption.five:
        return const Duration(minutes: 5);
      case LockTimeoutOption.fifteen:
        return const Duration(minutes: 15);
      case LockTimeoutOption.thirty:
        return const Duration(minutes: 30);
      case LockTimeoutOption.sixty:
        return const Duration(minutes: 1);
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return setting.index;
  }
}
