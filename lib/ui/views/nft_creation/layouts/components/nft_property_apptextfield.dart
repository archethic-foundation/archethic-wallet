/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:io';

import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/user_data_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NftPropertyAppTextField extends ConsumerWidget {
  const NftPropertyAppTextField({
    required this.focusNode,
    required this.textEditingController,
    required this.hint,
    required this.propertyKey,
    super.key,
  });
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final String hint;
  final String propertyKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(preferenceProvider);

    return AppTextField(
      focusNode: focusNode,
      controller: textEditingController,
      cursorColor: theme.text,
      textInputAction: TextInputAction.next,
      labelText: hint,
      autocorrect: false,
      keyboardType: TextInputType.text,
      style: theme.textStyleSize16W600Primary,
      inputFormatters: <LengthLimitingTextInputFormatter>[
        LengthLimitingTextInputFormatter(30),
      ],
      onChanged: (text) {
        // TODO(reddwarf03): Reactivate
        /* if (text == '') {
          tokenPropertyWithAccessInfosList.removeWhere(
            (element) => element.tokenProperty!.keys.first == propertyKey,
          );
        } else {
          tokenPropertyWithAccessInfosList.removeWhere(
            (element) => element.tokenProperty!.keys.first == propertyKey,
          );
          tokenPropertyWithAccessInfosList.add(
            TokenPropertyWithAccessInfos(
              tokenProperty: {propertyKey: textEditingController.text},
            ),
          );
          tokenPropertyWithAccessInfosList.sort(
            (
              TokenPropertyWithAccessInfos a,
              TokenPropertyWithAccessInfos b,
            ) =>
                a.tokenProperty!.keys.first
                    .toLowerCase()
                    .compareTo(b.tokenProperty!.keys.first.toLowerCase()),
          );
        }*/
      },
      suffixButton: kIsWeb == false && (Platform.isIOS || Platform.isAndroid)
          ? TextFieldButton(
              icon: FontAwesomeIcons.qrcode,
              onPressed: () async {
                sl.get<HapticUtil>().feedback(
                      FeedbackType.light,
                      preferences.activeVibrations,
                    );
                UIUtil.cancelLockEvent();
                final scanResult =
                    await UserDataUtil.getQRData(DataType.raw, context, ref);
                if (scanResult == null) {
                  UIUtil.showSnackbar(
                    AppLocalization.of(context)!.qrInvalidAddress,
                    context,
                    ref,
                    theme.text!,
                    theme.snackBarShadow!,
                  );
                } else if (QRScanErrs.errorList.contains(scanResult)) {
                  UIUtil.showSnackbar(
                    scanResult,
                    context,
                    ref,
                    theme.text!,
                    theme.snackBarShadow!,
                  );
                  return;
                } else {
                  textEditingController.text = scanResult;
                }
              },
            )
          : null,
    );
  }
}
