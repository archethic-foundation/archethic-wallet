/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

class NFTCreationProcessInfosTabTextFieldDescription
    extends ConsumerStatefulWidget {
  const NFTCreationProcessInfosTabTextFieldDescription({
    super.key,
  });

  @override
  ConsumerState<NFTCreationProcessInfosTabTextFieldDescription> createState() =>
      _NFTCreationProcessInfosTabTextFieldDescriptionState();
}

class _NFTCreationProcessInfosTabTextFieldDescriptionState
    extends ConsumerState<NFTCreationProcessInfosTabTextFieldDescription> {
  late FocusNode nftDescriptionFocusNode;
  late TextEditingController nftDescriptionController;

  @override
  void initState() {
    super.initState();
    nftDescriptionFocusNode = FocusNode();
    nftDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    nftDescriptionFocusNode.dispose();
    nftDescriptionController.dispose();
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
        if (nftCreation.description != nftDescriptionController.text) {
          nftDescriptionController.text = nftCreation.description;
        }
      },
    );

    return AppTextField(
      focusNode: nftDescriptionFocusNode,
      controller: nftDescriptionController,
      textInputAction: TextInputAction.next,
      textAlign: TextAlign.start,
      cursorColor: theme.text,
      labelText: AppLocalization.of(context)!.nftDescriptionHint,
      autocorrect: false,
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      style: theme.textStyleSize16W600Primary,
      onChanged: (text) {
        nftCreationNotifier.setDescription(text);
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
                  nftDescriptionController.text = scanResult;
                }
              },
            )
          : null,
    );
  }
}
