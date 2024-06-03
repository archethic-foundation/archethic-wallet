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
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

part 'contact_detail.freezed.dart';
part 'contact_detail.g.dart';

@freezed
class ContactDetailsRouteParams with _$ContactDetailsRouteParams {
  const factory ContactDetailsRouteParams({
    required String contactAddress,
    bool? readOnly,
  }) = _ContactDetailsRouteParams;
  const ContactDetailsRouteParams._();

  factory ContactDetailsRouteParams.fromJson(Map<String, dynamic> json) =>
      _$ContactDetailsRouteParamsFromJson(json);
}

class ContactDetail extends ConsumerWidget implements SheetSkeletonInterface {
  const ContactDetail({
    required this.contactAddress,
    this.readOnly = false,
    super.key,
  });

  final String contactAddress;
  final bool readOnly;
  static const String routerPage = '/contact_detail';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
      thumbVisibility: false,
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    return const SizedBox.shrink();
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final contact = ref
        .watch(ContactProviders.getContactWithAddress(contactAddress))
        .valueOrNull;

    if (contact == null) {
      return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      );
    }

    return SheetAppBar(
      title: contact.format,
      widgetRight: Padding(
        padding: const EdgeInsets.only(right: 10, top: 10),
        child: _ContactDetailBalance(contactAddress: contactAddress),
      ),
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
    final contact = ref
        .watch(ContactProviders.getContactWithAddress(contactAddress))
        .valueOrNull;
    return contact == null
        ? Center(
            child: CircularProgressIndicator(
              color: ArchethicTheme.text,
              strokeWidth: 1,
            ),
          )
        : _ContactDetailBody(
            contact: contact,
            readOnly: readOnly,
          );
  }
}

class _ContactDetailBalance extends ConsumerWidget {
  const _ContactDetailBalance({
    required this.contactAddress,
  });

  final String contactAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contact = ref
        .watch(ContactProviders.getContactWithAddress(contactAddress))
        .valueOrNull;

    if (contact == null) return const SizedBox();

    final accounts = ref.watch(AccountProviders.accounts).valueOrNull;
    final account = accounts
        ?.where(
          (element) => element.lastAddress == contactAddress,
        )
        .firstOrNull;
    AsyncValue<AccountBalance> asyncAccountBalance;
    if (contact.type == ContactType.keychainService.name && account != null) {
      asyncAccountBalance = AsyncValue.data(account.balance!);
    } else {
      asyncAccountBalance =
          ref.watch(ContactProviders.getBalance(address: contactAddress));
    }
    return SingleContactBalance(
      contact: contact,
      accountBalance: asyncAccountBalance,
    );
  }
}

class _ContactDetailBody extends ConsumerWidget {
  const _ContactDetailBody({
    required this.contact,
    required this.readOnly,
  });

  final Contact contact;
  final bool readOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final preferences = ref.watch(SettingsProviders.settings);

    return Column(
      children: <Widget>[
        _ContactDetailActions(contact: contact, readOnly: readOnly),
        ContactDetailTab(
          infoQRCode: contact.genesisAddress!.toUpperCase(),
          description: contact.type == ContactType.keychainService.name
              ? localizations.contactAddressInfoKeychainService
              : localizations.contactAddressInfoExternalContact,
          messageCopied: localizations.addressCopied,
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
                      style: ArchethicThemeStyles.textStyleSize14W600PrimaryRed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
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
                  'fromRouterPage': CreateDiscussionValidationSheet.routerPage,
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
              '${ref.read(SettingsProviders.settings).network.getLink()}/explorer/chain?address=${contact.genesisAddress}',
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
