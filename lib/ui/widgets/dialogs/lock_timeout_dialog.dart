/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/device_lock_timeout.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/util/preferences.dart';

class LockTimeoutDialog {
  static Future<LockTimeoutSetting> _updateLockTimeout(
    LockTimeoutSetting timeoutSettings,
    LockTimeoutOption lockTimeoutOption,
  ) async {
    final Preferences preferences = await Preferences.getInstance();

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
    LockTimeoutSetting curTimeoutSetting,
  ) async {
    final List<PickerItem> pickerItemsList =
        List<PickerItem>.empty(growable: true);
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
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              AppLocalization.of(context)!.autoLockHeader,
              style: AppStyles.textStyleSize24W700EquinoxPrimary(context),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            side: BorderSide(
              color: StateContainer.of(context).curTheme.text45!,
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
