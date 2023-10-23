/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/device_abilities.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/archethic_theme_base.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/contacts/bloc/provider.dart';
import 'package:aewallet/ui/views/contacts/bloc/state.dart';
import 'package:aewallet/ui/views/contacts/layouts/components/add_contact_public_key_recovered.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/paste_icon.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/user_data_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:material_symbols_icons/symbols.dart';

part 'components/add_contact_textfield_address.dart';
part 'components/add_contact_textfield_name.dart';
part 'components/add_contact_textfield_public_key.dart';

class AddContactSheet extends ConsumerWidget {
  const AddContactSheet({super.key, this.address});

  final String? address;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        ContactCreationFormProvider.initialContactCreationForm
            .overrideWithValue(
          ContactCreationFormState(
            address: address ?? '',
          ),
        ),
      ],
      child: const AddContactSheetBody(),
    );
  }
}

class AddContactSheetBody extends ConsumerWidget {
  const AddContactSheetBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final contactCreation =
        ref.watch(ContactCreationFormProvider.contactCreationForm);
    final contactCreationNotifier =
        ref.watch(ContactCreationFormProvider.contactCreationForm.notifier);

    ref.listen<ContactCreationFormState>(
      ContactCreationFormProvider.contactCreationForm,
      (_, contactCreation) {
        if (contactCreation.isControlsOk) return;

        final errorMessages = <String>[];
        if (contactCreation.error.isNotEmpty) {
          errorMessages.add(contactCreation.error);
        }

        UIUtil.showSnackbar(
          errorMessages.join('\n'),
          context,
          ref,
          ArchethicTheme.text,
          ArchethicTheme.snackBarShadow,
          duration: const Duration(seconds: 5),
        );
        contactCreationNotifier.setError('');
      },
    );

    return TapOutsideUnfocus(
      child: SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            SheetHeader(
              title: localizations.addContact,
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ArchethicScrollbar(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                  child: Column(
                    children: <Widget>[
                      const AddContactTextFieldName(),
                      const SizedBox(
                        height: 20,
                      ),
                      const AddContactTextFieldAddress(),
                      const SizedBox(
                        height: 20,
                      ),
                      if (contactCreation.publicKeyRecovered.isEmpty)
                        const AddContactTextFieldPublicKey()
                      else
                        const AddContactPublicKeyRecovered(),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Icon(
                          Symbols.info,
                          color: ArchethicTheme.text,
                          size: 20,
                          weight: IconSize.weightM,
                          opticalSize: IconSize.opticalSizeM,
                          grade: IconSize.gradeM,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        localizations.addContactDescription,
                        style: ArchethicThemeStyles.textStyleSize12W100Primary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    AppButtonTinyConnectivity(
                      localizations.addContact,
                      Dimens.buttonBottomDimens,
                      key: const Key('addContact'),
                      icon: Symbols.add,
                      onPressed: () async {
                        final isNameOk =
                            await contactCreationNotifier.controlName(
                          context,
                        );

                        final isAddressOk =
                            await contactCreationNotifier.controlAddress(
                          context,
                        );

                        if (isNameOk && isAddressOk) {
                          final newContact = Contact(
                            name: '@${Uri.encodeFull(contactCreation.name)}',
                            address: contactCreation.address,
                            type: ContactType.externalContact.name,
                            publicKey:
                                contactCreation.publicKeyToStore.toUpperCase(),
                            favorite: false,
                          );
                          ref.read(
                            ContactProviders.saveContact(contact: newContact),
                          );

                          ref
                              .read(AccountProviders.selectedAccount.notifier)
                              .refreshRecentTransactions();
                          UIUtil.showSnackbar(
                            localizations.contactAdded
                                .replaceAll('%1', newContact.format),
                            context,
                            ref,
                            ArchethicTheme.text,
                            ArchethicTheme.snackBarShadow,
                            icon: Symbols.info,
                          );
                          Navigator.of(context).pop();
                        }
                      },
                      disabled: !contactCreation.canCreateContact,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
