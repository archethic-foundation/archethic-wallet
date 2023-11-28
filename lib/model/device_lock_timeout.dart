/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/model/setting_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

enum LockTimeoutOption {
  zero,
  tenSec,
  thirtySec,
  oneMin,
  fiveMin,
  fifteenMin,
  thirtyMin,
  sixtyMin
}

extension LockTimeoutToDurationExt on LockTimeoutOption {
  Duration get duration {
    switch (this) {
      case LockTimeoutOption.zero:
        return Duration.zero;
      case LockTimeoutOption.tenSec:
        return const Duration(seconds: 10);
      case LockTimeoutOption.thirtySec:
        return const Duration(minutes: 30);
      case LockTimeoutOption.oneMin:
        return const Duration(minutes: 1);
      case LockTimeoutOption.fiveMin:
        return const Duration(minutes: 5);
      case LockTimeoutOption.fifteenMin:
        return const Duration(minutes: 15);
      case LockTimeoutOption.thirtyMin:
        return const Duration(minutes: 30);
      case LockTimeoutOption.sixtyMin:
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
    final localizations = AppLocalizations.of(context)!;
    switch (setting) {
      case LockTimeoutOption.zero:
        return localizations.instantly;
      case LockTimeoutOption.tenSec:
        return localizations.xSecondes.replaceAll('%1', '10');
      case LockTimeoutOption.thirtySec:
        return localizations.xSecondes.replaceAll('%1', '30');
      case LockTimeoutOption.oneMin:
        return localizations.xMinute.replaceAll('%1', '1');
      case LockTimeoutOption.fiveMin:
        return localizations.xMinutes.replaceAll('%1', '5');
      case LockTimeoutOption.fifteenMin:
        return localizations.xMinutes.replaceAll('%1', '15');
      case LockTimeoutOption.thirtyMin:
        return localizations.xMinutes.replaceAll('%1', '30');
      case LockTimeoutOption.sixtyMin:
        return localizations.xMinutes.replaceAll('%1', '60');
    }
  }
}
