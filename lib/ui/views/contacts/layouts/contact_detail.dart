/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/domain/repositories/features_flags.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/public_key.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/contacts/layouts/components/contact_detail_tab.dart';
import 'package:aewallet/ui/views/contacts/layouts/components/single_contact_balance.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/views/messenger/layouts/create_discussion_validation_sheet.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:material_symbols_icons/symbols.dart';

class ContactDetail extends ConsumerWidget {
  const ContactDetail({
    required this.contact,
    this.readOnly = false,
    super.key,
  });

  final Contact contact;
  final bool readOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
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

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 25, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Expanded(
                          flex: 2,
                          child: SizedBox(),
                        ),
                        Flexible(
                          flex: 2,
                          child: AutoSizeText(
                            contact.format,
                            style: theme.textStyleSize24W700EquinoxPrimary,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            stepGranularity: 0.1,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: SingleContactBalance(
                            contact: contact,
                            accountBalance: asyncAccountBalance,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _ContactDetailActions(contact: contact, readOnly: readOnly),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                height: 40,
                child: TabBar(
                  labelColor: theme.text,
                  indicatorColor: theme.text,
                  tabs: [
                    Text(
                      localizations.contactAddressTabHeader,
                      style: theme.textStyleSize14W600EquinoxPrimary,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      localizations.contactPublicKeyTabHeader,
                      style: theme.textStyleSize14W600EquinoxPrimary,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ContactDetailTab(
                    infoQRCode: contact.address.toUpperCase(),
                    description:
                        contact.type == ContactType.keychainService.name
                            ? localizations.contactAddressInfoKeychainService
                            : localizations.contactAddressInfoExternalContact,
                    messageCopied: localizations.addressCopied,
                  ),
                  ContactDetailTab(
                    infoQRCode: contact.publicKey.toUpperCase(),
                    description:
                        contact.type == ContactType.keychainService.name
                            ? localizations.contactPublicKeyInfoKeychainService
                            : localizations.contactPublicKeyInfoExternalContact,
                    warning: localizations.contactPublicKeyInfoWarning,
                    messageCopied: localizations.publicKeyCopied,
                  ),
                ],
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
                            theme.text!,
                            theme.snackBarShadow!,
                            icon: Symbols.info,
                          );
                          Navigator.of(context).pop();
                        },
                        cancelText: localizations.no,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Symbols.delete,
                          color:
                              theme.textStyleSize14W600EquinoxPrimaryRed.color,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          localizations.deleteContact,
                          style: theme.textStyleSize14W600EquinoxPrimaryRed,
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
    final theme = ref.watch(ThemeProviders.selectedTheme);
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
                      color: theme.favoriteIconColor,
                      fill: data?.favorite == null || data!.favorite == false
                          ? 0
                          : 1,
                    );
                  },
                  orElse: () => Icon(
                    Symbols.favorite,
                    color: theme.favoriteIconColor,
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

              Sheets.showAppHeightNineSheet(
                context: context,
                ref: ref,
                widget: CreateDiscussionValidationSheet(
                  discussionCreationSuccess: () {
                    ref
                        .read(SettingsProviders.settings.notifier)
                        .setMainScreenCurrentPage(4);
                  },
                ),
                onDisposed: () {
                  ref
                      .watch(MessengerProviders.createDiscussionForm.notifier)
                      .removeAllMembers();
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
