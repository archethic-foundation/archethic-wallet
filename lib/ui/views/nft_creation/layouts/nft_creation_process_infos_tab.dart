/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'nft_creation_process.dart';

class NFTCreationProcessInfosTab extends ConsumerWidget {
  const NFTCreationProcessInfosTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);

    final nftNameFocusNode = FocusNode();
    final nftDescriptionFocusNode = FocusNode();
    final nftNameController = TextEditingController();
    final nftDescriptionController = TextEditingController();

    final nftCreationNotifier =
        ref.watch(NftCreationProvider.nftCreation.notifier);
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);

    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              localizations.nftInfosDescription,
              style: theme.textStyleSize12W100Primary,
              textAlign: TextAlign.justify,
            ),
          ),
          AppTextField(
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
          ),
          const SizedBox(
            height: 30,
          ),
          AppTextField(
            focusNode: nftDescriptionFocusNode,
            controller: nftDescriptionController,
            cursorColor: theme.text,
            textInputAction: TextInputAction.next,
            labelText: AppLocalization.of(context)!.nftDescriptionHint,
            autocorrect: false,
            keyboardType: TextInputType.text,
            style: theme.textStyleSize16W600Primary,
            inputFormatters: <LengthLimitingTextInputFormatter>[
              LengthLimitingTextInputFormatter(40),
            ],
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
                        nftDescriptionController.text = scanResult;
                      }
                    },
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
