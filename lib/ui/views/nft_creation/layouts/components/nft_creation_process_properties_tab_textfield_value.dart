/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

class NFTCreationProcessPropertiesTabTextfieldValue
    extends ConsumerStatefulWidget {
  const NFTCreationProcessPropertiesTabTextfieldValue({
    super.key,
  });

  @override
  ConsumerState<NFTCreationProcessPropertiesTabTextfieldValue> createState() =>
      _NFTCreationProcessPropertiesTabTextfieldValueState();
}

class _NFTCreationProcessPropertiesTabTextfieldValueState
    extends ConsumerState<NFTCreationProcessPropertiesTabTextfieldValue> {
  late FocusNode nftPropertyValueFocusNode;
  late TextEditingController nftPropertyValueController;

  @override
  void initState() {
    super.initState();
    nftPropertyValueFocusNode = FocusNode();
    nftPropertyValueController = TextEditingController();
  }

  @override
  void dispose() {
    nftPropertyValueFocusNode.dispose();
    nftPropertyValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);

    return AppTextField(
      focusNode: nftPropertyValueFocusNode,
      controller: nftPropertyValueController,
      cursorColor: theme.text,
      textInputAction: TextInputAction.next,
      labelText: AppLocalization.of(context)!.nftPropertyValueHint,
      autocorrect: false,
      keyboardType: TextInputType.text,
      style: theme.textStyleSize16W600Primary,
      inputFormatters: <LengthLimitingTextInputFormatter>[
        LengthLimitingTextInputFormatter(20),
      ],
      onChanged: (text) {
        /*    nftCreationNotifier.canAddProperty(
                  nftPropertyNameController.text,
                  text,
                );*/
      },
      suffixButton: hasQRCode
          ? TextFieldButton(
              icon: FontAwesomeIcons.qrcode,
              onPressed: () async {
                sl.get<HapticUtil>().feedback(
                      FeedbackType.light,
                      preferences.activeVibrations,
                    );
                UIUtil.cancelLockEvent();
                final scanResult = await UserDataUtil.getQRData(
                  DataType.raw,
                  context,
                  ref,
                );
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
                  nftPropertyValueController.text = scanResult;
                }
              },
            )
          : null,
    );
  }
}
