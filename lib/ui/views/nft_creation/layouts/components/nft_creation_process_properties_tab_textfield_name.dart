/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

class NFTCreationProcessPropertiesTabTextfieldName
    extends ConsumerStatefulWidget {
  const NFTCreationProcessPropertiesTabTextfieldName({
    super.key,
  });

  @override
  ConsumerState<NFTCreationProcessPropertiesTabTextfieldName> createState() =>
      _NFTCreationProcessPropertiesTabTextfieldNameState();
}

class _NFTCreationProcessPropertiesTabTextfieldNameState
    extends ConsumerState<NFTCreationProcessPropertiesTabTextfieldName> {
  late FocusNode nftPropertyNameFocusNode;
  late TextEditingController nftPropertyNameController;

  @override
  void initState() {
    final nftCreation = ref.read(NftCreationFormProvider.nftCreationForm);
    nftPropertyNameFocusNode = FocusNode();
    nftPropertyNameController =
        TextEditingController(text: nftCreation.propertyName);

    super.initState();
  }

  @override
  void dispose() {
    nftPropertyNameFocusNode.dispose();
    nftPropertyNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);
    final nftCreationNotifier =
        ref.watch(NftCreationFormProvider.nftCreationForm.notifier);

    return AppTextField(
      focusNode: nftPropertyNameFocusNode,
      controller: nftPropertyNameController,
      cursorColor: theme.text,
      textInputAction: TextInputAction.next,
      labelText: AppLocalization.of(context)!.nftPropertyNameHint,
      autocorrect: false,
      keyboardType: TextInputType.text,
      style: theme.textStyleSize16W600Primary,
      inputFormatters: <LengthLimitingTextInputFormatter>[
        LengthLimitingTextInputFormatter(20),
      ],
      onChanged: (text) {
        nftCreationNotifier.setPropertyName(
          text,
        );
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
                  nftPropertyNameController.text = scanResult;
                }
              },
            )
          : null,
    );
  }
}
