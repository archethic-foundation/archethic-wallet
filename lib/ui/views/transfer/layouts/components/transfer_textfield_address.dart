/// SPDX-License-Identifier: AGPL-3.0-or-later

part of '../transfer_sheet.dart';

class TransferTextFieldAddress extends ConsumerStatefulWidget {
  const TransferTextFieldAddress({
    super.key,
  });

  @override
  ConsumerState<TransferTextFieldAddress> createState() =>
      _TransferTextFieldAddressState();
}

class _TransferTextFieldAddressState
    extends ConsumerState<TransferTextFieldAddress> {
  late TextEditingController sendAddressController;
  late FocusNode sendAddressFocusNode;

  @override
  void initState() {
    super.initState();

    sendAddressFocusNode = FocusNode();
    sendAddressController = TextEditingController();
    _updateAdressTextController();

    sendAddressFocusNode.addListener(() {
      if (sendAddressFocusNode.hasFocus) {
        sendAddressController.selection = TextSelection.fromPosition(
          TextPosition(offset: sendAddressController.text.length),
        );
        if (sendAddressController.text.startsWith('@')) {
          sl
              .get<DBHelper>()
              .getContactsWithNameLike(sendAddressController.text)
              .then((List<Contact> contactList) {});
        }
      } else {
        if (sendAddressController.text.trim() == '@') {
          sendAddressController.text = '';
        }
      }
    });
  }

  @override
  void dispose() {
    sendAddressFocusNode.dispose();
    sendAddressController.dispose();
    super.dispose();
  }

  void _updateAdressTextController() {
    final recipient = ref.read(TransferFormProvider.transferForm).recipient;
    sendAddressController.text = recipient.when(
      address: (address) => address.address!,
      contact: (contact) => contact.name,
      unknownContact: (name) => name,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final transfer = ref.watch(TransferFormProvider.transferForm);
    final transferNotifier =
        ref.watch(TransferFormProvider.transferForm.notifier);
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);

    return Column(
      children: [
        AppTextField(
          focusNode: sendAddressFocusNode,
          controller: sendAddressController,
          cursorColor: theme.text,
          inputFormatters: <TextInputFormatter>[
            UpperCaseTextFormatter(),
            LengthLimitingTextInputFormatter(
              transfer.recipient.maybeWhen(
                address: (_) => 68,
                unknownContact: (_) => 68,
                contact: (_) => 20,
                orElse: () => 20,
              ),
            )
          ],
          textInputAction: TextInputAction.next,
          maxLines: null,
          autocorrect: false,
          labelText: AppLocalization.of(context)!.enterAddress,
          prefixButton: hasQRCode
              ? TextFieldButton(
                  icon: FontAwesomeIcons.qrcode,
                  onPressed: () async {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          preferences.activeVibrations,
                        );
                    final scanResult = await UserDataUtil.getQRData(
                      DataType.address,
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
                      // Is a URI
                      final address = Address(address: scanResult);
                      await transferNotifier.setContactAddress(
                        context: context,
                        address: address,
                      );
                      _updateAdressTextController();
                    }
                  },
                )
              : null,
          fadePrefixOnCondition: true,
          prefixShowFirstCondition: true,
          suffixButton: TextFieldButton(
            icon: FontAwesomeIcons.paste,
            onPressed: () {
              sl.get<HapticUtil>().feedback(
                    FeedbackType.light,
                    preferences.activeVibrations,
                  );
              Clipboard.getData('text/plain').then((ClipboardData? data) async {
                if (data == null || data.text == null) {
                  return;
                }
                sendAddressController.text = data.text!;
                transferNotifier.setRecipientNameOrAddress(
                  context: context,
                  text: data.text!,
                );
              });
            },
          ),
          suffixShowFirstCondition: true,
          fadeSuffixOnCondition: true,
          style: transfer.recipient.isAddressValid
              ? theme.textStyleSize14W700Primary
              : theme.textStyleSize14W700Primary60,
          onChanged: (String text) async {
            transferNotifier.setRecipientNameOrAddress(
              context: context,
              text: text,
            );
          },
        ),
        InkWell(
          onTap: () async {
            sl.get<HapticUtil>().feedback(
                  FeedbackType.light,
                  preferences.activeVibrations,
                );
            final contact = await ContactsDialog.getDialog(context, ref);
            if (contact == null) return;

            await transferNotifier.setRecipient(
              context: context,
              contact: TransferRecipient.contact(contact: contact),
            );

            _updateAdressTextController();
          },
          child: Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.105,
              right: MediaQuery.of(context).size.width * 0.105,
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 48,
                  width: 48,
                  child: Icon(
                    UiIcons.address_book,
                    size: 20,
                    color: theme.textFieldIcon,
                  ),
                ),
                Text(
                  localizations.viewAddressBook,
                  style: theme.textStyleSize14W100Primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
