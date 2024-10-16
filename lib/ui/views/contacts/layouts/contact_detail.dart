/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/modules/aeswap/application/pool/dex_pool.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/address_formatters.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/contacts/layouts/components/contact_detail_tab.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';

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
      widgetAfterTitle: InkWell(
        onTap: () {
          final preferences = ref.watch(SettingsProviders.settings);

          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                preferences.activeVibrations,
              );
          Clipboard.setData(
            ClipboardData(
              text: contactAddress.toLowerCase(),
            ),
          );
          UIUtil.showSnackbar(
            '${AppLocalizations.of(context)!.addressCopied}\n${contactAddress.toLowerCase()}',
            context,
            ref,
            ArchethicTheme.text,
            ArchethicTheme.snackBarShadow,
            icon: Symbols.info,
          );
        },
        child: Row(
          children: [
            Text(
              AddressFormatters(
                contactAddress,
              ).getShortString4().toLowerCase(),
              style: ArchethicThemeStyles.textStyleSize14W600Primary,
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Symbols.content_copy,
              weight: IconSize.weightM,
              opticalSize: IconSize.opticalSizeM,
              grade: IconSize.gradeM,
              size: 16,
            ),
          ],
        ),
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
                    () async {
                      ref.read(
                        ContactProviders.deleteContact(
                          contact: contact,
                        ),
                      );
                      final poolListRaw = await ref
                          .read(DexPoolProviders.getPoolListRaw.future);

                      unawaited(
                        (await ref
                                .read(
                                  AccountProviders.accounts.notifier,
                                )
                                .selectedAccountNotifier)
                            ?.refreshRecentTransactions(poolListRaw),
                      );
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
        _btnExplorer(context, ref),
      ],
    );
  }

  Widget _btnExplorer(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            InkWell(
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: aedappfm.AppThemeBase.gradientBtn,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Symbols.open_in_new,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              onTap: () async {
                await launchUrl(
                  Uri.parse(
                    '${ref.read(SettingsProviders.settings).network.getLink()}/explorer/chain?address=${contact.genesisAddress}',
                  ),
                  mode: LaunchMode.externalApplication,
                );
              },
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              AppLocalizations.of(context)!.explorer,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}
