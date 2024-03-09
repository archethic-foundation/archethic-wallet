/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/model/device_unlock_option.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LockDialog {
  static Future<UnlockSetting?> getDialog(
    BuildContext context,
    WidgetRef ref,
    UnlockSetting curUnlockSetting,
  ) async {
    final pickerItemsList = List<PickerItem>.empty(growable: true);
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
        return aedappfm.PopupTemplate(
          popupContent: SingleChildScrollView(
            child: PickerWidget(
              pickerItems: pickerItemsList,
              selectedIndexes: [curUnlockSetting.setting.index],
              onSelected: (value) {
                ref
                    .read(AuthenticationProviders.settings.notifier)
                    .setLockApp(value.value as UnlockOption);
                context.pop(UnlockSetting(value.value));
              },
            ),
          ),
          popupTitle: AppLocalizations.of(context)!.lockAppSetting,
        );
      },
    );
  }
}
