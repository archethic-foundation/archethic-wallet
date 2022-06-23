/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/picker_item.dart';
import 'package:aeuniverse/util/preferences.dart';
import 'package:core/localization.dart';
import 'package:core/model/device_lock_timeout.dart';
import 'package:flutter/material.dart';

class LockTimeoutDialog {
  static Future<LockTimeoutSetting?> getDialog(
      BuildContext context, LockTimeoutSetting curTimeoutSetting) async {
    final Preferences preferences = await Preferences.getInstance();
    final List<PickerItem> pickerItemsList =
        List<PickerItem>.empty(growable: true);
    for (var value in LockTimeoutOption.values) {
      pickerItemsList.add(PickerItem(
          LockTimeoutSetting(value).getDisplayName(context),
          null,
          null,
          null,
          value,
          true));
    }
    return await showDialog<LockTimeoutSetting>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                AppLocalization.of(context)!.autoLockHeader,
                style: AppStyles.textStyleSize24W700EquinoxPrimary(context),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                side: BorderSide(
                    color: StateContainer.of(context).curTheme.text45!)),
            content: SingleChildScrollView(
              child: PickerWidget(
                pickerItems: pickerItemsList,
                selectedIndex: curTimeoutSetting.setting.index,
                onSelected: (value) {
                  if (curTimeoutSetting.setting !=
                      value.value as LockTimeoutOption) {
                    preferences.setLockTimeout(
                        LockTimeoutSetting(value.value as LockTimeoutOption));
                    curTimeoutSetting =
                        LockTimeoutSetting(value.value as LockTimeoutOption);
                  }
                  Navigator.pop(context, curTimeoutSetting);
                },
              ),
            ),
          );
        });
  }
}
