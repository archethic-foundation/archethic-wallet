/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../add_contact.dart';

class AddContactTextFieldAddress extends ConsumerStatefulWidget {
  const AddContactTextFieldAddress({
    super.key,
  });

  @override
  ConsumerState<AddContactTextFieldAddress> createState() =>
      _AddContactTextFieldAddressState();
}

class _AddContactTextFieldAddressState
    extends ConsumerState<AddContactTextFieldAddress> {
  late FocusNode addressFocusNode;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    addressFocusNode = FocusNode();
    final contactCreation =
        ref.read(ContactCreationFormProvider.contactCreationForm);
    addressController = TextEditingController(text: contactCreation.address);
  }

  @override
  void dispose() {
    addressFocusNode.dispose();
    addressController.dispose();
    super.dispose();
  }

  void _updateAdressTextController() {
    final contactCreation =
        ref.read(ContactCreationFormProvider.contactCreationForm);
    addressController.text = contactCreation.address;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final preferences = ref.watch(SettingsProviders.settings);
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);
    final contactCreationNotifier =
        ref.watch(ContactCreationFormProvider.contactCreationForm.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            AppLocalizations.of(context)!.addressHint,
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
                                gradient: ArchethicThemeBase
                                    .gradientInputFormBackground,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextField(
                                  style: TextStyle(
                                    fontFamily: ArchethicTheme.addressFont,
                                    fontSize: 14,
                                  ),
                                  autocorrect: false,
                                  controller: addressController,
                                  onChanged: (text) {
                                    contactCreationNotifier.setAddress(
                                      text,
                                      context,
                                    );
                                  },
                                  focusNode: addressFocusNode,
                                  textInputAction: TextInputAction.done,
                                  maxLines: null,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(68),
                                  ],
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 10),
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
                          contactCreationNotifier.setAddress(
                            scanResult,
                            context,
                          );
                          _updateAdressTextController();
                        }
                      },
                    ),
                  PasteIcon(
                    onPaste: (String value) {
                      addressController.text = value;
                      contactCreationNotifier.setAddress(
                        value,
                        context,
                      );
                    },
                  ),
                ],
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
