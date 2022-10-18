/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/account.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/transfer/bloc/model.dart';
import 'package:aewallet/ui/views/transfer/layouts/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/components/app_button.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactDetail extends ConsumerWidget {
  const ContactDetail({required this.contact, super.key});

  final Contact contact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final accountSelected =
        ref.read(AccountProviders.getSelectedAccount(context: context));
    final preferences = ref.watch(SettingsProviders.settings);

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
                child: contact.type == 'keychainService'
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
                              contact.name!.replaceFirst('@', ''),
                            ),
                            localizations.yes,
                            () {
                              ref.read(
                                ContactProviders.deleteContact(
                                  contact: contact,
                                ),
                              );
                              StateContainer.of(context)
                                  .requestUpdate(forceUpdateChart: false);
                              UIUtil.showSnackbar(
                                localizations.contactRemoved.replaceAll(
                                  '%1',
                                  contact.name!.replaceFirst('@', ''),
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
                          FontAwesomeIcons.trash,
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
                      localizations.contactHeader,
                      style: theme.textStyleSize24W700EquinoxPrimary,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      stepGranularity: 0.1,
                    ),
                  ],
                ),
              ),
              Container(
                width: 50,
                height: 50,
                margin: const EdgeInsetsDirectional.only(
                  top: 10,
                  start: 10,
                ),
                child: TextButton(
                  onPressed: () {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          preferences.activeVibrations,
                        );
                    Clipboard.setData(
                      ClipboardData(text: contact.address),
                    );
                    UIUtil.showSnackbar(
                      localizations.addressCopied,
                      context,
                      ref,
                      theme.text!,
                      theme.snackBarShadow!,
                    );
                  },
                  child: FaIcon(
                    FontAwesomeIcons.paste,
                    size: 24,
                    color: theme.text,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsetsDirectional.only(
                top: 4,
                bottom: 12,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    contact.name!.replaceFirst('@', ''),
                    textAlign: TextAlign.center,
                    style: theme.textStyleSize16W600Primary,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsetsDirectional.only(
                      top: 4,
                      bottom: 12,
                    ),
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.105,
                      right: MediaQuery.of(context).size.width * 0.105,
                    ),
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: theme.gradient,
                    ),
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      sl.get<HapticUtil>().feedback(
                            FeedbackType.light,
                            preferences.activeVibrations,
                          );
                      Clipboard.setData(
                        ClipboardData(text: contact.address),
                      );
                      UIUtil.showSnackbar(
                        localizations.addressCopied,
                        context,
                        ref,
                        theme.text!,
                        theme.snackBarShadow!,
                      );
                    },
                    child: UIUtil.threeLinetextStyleSmallestW400Text(
                      context,
                      ref,
                      contact.address!,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsetsDirectional.only(
                      top: 4,
                      bottom: 12,
                    ),
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.105,
                      right: MediaQuery.of(context).size.width * 0.105,
                    ),
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: theme.gradient,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (accountSelected!.name != contact.name!.replaceFirst('@', ''))
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // Send Button
                    if (StateContainer.of(context)
                        .appWallet!
                        .appKeychain!
                        .getAccountSelected()!
                        .balance!
                        .isNativeTokenValuePositive())
                      AppButton(
                        AppButtonType.primary,
                        localizations.send,
                        Dimens.buttonTopDimens,
                        key: const Key('send'),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          Sheets.showAppHeightNineSheet(
                            context: context,
                            ref: ref,
                            widget: TransferSheet(
                              transferType: TransferType.uco,
                              seed:
                                  (await StateContainer.of(context).getSeed())!,
                              contact: contact,
                            ),
                          );
                        },
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
