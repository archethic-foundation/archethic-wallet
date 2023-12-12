/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/repositories/features_flags.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/public_key.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/contacts/layouts/components/contact_detail_tab.dart';
import 'package:aewallet/ui/views/contacts/layouts/components/single_contact_balance.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/views/messenger/layouts/create_discussion_validation_sheet.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class ContactDetail extends ConsumerWidget {
  const ContactDetail({
    required this.contact,
    this.readOnly = false,
    super.key,
  });

  final Contact contact;
  final bool readOnly;
  static const String routerPage = '/contact_detail';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final preferences = ref.watch(SettingsProviders.settings);

    final accounts = ref.watch(AccountProviders.accounts).valueOrNull;
    final account = accounts
        ?.where(
          (element) => element.lastAddress == contact.address,
        )
        .firstOrNull;
    AsyncValue<AccountBalance> asyncAccountBalance;
    if (contact.type == ContactType.keychainService.name && account != null) {
      asyncAccountBalance = AsyncValue.data(account.balance!);
    } else {
      asyncAccountBalance =
          ref.watch(ContactProviders.getBalance(address: contact.address));
    }

    return Scaffold(
      drawerEdgeDragWidth: 0,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: ArchethicTheme.background,
      appBar: SheetAppBar(
        title: contact.format,
        widgetRight: Padding(
          padding: const EdgeInsets.only(right: 10, top: 10),
          child: SingleContactBalance(
            contact: contact,
            accountBalance: asyncAccountBalance,
          ),
        ),
        widgetLeft: BackButton(
          key: const Key('back'),
          color: ArchethicTheme.text,
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ArchethicTheme.backgroundSmall,
            ),
            fit: BoxFit.fitHeight,
            opacity: 0.7,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            children: <Widget>[
              _ContactDetailActions(contact: contact, readOnly: readOnly),
              Expanded(
                child: ContactDetailTab(
                  infoQRCode: contact.address.toUpperCase(),
                  description: contact.type == ContactType.keychainService.name
                      ? localizations.contactAddressInfoKeychainService
                      : localizations.contactAddressInfoExternalContact,
                  messageCopied: localizations.addressCopied,
                ),
              ),
              Visibility(
                visible: contact.type != ContactType.keychainService.name &&
                    readOnly == false,
                child: Column(
                  children: [
                    TextButton(
                      key: const Key('removeContact'),
                      onPressed: () {
                        sl.get<HapticUtil>().feedback(
                              FeedbackType.light,
                              preferences.activeVibrations,
                            );
                        AppDialogs.showConfirmDialog(
                          context,
                          ref,
                          localizations.removeContact,
                          localizations.removeContactConfirmation.replaceAll(
                            '%1',
                            contact.format,
                          ),
                          localizations.yes,
                          () {
                            ref.read(
                              ContactProviders.deleteContact(
                                contact: contact,
                              ),
                            );

                            ref
                                .read(
                                  AccountProviders.selectedAccount.notifier,
                                )
                                .refreshRecentTransactions();
                            UIUtil.showSnackbar(
                              localizations.contactRemoved.replaceAll(
                                '%1',
                                contact.format,
                              ),
                              context,
                              ref,
                              ArchethicTheme.text,
                              ArchethicTheme.snackBarShadow,
                              icon: Symbols.info,
                            );
                            context.pop();
                          },
                          cancelText: localizations.no,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Symbols.delete,
                            color: ArchethicThemeStyles
                                .textStyleSize14W600PrimaryRed.color,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            localizations.deleteContact,
                            style: ArchethicThemeStyles
                                .textStyleSize14W600PrimaryRed,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactDetailActions extends ConsumerWidget {
  const _ContactDetailActions({
    required this.contact,
    this.readOnly = false,
  });

  final Contact contact;
  final bool readOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final preferences = ref.watch(SettingsProviders.settings);
    final _contact = ref.watch(
      ContactProviders.getContactWithName(
        contact.format,
      ),
    );

    final selectedAccount =
        ref.read(AccountProviders.selectedAccount).valueOrNull;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (contact.type != ContactType.keychainService.name &&
            readOnly == false)
          IconButton(
            key: const Key('favorite'),
            onPressed: () {
              sl.get<HapticUtil>().feedback(
                    FeedbackType.light,
                    preferences.activeVibrations,
                  );
              final updatedContact = contact;
              if (contact.favorite == null) {
                updatedContact.favorite = true;
              } else {
                updatedContact.favorite = !contact.favorite!;
              }

              ref.read(
                ContactProviders.saveContact(
                  contact: updatedContact,
                ),
              );
            },
            icon: Column(
              children: [
                _contact.maybeWhen(
                  data: (data) {
                    return Icon(
                      Symbols.favorite,
                      color: ArchethicTheme.favoriteIconColor,
                      fill: data?.favorite == null || data!.favorite == false
                          ? 0
                          : 1,
                    );
                  },
                  orElse: () => Icon(
                    Symbols.favorite,
                    color: ArchethicTheme.favoriteIconColor,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(localizations.favorites),
              ],
            ),
          ),
        if (FeatureFlags.messagingActive &&
                readOnly == false &&
                PublicKey(contact.publicKey)
                    .isValid // we can create discussion only with contact with valid public keys
                &&
                contact.format.toUpperCase() !=
                    selectedAccount?.nameDisplayed
                        .toUpperCase() // we will not create a discussion with ourselves
            )
          IconButton(
            key: const Key('newDiscussion'),
            onPressed: () {
              ref
                  .watch(MessengerProviders.createDiscussionForm.notifier)
                  .addMember(contact);
              context.push(
                CreateDiscussionValidationSheet.routerPage,
                extra: {
                  'discussionCreationSuccess': () {
                    ref
                        .read(SettingsProviders.settings.notifier)
                        .setMainScreenCurrentPage(4);
                  },
                  'onDispose': () {
                    ref
                        .watch(MessengerProviders.createDiscussionForm.notifier)
                        .removeAllMembers();
                  },
                },
              );
            },
            icon: Column(
              children: [
                const Icon(Symbols.edit_square),
                const SizedBox(
                  height: 4,
                ),
                Text(localizations.discussion),
              ],
            ),
          ),
        IconButton(
          key: const Key('viewExplorer'),
          onPressed: () {
            UIUtil.showWebview(
              context,
              '${ref.read(SettingsProviders.settings).network.getLink()}/explorer/transaction/${contact.address}',
              '',
            );
          },
          icon: Column(
            children: [
              const Icon(Symbols.open_in_new),
              const SizedBox(
                height: 4,
              ),
              Text(localizations.explorer),
            ],
          ),
        ),
      ],
    );
  }
}
