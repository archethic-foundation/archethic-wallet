/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/setting_item.dart';
import 'package:flutter/material.dart';

enum LockTimeoutOption { zero, one, five, fifteen, thirty, sixty }

extension LockTimeoutToDurationExt on LockTimeoutOption {
  Duration get duration {
    switch (this) {
      case LockTimeoutOption.zero:
        return Duration.zero;
      case LockTimeoutOption.one:
        return const Duration(minutes: 1);
      case LockTimeoutOption.five:
        return const Duration(minutes: 5);
      case LockTimeoutOption.fifteen:
        return const Duration(minutes: 15);
      case LockTimeoutOption.thirty:
        return const Duration(minutes: 30);
      case LockTimeoutOption.sixty:
        return const Duration(minutes: 60);
    }
  }
}

/// Represent auto-lock delay when requiring auth to open
@immutable
class LockTimeoutSetting extends SettingSelectionItem {
  const LockTimeoutSetting(this.setting);

  final LockTimeoutOption setting;

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
}
