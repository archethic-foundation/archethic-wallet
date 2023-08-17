/// SPDX-License-Identifier: AGPL-3.0-or-later
///
import 'package:aewallet/application/device_abilities.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/data/access_recipient.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/public_key.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/ui/widgets/dialogs/contacts_dialog.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/user_data_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iconsax/iconsax.dart';

part 'add_public_key_textfield_pk.freezed.dart';

@freezed
class AddPublicKeyTextFieldValue with _$AddPublicKeyTextFieldValue {
  const AddPublicKeyTextFieldValue._();
  const factory AddPublicKeyTextFieldValue.publicKey({
    required PublicKey publicKey,
  }) = _PropertyAccessPublicKey;
  const factory AddPublicKeyTextFieldValue.contact({
    required Contact contact,
  }) = _PropertyAccessContact;
  const factory AddPublicKeyTextFieldValue.unknownContact({
    required String name,
  }) = _PropertyAccessUnknownContact;

  PublicKey? get publicKey => when(
        publicKey: (publicKey) => publicKey,
        contact: (contact) => PublicKey(contact.publicKey),
        unknownContact: (_) => null,
      );

  bool get isPublicKeyValid => (publicKey ?? const PublicKey('')).isValid;

  AccessRecipient? get toAccessRecipient => mapOrNull(
        publicKey: (value) =>
            AccessRecipient.publicKey(publicKey: value.publicKey.publicKey),
        contact: (value) => AccessRecipient.contact(contact: value.contact),
      );
}

class AddPublicKeyTextFieldPk extends ConsumerStatefulWidget {
  const AddPublicKeyTextFieldPk({
    super.key,
    required this.onChanged,
  });

  final void Function(AddPublicKeyTextFieldValue? recipient) onChanged;

  @override
  ConsumerState<AddPublicKeyTextFieldPk> createState() =>
      _AddPublicKeyTextFieldPkState();
}

class _AddPublicKeyTextFieldPkState
    extends ConsumerState<AddPublicKeyTextFieldPk> {
  late TextEditingController publicKeyController;
  late FocusNode publicKeyFocusNode;
  AddPublicKeyTextFieldValue? accessRecipient;

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

  void _setAccessRecipient(AddPublicKeyTextFieldValue accessRecipient) {
    setState(() {
      this.accessRecipient = accessRecipient;
    });
    widget.onChanged(accessRecipient);
  }

  Future<void> _setContactPublicKey({
    required BuildContext context,
    required PublicKey publicKey,
  }) async {
    try {
      final contact = await sl.get<DBHelper>().getContactWithPublicKey(
            publicKey.publicKey,
          );

      _setAccessRecipient(AddPublicKeyTextFieldValue.contact(contact: contact));
    } catch (_) {
      _setAccessRecipient(
        AddPublicKeyTextFieldValue.publicKey(
          publicKey: publicKey,
        ),
      );
    }
  }

  Future<void> _setRecipientNameOrPublicKey({
    required BuildContext context,
    required String text,
  }) async {
    if (!text.startsWith('@')) {
      try {
        final contact = await sl.get<DBHelper>().getContactWithPublicKey(
              text,
            );
        _setAccessRecipient(
          AddPublicKeyTextFieldValue.contact(contact: contact),
        );
      } catch (_) {
        _setAccessRecipient(
          AddPublicKeyTextFieldValue.publicKey(publicKey: PublicKey(text)),
        );
      }

      return;
    }

    try {
      final contact = await sl.get<DBHelper>().getContactWithName(text);
      _setAccessRecipient(AddPublicKeyTextFieldValue.contact(contact: contact));
    } catch (e) {
      _setAccessRecipient(
        AddPublicKeyTextFieldValue.unknownContact(
          name: text,
        ),
      );
    }
  }

  @override
  void dispose() {
    publicKeyFocusNode.dispose();
    publicKeyController.dispose();
    super.dispose();
  }

  void _updatePublicKeyTextController() {
    publicKeyController.text = accessRecipient?.when(
          publicKey: (publicKey) => publicKey.publicKey,
          contact: (contact) => contact.format,
          unknownContact: (name) => name,
        ) ??
        '';
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);

    return AppTextField(
      focusNode: publicKeyFocusNode,
      controller: publicKeyController,
      cursorColor: theme.text,
      inputFormatters: <TextInputFormatter>[
        UpperCaseTextFormatter(),
        LengthLimitingTextInputFormatter(
          accessRecipient?.maybeWhen(
            publicKey: (_) => 68,
            orElse: () => 20,
          ),
        ),
      ],
      textInputAction: TextInputAction.done,
      maxLines: null,
      autocorrect: false,
      labelText: AppLocalizations.of(context)!.enterPublicKey,
      prefixButton: TextFieldButton(
        icon: UiIcons.address_book,
        onPressed: () async {
          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                preferences.activeVibrations,
              );
          final contact = await ContactsDialog.getDialog(context, ref);
          if (contact == null) return;

          _setAccessRecipient(
            AddPublicKeyTextFieldValue.contact(contact: contact),
          );

          _updatePublicKeyTextController();
        },
      ),
      fadePrefixOnCondition: true,
      prefixShowFirstCondition: true,
      suffixButton: hasQRCode
          ? TextFieldButton(
              icon: Iconsax.scan_barcode,
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
                    AppLocalizations.of(context)!.qrInvalidAddress,
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
                  _setContactPublicKey(
                    context: context,
                    publicKey: PublicKey(scanResult),
                  );
                  _updatePublicKeyTextController();
                }
              },
            )
          : null,
      suffixShowFirstCondition: true,
      fadeSuffixOnCondition: true,
      style: accessRecipient?.isPublicKeyValid ?? false
          ? theme.textStyleSize14W700Primary
          : theme.textStyleSize14W700Primary60,
      onChanged: (String text) async {
        _setRecipientNameOrPublicKey(
          context: context,
          text: text,
        );
      },
    );
  }
}
