// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/model/setting_item.dart';

enum LockTimeoutOption { zero, one, five, fifteen, thirty, sixty }

/// Represent auto-lock delay when requiring auth to open
class LockTimeoutSetting extends SettingSelectionItem {
  LockTimeoutSetting(this.setting);

  LockTimeoutOption setting;

  @override
  String getDisplayName(BuildContext context) {
    switch (setting) {
      case LockTimeoutOption.zero:
        return AppLocalization.of(context)!.instantly;
      case LockTimeoutOption.one:
        return AppLocalization.of(context)!.xMinute.replaceAll('%1', '1');
      case LockTimeoutOption.five:
        return AppLocalization.of(context)!.xMinutes.replaceAll('%1', '5');
      case LockTimeoutOption.fifteen:
        return AppLocalization.of(context)!.xMinutes.replaceAll('%1', '15');
      case LockTimeoutOption.thirty:
        return AppLocalization.of(context)!.xMinutes.replaceAll('%1', '30');
      case LockTimeoutOption.sixty:
        return AppLocalization.of(context)!.xMinutes.replaceAll('%1', '60');
      default:
        return AppLocalization.of(context)!.xMinute.replaceAll('%1', '1');
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
      default:
        return const Duration(minutes: 1);
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return setting.index;
  }
}
