/// SPDX-License-Identifier: AGPL-3.0-or-later

part of '../transfer_sheet.dart';

class TransferTextFieldAddress extends ConsumerStatefulWidget {
  const TransferTextFieldAddress({
    super.key,
    required this.seed,
  });

  final String seed;

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
    _updateAmountTextController();

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

  void _updateAmountTextController() {
    final recipient = ref.read(TransferFormProvider.transferForm).recipient;
    sendAddressController.text = recipient.when(
      address: (address) => address.address,
      contact: (contact) => contact.name,
      unknownContact: (name) => name,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final transfer = ref.watch(TransferFormProvider.transferForm);
    final transferNotifier =
        ref.watch(TransferFormProvider.transferForm.notifier);
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);

    return AppTextField(
      focusNode: sendAddressFocusNode,
      controller: sendAddressController,
      cursorColor: theme.text,
      inputFormatters: <TextInputFormatter>[
        UpperCaseTextFormatter(),
        LengthLimitingTextInputFormatter(
          transfer.recipient.maybeWhen(
            address: (_) => 68,
            orElse: () => 20,
          ),
        )
      ],
      textInputAction: TextInputAction.done,
      maxLines: null,
      autocorrect: false,
      labelText: AppLocalization.of(context)!.enterAddress,
      prefixButton: TextFieldButton(
        icon: FontAwesomeIcons.at,
        onPressed: () async {
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

          _updateAmountTextController();
        },
      ),
      fadePrefixOnCondition: true,
      prefixShowFirstCondition: true,
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
                  final address = Address(scanResult);
                  await transferNotifier.setContactAddress(
                    context: context,
                    address: address,
                  );
                  _updateAmountTextController();
                }
              },
            )
          : null,
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
    );
  }
}
