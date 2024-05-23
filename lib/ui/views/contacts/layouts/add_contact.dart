/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/device_abilities.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/contacts/bloc/provider.dart';
import 'package:aewallet/ui/views/contacts/bloc/state.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/paste_icon.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
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

class AddContactSheetBody extends ConsumerWidget
    implements SheetSkeletonInterface {
  const AddContactSheetBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final contactCreationNotifier =
        ref.watch(ContactCreationFormProvider.contactCreationForm.notifier);
    final contactCreation =
        ref.watch(ContactCreationFormProvider.contactCreationForm);
    return Row(
      children: <Widget>[
        AppButtonTinyConnectivity(
          localizations.addContact,
          Dimens.buttonBottomDimens,
          key: const Key('addContact'),
          onPressed: () async {
            contactCreationNotifier.setCreationInProgress(true);
            final isNameOk = await contactCreationNotifier.controlName(
              context,
            );

            final isAddressOk = await contactCreationNotifier.controlAddress(
              context,
            );

            if (isNameOk && isAddressOk) {
              final newContact = await contactCreationNotifier.addContact();

              await ref
                  .read(AccountProviders.selectedAccount.notifier)
                  .refreshRecentTransactions();
              UIUtil.showSnackbar(
                localizations.contactAdded.replaceAll('%1', newContact.format),
                context,
                ref,
                ArchethicTheme.text,
                ArchethicTheme.snackBarShadow,
                icon: Symbols.info,
              );
              context.pop();
            }
            contactCreationNotifier.setCreationInProgress(false);
          },
          disabled: !contactCreation.canCreateContact,
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return SheetAppBar(
      title: localizations.addContact,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.pop();
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    return const Column(
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
    );
  }
}
