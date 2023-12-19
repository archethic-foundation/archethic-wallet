/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/device_abilities.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/archethic_theme_base.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/contacts/bloc/provider.dart';
import 'package:aewallet/ui/views/contacts/bloc/state.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/paste_icon.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/user_data_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

part 'components/add_contact_textfield_address.dart';
part 'components/add_contact_textfield_name.dart';

class AddContactSheet extends ConsumerWidget {
  const AddContactSheet({super.key, this.address});

  final String? address;
  static const String routerPage = '/add_contact';

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

    return Scaffold(
      drawerEdgeDragWidth: 0,
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        children: <Widget>[
          AppButtonTinyConnectivity(
            localizations.addContact,
            Dimens.buttonBottomDimens,
            key: const Key('addContact'),
            onPressed: () async {
              final isNameOk = await contactCreationNotifier.controlName(
                context,
              );

              final isAddressOk = await contactCreationNotifier.controlAddress(
                context,
              );

              if (isNameOk && isAddressOk) {
                final newContact = await contactCreationNotifier.addContact();

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
                context.pop();
              }
            },
            disabled: !contactCreation.canCreateContact,
          ),
        ],
      ),
      backgroundColor: ArchethicTheme.background,
      appBar: SheetAppBar(
        title: localizations.addContact,
        widgetLeft: BackButton(
          key: const Key('back'),
          color: ArchethicTheme.text,
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          bottom: 20,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ArchethicTheme.backgroundSmall,
            ),
            fit: BoxFit.fitHeight,
            opacity: 0.7,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.only(top: 120),
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Expanded(
                child: ArchethicScrollbar(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 30),
                    child: Column(
                      children: <Widget>[
                        AddContactTextFieldName(),
                        SizedBox(
                          height: 20,
                        ),
                        AddContactTextFieldAddress(),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
