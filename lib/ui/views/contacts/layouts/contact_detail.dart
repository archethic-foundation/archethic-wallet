/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/contacts/layouts/components/contact_detail_tab.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactDetail extends ConsumerWidget {
  const ContactDetail({
    required this.contact,
    super.key,
  });

  final Contact contact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final _contact = ref.watch(
      ContactProviders.getContactWithName(
        contact.name,
      ),
    );
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    return SafeArea(
      minimum: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.035,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                margin: const EdgeInsetsDirectional.only(
                  top: 10,
                  start: 10,
                ),
                child: contact.type == ContactType.keychainService.name
                    ? const SizedBox()
                    : TextButton(
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
                              );
                              Navigator.of(context).pop();
                            },
                            cancelText: localizations.no,
                          );
                        },
                        child: FaIcon(
                          UiIcons.trash,
                          size: 24,
                          color: theme.text,
                        ),
                      ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 25),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 140,
                ),
                child: Column(
                  children: <Widget>[
                    AutoSizeText(
                      contact.format,
                      style: theme.textStyleSize24W700EquinoxPrimary,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      stepGranularity: 0.1,
                    ),
                  ],
                ),
              ),
              if (contact.type == ContactType.keychainService.name)
                const SizedBox(
                  width: 50,
                  height: 50,
                )
              else
                Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsetsDirectional.only(
                    top: 10,
                    end: 10,
                  ),
                  child: InkWell(
                    onTap: () async {
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
                    child: _contact.maybeWhen(
                      data: (data) {
                        return data.favorite == null || data.favorite == false
                            ? Icon(
                                Icons.favorite_border,
                                color: theme.favoriteIconColor,
                                size: 26,
                              )
                            : Icon(
                                Icons.favorite,
                                color: theme.favoriteIconColor,
                                size: 26,
                              );
                      },
                      loading: () => const SizedBox(),
                      orElse: () => const SizedBox(),
                    ),
                  ),
                ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: ContainedTabBarView(
                tabBarProperties: TabBarProperties(
                  indicatorColor: theme.backgroundDarkest,
                ),
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
                views: [
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
          ),
          if (contact.name != contact.format)
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    if (connectivityStatusProvider ==
                        ConnectivityStatus.isConnected)
                      AppButtonTiny(
                        AppButtonTinyType.primary,
                        localizations.viewExplorer,
                        Dimens.buttonBottomDimens,
                        icon: Icon(
                          Icons.more_horiz,
                          color: theme.mainButtonLabel,
                          size: 14,
                        ),
                        key: const Key('viewExplorer'),
                        onPressed: () async {
                          UIUtil.showWebview(
                            context,
                            '${ref.read(SettingsProviders.settings).network.getLink()}/explorer/transaction/${contact.address}',
                            '',
                          );
                        },
                      )
                    else
                      AppButtonTiny(
                        AppButtonTinyType.primaryOutline,
                        localizations.viewExplorer,
                        Dimens.buttonBottomDimens,
                        icon: Icon(
                          Icons.more_horiz,
                          color: theme.mainButtonLabel!.withOpacity(0.3),
                          size: 14,
                        ),
                        key: const Key('viewExplorer'),
                        onPressed: () {},
                      ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
