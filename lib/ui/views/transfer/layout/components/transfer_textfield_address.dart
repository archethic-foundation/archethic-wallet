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
  TextEditingController? sendAddressController;
  FocusNode? sendAddressFocusNode;

  @override
  void initState() {
    super.initState();

    sendAddressFocusNode = FocusNode();
    sendAddressController = TextEditingController();
  }

  @override
  void dispose() {
    sendAddressController!.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final transfer = ref.watch(TransferProvider.transfer);
    final transferNotifier = ref.watch(TransferProvider.transfer.notifier);
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);
    final accountSelected =
        ref.read(AccountProviders.getSelectedAccount(context: context));

    var addressValidationText = '';

    return Column(
      children: [
        AppTextField(
          focusNode: sendAddressFocusNode,
          controller: sendAddressController,
          cursorColor: theme.text,
          inputFormatters: <LengthLimitingTextInputFormatter>[
            if (transfer.contactRecipient != null)
              LengthLimitingTextInputFormatter(20)
            else
              LengthLimitingTextInputFormatter(68),
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
              if (contact != null && contact.name != null) {
                transferNotifier.setContact(contact);
                sendAddressController!.text = contact.name!;
                await transferNotifier.calculateFees(
                  widget.seed,
                  accountSelected!.name!,
                );
              }
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
                      addressValidationText = '';
                      final contact = await sl
                          .get<DBHelper>()
                          .getContactWithAddress(address.address);

                      if (contact != null) {
                        transferNotifier.setContact(contact);
                        sendAddressController!.text = contact.name!;
                      } else {
                        transferNotifier.setAddress(address.address);
                        sendAddressController!.text = address.address;
                      }
                    }
                  },
                )
              : null,
          suffixShowFirstCondition: true,
          fadeSuffixOnCondition: true,
          style: theme.textStyleSize14W700Primary,
          onChanged: (String text) async {
            addressValidationText = '';
            if (text.startsWith('@')) {
              final contact = await sl.get<DBHelper>().getContactWithName(text);
              transferNotifier.setContact(contact);
              sendAddressController!.text = contact.name!;
            } else {
              transferNotifier.setAddress(text);
              sendAddressController!.text = text;
            }
            await transferNotifier.calculateFees(
              widget.seed,
              accountSelected!.name!,
            );
          },
        ),
        Container(
          alignment: AlignmentDirectional.center,
          margin: const EdgeInsets.only(
            left: 50,
            right: 40,
            top: 3,
          ),
          child: Text(
            addressValidationText,
            style: theme.textStyleSize14W600Primary,
          ),
        ),
      ],
    );
  }
}
