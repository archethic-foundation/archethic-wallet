/// SPDX-License-Identifier: AGPL-3.0-or-later

part of '../transfer_sheet.dart';

class TransferTextFieldAddress extends ConsumerWidget {
  const TransferTextFieldAddress({
    super.key,
    required this.accountSelected,
    required this.seed,
  });

  final Account accountSelected;
  final String seed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(preferenceProvider);
    final sendAddressFocusNode = FocusNode();
    final sendAddressController = TextEditingController();
    final transfer = ref.watch(TransferProvider.transfer);
    final transferNotifier = ref.watch(TransferProvider.transfer.notifier);

    return AppTextField(
      focusNode: sendAddressFocusNode,
      controller: sendAddressController,
      cursorColor: theme.text,
      inputFormatters: <LengthLimitingTextInputFormatter>[
        if (transfer.isContact)
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
          transferNotifier.setContact(contact!);
        },
      ),
      fadePrefixOnCondition: true,
      prefixShowFirstCondition: true,
      suffixButton: kIsWeb == false && (Platform.isIOS || Platform.isAndroid)
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
                  final contact = await sl
                      .get<DBHelper>()
                      .getContactWithAddress(address.address);

                  if (contact != null) {
                    transferNotifier.setContact(contact);
                    sendAddressController.text = contact.name!;
                  } else {
                    transferNotifier.setAddress(address.address);
                    sendAddressController.text = address.address;
                  }
                }
              },
            )
          : null,
      fadeSuffixOnCondition: true,
      style: theme.textStyleSize14W700Primary,
      onChanged: (String text) async {
        transferNotifier.setAddress(text);

        // TODO(redwarf03): ????
        sl
            .get<DBHelper>()
            .getContactsWithNameLike(text)
            .then((List<Contact> matchedList) {});
      },
    );
  }
}
