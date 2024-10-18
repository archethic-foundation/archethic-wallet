/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../../nft_creation_process_sheet.dart';

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
    final nftCreation = ref.read(
      NftCreationFormProvider.nftCreationForm,
    );
    nftPropertyValueFocusNode = FocusNode();
    nftPropertyValueController =
        TextEditingController(text: nftCreation.propertyValue);
  }

  @override
  void dispose() {
    nftPropertyValueFocusNode.dispose();
    nftPropertyValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);
    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm.notifier,
    );

    ref.listen<NftCreationFormState>(
      NftCreationFormProvider.nftCreationForm,
      (_, nftCreation) {
        if (nftCreation.propertyValue != nftPropertyValueController.text) {
          nftPropertyValueController.text = nftCreation.propertyValue;
        }
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            AppLocalizations.of(context)!.nftPropertyValueHint,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
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
                                ArchethicTheme.gradientInputFormBackground,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              key: const Key('nftValue'),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              maxLines: 3,
                              autocorrect: false,
                              controller: nftPropertyValueController,
                              onChanged: (text) async {
                                nftCreationNotifier.setPropertyValue(
                                  text,
                                );
                              },
                              focusNode: nftPropertyValueFocusNode,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(500),
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
                                ArchethicTheme.text,
                                ArchethicTheme.snackBarShadow,
                              );
                            } else if (QRScanErrs.errorList
                                .contains(scanResult)) {
                              UIUtil.showSnackbar(
                                scanResult,
                                context,
                                ref,
                                ArchethicTheme.text,
                                ArchethicTheme.snackBarShadow,
                              );
                              return;
                            } else {
                              nftCreationNotifier.setPropertyValue(
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
