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
    final nftCreation = ref.read(
      NftCreationFormProvider.nftCreationForm(
        ref.read(
          NftCreationFormProvider.nftCreationFormArgs,
        ),
      ),
    );
    nftPropertyValueFocusNode = FocusNode();
    nftPropertyValueController =
        TextEditingController(text: nftCreation.propertyValue);
    super.initState();
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
    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm(
        ref.read(
          NftCreationFormProvider.nftCreationFormArgs,
        ),
      ).notifier,
    );

    ref.listen<NftCreationFormState>(
      NftCreationFormProvider.nftCreationForm(
        ref.read(
          NftCreationFormProvider.nftCreationFormArgs,
        ),
      ),
      (_, nftCreation) {
        if (nftCreation.propertyValue != nftPropertyValueController.text) {
          nftPropertyValueController.text = nftCreation.propertyValue;
        }
      },
    );

    return AppTextField(
      key: const Key('nftValue'),
      focusNode: nftPropertyValueFocusNode,
      controller: nftPropertyValueController,
      cursorColor: theme.text,
      textInputAction: TextInputAction.next,
      labelText: AppLocalizations.of(context)!.nftPropertyValueHint,
      autocorrect: false,
      keyboardType: TextInputType.text,
      style: theme.textStyleSize16W600Primary,
      inputFormatters: <LengthLimitingTextInputFormatter>[
        LengthLimitingTextInputFormatter(20),
      ],
      onChanged: (text) {
        nftCreationNotifier.setPropertyValue(
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
                final scanResult = await UserDataUtil.getQRData(
                  DataType.raw,
                  context,
                  ref,
                );
                if (scanResult == null) {
                  UIUtil.showSnackbar(
                    AppLocalizations.of(context)!.qrInvalidAddress,
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
                  nftCreationNotifier.setPropertyValue(
                    scanResult,
                  );
                }
              },
            )
          : null,
    );
  }
}
