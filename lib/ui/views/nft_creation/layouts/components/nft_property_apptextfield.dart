/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/device_abilities.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/util/user_data_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

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
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);
    return AppTextField(
      focusNode: focusNode,
      controller: textEditingController,
      cursorColor: ArchethicTheme.text,
      textInputAction: TextInputAction.next,
      labelText: hint,
      autocorrect: false,
      keyboardType: TextInputType.text,
      style: ArchethicThemeStyles.textStyleSize16W600Primary,
      inputFormatters: <LengthLimitingTextInputFormatter>[
        LengthLimitingTextInputFormatter(30),
      ],
      suffixButton: hasQRCode
          ? TextFieldButton(
              icon: Symbols.qr_code_scanner,
              onPressed: () async {
                final scanResult =
                    await UserDataUtil.getQRData(DataType.raw, context, ref);
                if (scanResult == null) {
                  UIUtil.showSnackbar(
                    AppLocalizations.of(context)!.qrInvalidAddress,
                    context,
                    ref,
                    ArchethicTheme.text,
                    ArchethicTheme.snackBarShadow,
                  );
                } else if (QRScanErrs.errorList.contains(scanResult)) {
                  UIUtil.showSnackbar(
                    scanResult,
                    context,
                    ref,
                    ArchethicTheme.text,
                    ArchethicTheme.snackBarShadow,
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
