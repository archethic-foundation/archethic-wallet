/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../../nft_creation_process_sheet.dart';

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
    super.initState();
    final nftCreation = ref.read(
      NftCreationFormProvider.nftCreationForm(
        ref.read(
          NftCreationFormProvider.nftCreationFormArgs,
        ),
      ),
    );
    nftPropertyNameFocusNode = FocusNode();
    nftPropertyNameController =
        TextEditingController(text: nftCreation.propertyName);
  }

  @override
  void dispose() {
    nftPropertyNameFocusNode.dispose();
    nftPropertyNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
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
        if (nftCreation.propertyName != nftPropertyNameController.text) {
          nftPropertyNameController.text = nftCreation.propertyName;
        }
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            AppLocalizations.of(context)!.nftPropertyNameHint,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              width: 0.5,
                            ),
                            gradient:
                                WalletThemeBase.gradientInputFormBackground,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              key: const Key('nftName'),
                              style: TextStyle(
                                fontFamily: WalletThemeBase.mainFont,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              autocorrect: false,
                              controller: nftPropertyNameController,
                              onChanged: (text) async {
                                nftCreationNotifier.setPropertyName(
                                  text,
                                );
                              },
                              focusNode: nftPropertyNameFocusNode,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(60),
                              ],
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (hasQRCode)
                        TextFieldButton(
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
                            } else if (QRScanErrs.errorList
                                .contains(scanResult)) {
                              UIUtil.showSnackbar(
                                scanResult,
                                context,
                                ref,
                                theme.text!,
                                theme.snackBarShadow!,
                              );
                              return;
                            } else {
                              nftCreationNotifier.setPropertyName(
                                scanResult,
                              );
                            }
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 200))
        .scale(duration: const Duration(milliseconds: 200));
  }
}
