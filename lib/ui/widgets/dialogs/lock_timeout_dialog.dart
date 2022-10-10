/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/device_lock_timeout.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LockTimeoutDialog {
  static Future<LockTimeoutSetting> _updateLockTimeout(
    LockTimeoutSetting timeoutSettings,
    LockTimeoutOption lockTimeoutOption,
  ) async {
    final preferences = await Preferences.getInstance();

    if (timeoutSettings.setting != lockTimeoutOption) {
      await preferences.setLockTimeout(
        LockTimeoutSetting(lockTimeoutOption),
      );
      return LockTimeoutSetting(lockTimeoutOption);
    }

    return timeoutSettings;
  }

  static Future<LockTimeoutSetting?> getDialog(
    BuildContext context,
    WidgetRef ref,
    LockTimeoutSetting curTimeoutSetting,
  ) async {
    final pickerItemsList = List<PickerItem>.empty(growable: true);
    for (final value in LockTimeoutOption.values) {
      pickerItemsList.add(
        PickerItem(
          LockTimeoutSetting(value).getDisplayName(context),
          null,
          null,
          null,
          value,
          true,
        ),
      );
    }
    return showDialog<LockTimeoutSetting>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        final theme = ref.read(ThemeProviders.theme);
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              AppLocalization.of(context)!.autoLockHeader,
              style: theme.textStyleSize24W700EquinoxPrimary,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            side: BorderSide(
              color: theme.text45!,
            ),
          ),
          content: SingleChildScrollView(
            child: PickerWidget(
              pickerItems: pickerItemsList,
              selectedIndex: curTimeoutSetting.setting.index,
              onSelected: (value) async {
                final updatedSettings = await _updateLockTimeout(
                  curTimeoutSetting,
                  value.value as LockTimeoutOption,
                );
                Navigator.pop(context, updatedSettings);
              },
            ),
          ),
        );
      },
    );
  }
}
