/// SPDX-License-Identifier: AGPL-3.0-or-later

part of '../add_public_key.dart';

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
          sl
              .get<DBHelper>()
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
          NftCreationFormProvider.nftCreationForm(
            ref.read(
              NftCreationFormProvider.nftCreationFormArgs,
            ),
          ),
        )
        .propertyAccessRecipient;
    publicKeyController.text = propertyAccessRecipient.when(
      publicKey: (publicKey) => publicKey.publicKey,
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
    final nftCreationArgs = ref.read(
      NftCreationFormProvider.nftCreationFormArgs,
    );
    final nftCreation =
        ref.watch(NftCreationFormProvider.nftCreationForm(nftCreationArgs));
    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm(nftCreationArgs).notifier,
    );
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);

    ref.listen<NftCreationFormState>(
      NftCreationFormProvider.nftCreationForm(
        ref.read(
          NftCreationFormProvider.nftCreationFormArgs,
        ),
      ),
      (_, nftCreation) {
        if (nftCreation.propertyAccessRecipient.publicKey!.publicKey.isEmpty) {
          publicKeyController.text = '';
        }
      },
    );

    return AppTextField(
      focusNode: publicKeyFocusNode,
      controller: publicKeyController,
      cursorColor: theme.text,
      inputFormatters: <TextInputFormatter>[
        UpperCaseTextFormatter(),
        LengthLimitingTextInputFormatter(
          nftCreation.propertyAccessRecipient.maybeWhen(
            publicKey: (_) => 68,
            orElse: () => 20,
          ),
        )
      ],
      textInputAction: TextInputAction.done,
      maxLines: null,
      autocorrect: false,
      labelText: AppLocalization.of(context)!.enterPublicKey,
      prefixButton: TextFieldButton(
        icon: UiIcons.address_book,
        onPressed: () async {
          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                preferences.activeVibrations,
              );
          final contact = await ContactsDialog.getDialog(context, ref);
          if (contact == null) return;

          await nftCreationNotifier.setPropertyAccessRecipient(
            context: context,
            contact: PropertyAccessRecipient.contact(contact: contact),
          );

          _updatePublicKeyTextController();
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
                  final publicKey = PublicKey(scanResult);
                  await nftCreationNotifier.setContactPublicKey(
                    context: context,
                    publicKey: publicKey,
                  );
                  _updatePublicKeyTextController();
                }
              },
            )
          : null,
      suffixShowFirstCondition: true,
      fadeSuffixOnCondition: true,
      style: nftCreation.propertyAccessRecipient.isPublicKeyValid
          ? theme.textStyleSize14W700Primary
          : theme.textStyleSize14W700Primary60,
      onChanged: (String text) async {
        nftCreationNotifier.setPropertyAccessRecipientNameOrAddress(
          context: context,
          text: text,
        );
      },
    );
  }
}
