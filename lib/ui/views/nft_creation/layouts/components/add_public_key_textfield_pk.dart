/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../add_address.dart';

class AddPublicKeyTextFieldPk extends ConsumerStatefulWidget {
  const AddPublicKeyTextFieldPk({
    super.key,
  });

  @override
  ConsumerState<AddPublicKeyTextFieldPk> createState() =>
      _AddPublicKeyTextFieldPkState();
}

class _AddPublicKeyTextFieldPkState
    extends ConsumerState<AddPublicKeyTextFieldPk> {
  late TextEditingController publicKeyController;
  late FocusNode publicKeyFocusNode;

  @override
  void initState() {
    super.initState();
    publicKeyFocusNode = FocusNode();
    publicKeyController = TextEditingController();
    _updatePublicKeyTextController();

    publicKeyFocusNode.addListener(() {
      if (publicKeyFocusNode.hasFocus) {
        publicKeyController.selection = TextSelection.fromPosition(
          TextPosition(offset: publicKeyController.text.length),
        );
        if (publicKeyController.text.startsWith('@')) {
          ContactsHiveDatasource.instance()
              .getContactsWithNameLike(publicKeyController.text)
              .then((List<Contact> contactList) {});
        }
      } else {
        if (publicKeyController.text.trim() == '@') {
          publicKeyController.text = '';
        }
      }
    });
  }

  @override
  void dispose() {
    publicKeyFocusNode.dispose();
    publicKeyController.dispose();
    super.dispose();
  }

  void _updatePublicKeyTextController() {
    final propertyAccessRecipient = ref
        .read(
          NftCreationFormProvider.nftCreationForm,
        )
        .propertyAccessRecipient;
    publicKeyController.text = propertyAccessRecipient.when(
      address: (address) => address.address!,
      contact: (contact) => contact.format,
      unknownContact: (name) => name,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final nftCreation = ref.watch(NftCreationFormProvider.nftCreationForm);
    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm.notifier,
    );
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);

    ref.listen<NftCreationFormState>(
      NftCreationFormProvider.nftCreationForm,
      (_, nftCreation) {
        if (nftCreation.propertyAccessRecipient.address!.address!.isEmpty) {
          publicKeyController.text = '';
        }
      },
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            AppLocalizations.of(context)!.enterAddress,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
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
                              child: Opacity(
                                opacity: nftCreation
                                        .propertyAccessRecipient.isAddressValid
                                    ? 1.0
                                    : 0.6,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: TextField(
                                    style: TextStyle(
                                      fontFamily: ArchethicTheme.addressFont,
                                      fontSize: 14,
                                    ),
                                    autocorrect: false,
                                    controller: publicKeyController,
                                    onChanged: (text) async {
                                      await nftCreationNotifier
                                          .setPropertyAccessRecipientNameOrPublicKey(
                                        context: context,
                                        text: text,
                                      );
                                    },
                                    focusNode: publicKeyFocusNode,
                                    textInputAction: TextInputAction.done,
                                    maxLines: null,
                                    keyboardType: TextInputType.text,
                                    inputFormatters: <TextInputFormatter>[
                                      UpperCaseTextFormatter(),
                                      LengthLimitingTextInputFormatter(
                                        nftCreation.propertyAccessRecipient
                                            .maybeWhen(
                                          address: (_) => 68,
                                          orElse: () => 20,
                                        ),
                                      ),
                                    ],
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left: 10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (hasQRCode)
                    TextFieldButton(
                      icon: Symbols.qr_code_scanner,
                      onPressed: () async {
                        final scanResult = await UserDataUtil.getQRData(
                          DataType.address,
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
                        } else if (QRScanErrs.errorList.contains(scanResult)) {
                          UIUtil.showSnackbar(
                            scanResult,
                            context,
                            ref,
                            ArchethicTheme.text,
                            ArchethicTheme.snackBarShadow,
                          );
                          return;
                        } else {
                          final address = Address(address: scanResult);
                          await nftCreationNotifier.setContactAddress(
                            context: context,
                            address: address,
                          );
                          _updatePublicKeyTextController();
                        }
                      },
                    ),
                  PasteIcon(
                    onPaste: (String value) {
                      publicKeyController.text = value;
                      nftCreationNotifier
                          .setPropertyAccessRecipientNameOrPublicKey(
                        context: context,
                        text: value,
                      );
                    },
                  ),
                  TextFieldButton(
                    icon: Symbols.contacts,
                    onPressed: () async {
                      final contact =
                          await ContactsDialog.getDialog(context, ref);
                      if (contact == null) return;

                      await nftCreationNotifier.setPropertyAccessRecipient(
                        context: context,
                        contact:
                            PropertyAccessRecipient.contact(contact: contact),
                      );

                      _updatePublicKeyTextController();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            AppLocalizations.of(context)!.enterAddressHelp,
            style: ArchethicThemeStyles.textStyleSize10W100Primary,
          ),
        ),
      ],
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 200))
        .scale(duration: const Duration(milliseconds: 200));
  }
}
