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
    final nftCreation = ref.read(
      NftCreationFormProvider.nftCreationForm,
    );
    nftNameController = TextEditingController(text: nftCreation.name);
  }

  @override
  void dispose() {
    nftNameFocusNode.dispose();
    nftNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm.notifier,
    );
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);

    ref.listen<NftCreationFormState>(
      NftCreationFormProvider.nftCreationForm,
      (_, nftCreation) {
        if (nftCreation.name != nftNameController.text) {
          nftNameController.text = nftCreation.name;
        }
      },
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            AppLocalizations.of(context)!.nftNameHint,
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
                          child: TextField(
                            key: const Key('nftCreationField'),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            autocorrect: false,
                            controller: nftNameController,
                            onChanged: (text) {
                              nftCreationNotifier.setName(context, text);
                            },
                            focusNode: nftNameFocusNode,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(40),
                            ],
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10),
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
                              nftNameController.text = scanResult;
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
