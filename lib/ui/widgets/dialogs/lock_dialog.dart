/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/device_unlock_option.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:flutter/material.dart';

class LockDialog {
  static Future<UnlockSetting?> getDialog(
    BuildContext context,
    UnlockSetting curUnlockSetting,
  ) async {
    final preferences = await Preferences.getInstance();
    final pickerItemsList =
        List<PickerItem>.empty(growable: true);
    for (final value in UnlockOption.values) {
      pickerItemsList.add(
        PickerItem(
          UnlockSetting(value).getDisplayName(context),
          null,
          null,
          null,
          value,
          true,
        ),
      );
    }
    return showDialog<UnlockSetting>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalization.of(context)!.lockAppSetting,
            style: AppStyles.textStyleSize20W700EquinoxPrimary(context),
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
              selectedIndex: curUnlockSetting.setting.index,
              onSelected: (value) {
                final pickedOption = value.value as UnlockOption;

                switch (pickedOption) {
                  case UnlockOption.yes:
                    preferences.setLock(true);
                    break;
                  case UnlockOption.no:
                    preferences.setLock(false);
                    break;
                }

                Navigator.pop(
                  context,
                  UnlockSetting(pickedOption),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
