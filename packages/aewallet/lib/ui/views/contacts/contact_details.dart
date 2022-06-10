/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/util/ui_util.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/dialog.dart';
import 'package:aeuniverse/ui/widgets/components/sheet_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/model/data/hive_db.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/haptic_util.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:core_ui/util/case_converter.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:aewallet/bus/contact_modified_event.dart';
import 'package:aewallet/bus/contact_removed_event.dart';
import 'package:aewallet/ui/views/tokens/transfer_tokens_sheet.dart';

// Contact Details Sheet
class ContactDetailsSheet {
  ContactDetailsSheet(this.contact);

  Contact contact;

  void mainBottomSheet(BuildContext context) {
    Sheets.showAppHeightEightSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SafeArea(
                minimum: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.035),
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
                              top: 10.0, start: 10.0),
                          child: TextButton(
                            onPressed: () {
                              sl.get<HapticUtil>().feedback(FeedbackType.light);
                              AppDialogs.showConfirmDialog(
                                  context,
                                  AppLocalization.of(context)!.removeContact,
                                  AppLocalization.of(context)!
                                      .removeContactConfirmation
                                      .replaceAll('%1', contact.name!),
                                  CaseChange.toUpperCase(
                                      AppLocalization.of(context)!.yes,
                                      StateContainer.of(context)
                                          .curLanguage
                                          .getLocaleString()), () {
                                sl
                                    .get<DBHelper>()
                                    .deleteContact(contact)
                                    .then((_) {
                                  EventTaxiImpl.singleton().fire(
                                      ContactRemovedEvent(contact: contact));
                                  EventTaxiImpl.singleton().fire(
                                      ContactModifiedEvent(contact: contact));
                                  UIUtil.showSnackbar(
                                      AppLocalization.of(context)!
                                          .contactRemoved
                                          .replaceAll('%1', contact.name!),
                                      context,
                                      StateContainer.of(context)
                                          .curTheme
                                          .primary!,
                                      StateContainer.of(context)
                                          .curTheme
                                          .overlay80!);
                                  Navigator.of(context).pop();
                                });
                              },
                                  cancelText: CaseChange.toUpperCase(
                                      AppLocalization.of(context)!.no,
                                      StateContainer.of(context)
                                          .curLanguage
                                          .getLocaleString()));
                            },
                            child: FaIcon(FontAwesomeIcons.trash,
                                size: 24,
                                color: StateContainer.of(context)
                                    .curTheme
                                    .primary),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 25.0),
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width - 140),
                          child: Column(
                            children: <Widget>[
                              AutoSizeText(
                                AppLocalization.of(context)!.contactHeader,
                                style:
                                    AppStyles.textStyleSize24W700EquinoxPrimary(
                                        context),
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
                              top: 10.0, start: 10.0),
                          child: TextButton(
                            onPressed: () {
                              sl.get<HapticUtil>().feedback(FeedbackType.light);
                              Clipboard.setData(
                                  ClipboardData(text: contact.address));
                              UIUtil.showSnackbar(
                                  AppLocalization.of(context)!.addressCopied,
                                  context,
                                  StateContainer.of(context).curTheme.primary!,
                                  StateContainer.of(context)
                                      .curTheme
                                      .overlay80!);
                            },
                            child: FaIcon(FontAwesomeIcons.paste,
                                size: 24,
                                color: StateContainer.of(context)
                                    .curTheme
                                    .primary),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsetsDirectional.only(
                            top: 4, bottom: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(contact.name!,
                                textAlign: TextAlign.center,
                                style: AppStyles.textStyleSize16W600Primary(
                                    context)),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsetsDirectional.only(
                                  top: 4, bottom: 12),
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.105,
                                right:
                                    MediaQuery.of(context).size.width * 0.105,
                              ),
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                gradient: StateContainer.of(context)
                                    .curTheme
                                    .gradient!,
                              ),
                            ),
                            const SizedBox(height: 50),
                            GestureDetector(
                              onTap: () {
                                sl
                                    .get<HapticUtil>()
                                    .feedback(FeedbackType.light);
                                Clipboard.setData(
                                    ClipboardData(text: contact.address));
                                UIUtil.showSnackbar(
                                    AppLocalization.of(context)!.addressCopied,
                                    context,
                                    StateContainer.of(context)
                                        .curTheme
                                        .primary!,
                                    StateContainer.of(context)
                                        .curTheme
                                        .overlay80!);
                              },
                              child: UIUtil.threeLinetextStyleSmallestW400Text(
                                  context, contact.address!,
                                  type: ThreeLineAddressTextType.primary),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsetsDirectional.only(
                                  top: 4, bottom: 12),
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.105,
                                right:
                                    MediaQuery.of(context).size.width * 0.105,
                              ),
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                gradient: StateContainer.of(context)
                                    .curTheme
                                    .gradient!,
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
                                    .wallet!
                                    .accountBalance
                                    .networkCurrencyValue! >
                                0)
                              AppButton.buildAppButton(
                                  const Key('send'),
                                  context,
                                  AppButtonType.primary,
                                  AppLocalization.of(context)!.send,
                                  Dimens.buttonTopDimens, onPressed: () {
                                Navigator.of(context).pop();
                                Sheets.showAppHeightNineSheet(
                                    context: context,
                                    widget: TransferTokensSheet(
                                        primaryCurrency:
                                            StateContainer.of(context)
                                                .curPrimaryCurrency,
                                        localCurrency:
                                            StateContainer.of(context)
                                                .curCurrency,
                                        contact: contact));
                              })
                            else
                              const SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ));
          });
        });
  }
}
