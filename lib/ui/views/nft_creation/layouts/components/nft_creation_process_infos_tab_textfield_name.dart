/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

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
    final nftCreationNotifier =
        ref.watch(NftCreationFormProvider.nftCreationForm(
      ref.read(
        NftCreationFormProvider.nftCreationFormArgs,
      ),
    ).notifier,);
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);

    return AppTextField(
      focusNode: nftNameFocusNode,
      controller: nftNameController,
      cursorColor: theme.text,
      textInputAction: TextInputAction.next,
      labelText: AppLocalization.of(context)!.nftNameHint,
      autocorrect: false,
      keyboardType: TextInputType.text,
      style: theme.textStyleSize16W600Primary,
      inputFormatters: <LengthLimitingTextInputFormatter>[
        LengthLimitingTextInputFormatter(30),
      ],
      onChanged: (text) {
        nftCreationNotifier.setName(text);
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
                  nftNameController.text = scanResult;
                }
              },
            )
          : null,
    );
  }
}
