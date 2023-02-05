/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/device_abilities.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/contacts/bloc/provider.dart';
import 'package:aewallet/ui/views/contacts/bloc/state.dart';
import 'package:aewallet/ui/views/contacts/layouts/components/add_contact_public_key_recovered.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/user_data_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final contactCreation =
        ref.watch(ContactCreationFormProvider.contactCreationForm);
    final contactCreationNotifier =
        ref.watch(ContactCreationFormProvider.contactCreationForm.notifier);
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

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
          theme.text!,
          theme.snackBarShadow!,
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
                          UiIcons.about,
                          color: theme.text,
                          size: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        localizations.addContactDescription,
                        style: theme.textStyleSize12W100Primary,
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
                    if (contactCreation.canCreateContact &&
                        connectivityStatusProvider ==
                            ConnectivityStatus.isConnected)
                      AppButtonTiny(
                        AppButtonTinyType.primary,
                        localizations.addContact,
                        Dimens.buttonBottomDimens,
                        key: const Key('addContact'),
                        icon: Icon(
                          Icons.add,
                          color: theme.mainButtonLabel,
                          size: 14,
                        ),
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
                              name: '@${contactCreation.name}',
                              address: contactCreation.address,
                              type: ContactType.externalContact.name,
                              publicKey: contactCreation.publicKeyToStore
                                  .toUpperCase(),
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
                              theme.text!,
                              theme.snackBarShadow!,
                            );
                            Navigator.of(context).pop();
                          }
                        },
                      )
                    else
                      AppButtonTiny(
                        AppButtonTinyType.primaryOutline,
                        localizations.addContact,
                        Dimens.buttonBottomDimens,
                        key: const Key('addContact'),
                        icon: Icon(
                          Icons.add,
                          color: theme.mainButtonLabel!.withOpacity(0.3),
                          size: 14,
                        ),
                        onPressed: () {},
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
