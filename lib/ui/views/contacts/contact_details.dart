/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/contact_repository.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/uco/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
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
    final theme = StateContainer.of(context).curTheme;

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
                child: TextButton(
                  onPressed: () {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          StateContainer.of(context).activeVibrations,
                        );
                    AppDialogs.showConfirmDialog(
                      context,
                      localizations.removeContact,
                      localizations.removeContactConfirmation
                          .replaceAll('%1', contact.name!),
                      localizations.yes,
                      () async {
                        ContactProviders.deleteContact(contact: contact);
                        StateContainer.of(context)
                            .requestUpdate(forceUpdateChart: false);
                        UIUtil.showSnackbar(
                          localizations.contactRemoved
                              .replaceAll('%1', contact.name!),
                          context,
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
                      style: AppStyles.textStyleSize24W700EquinoxPrimary(
                        context,
                      ),
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
                          StateContainer.of(context).activeVibrations,
                        );
                    Clipboard.setData(
                      ClipboardData(text: contact.address),
                    );
                    UIUtil.showSnackbar(
                      localizations.addressCopied,
                      context,
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
                    contact.name!,
                    textAlign: TextAlign.center,
                    style: AppStyles.textStyleSize16W600Primary(
                      context,
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
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      sl.get<HapticUtil>().feedback(
                            FeedbackType.light,
                            StateContainer.of(context).activeVibrations,
                          );
                      Clipboard.setData(
                        ClipboardData(text: contact.address),
                      );
                      UIUtil.showSnackbar(
                        localizations.addressCopied,
                        context,
                        theme.text!,
                        theme.snackBarShadow!,
                      );
                    },
                    child: UIUtil.threeLinetextStyleSmallestW400Text(
                      context,
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
                    AppButton.buildAppButton(
                      const Key('send'),
                      context,
                      AppButtonType.primary,
                      localizations.send,
                      Dimens.buttonTopDimens,
                      onPressed: () {
                        Navigator.of(context).pop();
                        Sheets.showAppHeightNineSheet(
                          context: context,
                          widget: TransferSheet(
                            primaryCurrency:
                                StateContainer.of(context).curPrimaryCurrency,
                            localCurrency:
                                StateContainer.of(context).curCurrency,
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
