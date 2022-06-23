/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/picker_item.dart';
import 'package:aeuniverse/util/preferences.dart';
import 'package:core/localization.dart';
import 'package:core/model/device_unlock_option.dart';
import 'package:flutter/material.dart';

class LockDialog {
  static Future<UnlockSetting?> getDialog(
      BuildContext context, UnlockSetting curUnlockSetting) async {
    final Preferences preferences = await Preferences.getInstance();
    final List<PickerItem> pickerItemsList =
        List<PickerItem>.empty(growable: true);
    for (var value in UnlockOption.values) {
      pickerItemsList.add(PickerItem(
          UnlockSetting(value).getDisplayName(context),
          null,
          null,
          null,
          value,
          true));
    }
    return await showDialog<UnlockSetting>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              AppLocalization.of(context)!.lockAppSetting,
              style: AppStyles.textStyleSize20W700EquinoxPrimary(context),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                side: BorderSide(
                    color: StateContainer.of(context).curTheme.text45!)),
            content: SingleChildScrollView(
              child: PickerWidget(
                pickerItems: pickerItemsList,
                selectedIndex: curUnlockSetting.setting.index,
                onSelected: (value) {
                  switch (value.value) {
                    case UnlockOption.yes:
                      preferences.setLock(true);
                      curUnlockSetting = UnlockSetting(UnlockOption.yes);
                      break;
                    case UnlockOption.no:
                      preferences.setLock(false);
                      curUnlockSetting = UnlockSetting(UnlockOption.no);
                      break;
                  }

                  Navigator.pop(context, curUnlockSetting);
                },
              ),
            ),
          );
        });
  }
}
