/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../add_contact.dart';

class AddContactTextFieldPublicKey extends ConsumerStatefulWidget {
  const AddContactTextFieldPublicKey({
    super.key,
  });

  @override
  ConsumerState<AddContactTextFieldPublicKey> createState() =>
      _AddContactTextFieldPublicKeyState();
}

class _AddContactTextFieldPublicKeyState
    extends ConsumerState<AddContactTextFieldPublicKey> {
  late FocusNode publicKeyFocusNode;
  late TextEditingController publicKeyController;

  @override
  void initState() {
    super.initState();
    publicKeyFocusNode = FocusNode();
    publicKeyController = TextEditingController();
  }

  @override
  void dispose() {
    publicKeyFocusNode.dispose();
    publicKeyController.dispose();
    super.dispose();
  }

  void _updatePublicKeyTextController() {
    final contactCreation =
        ref.read(ContactCreationFormProvider.contactCreationForm);
    publicKeyController.text = contactCreation.publicKey;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final preferences = ref.watch(SettingsProviders.settings);
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);
    final contactCreationNotifier =
        ref.watch(ContactCreationFormProvider.contactCreationForm.notifier);

    return AppTextField(
      textAlign: TextAlign.start,
      focusNode: publicKeyFocusNode,
      controller: publicKeyController,
      style: ArchethicThemeStyles.textStyleSize14W100Primary,
      inputFormatters: <TextInputFormatter>[
        UpperCaseTextFormatter(),
        LengthLimitingTextInputFormatter(68),
      ],
      textInputAction: TextInputAction.done,
      maxLines: 4,
      autocorrect: false,
      labelText: localizations.publicKeyHint,
      prefixButton: hasQRCode
          ? TextFieldButton(
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
                  contactCreationNotifier.setPublicKey(
                    scanResult,
                  );
                  _updatePublicKeyTextController();
                }
              },
            )
          : null,
      fadePrefixOnCondition: true,
      prefixShowFirstCondition: true,
      suffixButton: PasteIcon(
        onPaste: (String value) {
          publicKeyController.text = value;
        },
      ),
      fadeSuffixOnCondition: true,
      suffixShowFirstCondition: true,
      onChanged: (String text) {
        contactCreationNotifier.setPublicKey(text);
      },
    );
  }
}
