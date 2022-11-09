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

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
    final preferences = ref.watch(SettingsProviders.settings);
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);
    final contactCreationNotifier =
        ref.watch(ContactCreationFormProvider.contactCreationForm.notifier);

    return AppTextField(
      focusNode: addressFocusNode,
      controller: addressController,
      style: theme.textStyleSize14W100Primary,
      inputFormatters: <TextInputFormatter>[
        UpperCaseTextFormatter(),
        LengthLimitingTextInputFormatter(68),
      ],
      textInputAction: TextInputAction.done,
      maxLines: 4,
      autocorrect: false,
      labelText: localizations.addressHint,
      prefixButton: hasQRCode
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
                  contactCreationNotifier.setAddress(
                    scanResult,
                    context,
                  );
                }
              },
            )
          : null,
      fadePrefixOnCondition: true,
      prefixShowFirstCondition: true,
      suffixButton: TextFieldButton(
        icon: FontAwesomeIcons.paste,
        onPressed: () async {
          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                preferences.activeVibrations,
              );
          // TODO(reddwarf03): PB refresh textfield
          final data = await UserDataUtil.getClipboardText(
            DataType.address,
          );
          contactCreationNotifier.setAddress(
            data!,
            context,
          );
        },
      ),
      fadeSuffixOnCondition: true,
      suffixShowFirstCondition: true,
      onChanged: (String text) async {
        await contactCreationNotifier.setAddress(
          text,
          context,
        );
      },
    );
  }
}
