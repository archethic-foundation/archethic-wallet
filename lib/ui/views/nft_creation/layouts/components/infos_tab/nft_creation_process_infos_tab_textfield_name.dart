/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../../nft_creation_process_sheet.dart';

class NFTCreationProcessInfosTabTextFieldName extends ConsumerStatefulWidget {
  const NFTCreationProcessInfosTabTextFieldName({
    super.key,
  });

  @override
  ConsumerState<NFTCreationProcessInfosTabTextFieldName> createState() =>
      _NFTCreationProcessInfosTabTextFieldNameState();
}

class _NFTCreationProcessInfosTabTextFieldNameState
    extends ConsumerState<NFTCreationProcessInfosTabTextFieldName> {
  late FocusNode nftNameFocusNode;
  late TextEditingController nftNameController;

  @override
  void initState() {
    super.initState();
    nftNameFocusNode = FocusNode();
    nftNameController = TextEditingController();
  }

  @override
  void dispose() {
    nftNameFocusNode.dispose();
    nftNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm(
        ref.read(
          NftCreationFormProvider.nftCreationFormArgs,
        ),
      ).notifier,
    );
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);

    ref.listen<NftCreationFormState>(
      NftCreationFormProvider.nftCreationForm(
        ref.read(
          NftCreationFormProvider.nftCreationFormArgs,
        ),
      ),
      (_, nftCreation) {
        if (nftCreation.name != nftNameController.text) {
          nftNameController.text = nftCreation.name;
        }
      },
    );

    return AppTextField(
      key: const Key('nftCreationField'),
      focusNode: nftNameFocusNode,
      controller: nftNameController,
      cursorColor: theme.text,
      textInputAction: TextInputAction.done,
      labelText: AppLocalizations.of(context)!.nftNameHint,
      autocorrect: false,
      keyboardType: TextInputType.text,
      style: theme.textStyleSize16W600Primary,
      inputFormatters: <LengthLimitingTextInputFormatter>[
        LengthLimitingTextInputFormatter(40),
      ],
      onChanged: (text) {
        nftCreationNotifier.setName(text);
      },
      suffixButton: hasQRCode
          ? TextFieldButton(
              icon: Symbols.qr_code_scanner,
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
                  nftNameController.text = scanResult;
                }
              },
            )
          : null,
    );
  }
}
