/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/util/case_converter.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';

class ReceiveSheet extends StatelessWidget {
  const ReceiveSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
      child: Column(
        children: <Widget>[
          SheetHeader(
            title: AppLocalization.of(context)!.receive,
            widgetRight: Container(
              width: 60,
              height: 50,
              margin: const EdgeInsetsDirectional.only(top: 10.0, start: 10.0),
              child: TextButton(
                onPressed: () {
                  sl.get<HapticUtil>().feedback(FeedbackType.light,
                      StateContainer.of(context).activeVibrations);
                  Clipboard.setData(ClipboardData(
                      text: StateContainer.of(context)
                          .appWallet!
                          .appKeychain!
                          .getAccountSelected()!
                          .lastAddress!));
                  UIUtil.showSnackbar(
                      AppLocalization.of(context)!.addressCopied,
                      context,
                      StateContainer.of(context).curTheme.text!,
                      StateContainer.of(context).curTheme.snackBarShadow!);
                },
                child: FaIcon(FontAwesomeIcons.paste,
                    size: 24, color: StateContainer.of(context).curTheme.text),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: SafeArea(
                minimum: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.035,
                ),
                child: Column(
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        sl.get<HapticUtil>().feedback(FeedbackType.light,
                            StateContainer.of(context).activeVibrations);
                        Clipboard.setData(ClipboardData(
                            text: StateContainer.of(context)
                                .appWallet!
                                .appKeychain!
                                .getAccountSelected()!
                                .lastAddress!));
                        UIUtil.showSnackbar(
                            AppLocalization.of(context)!.addressCopied,
                            context,
                            StateContainer.of(context).curTheme.text!,
                            StateContainer.of(context)
                                .curTheme
                                .snackBarShadow!);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(16),
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 200,
                                        margin: const EdgeInsets.all(8),
                                        child: AutoSizeText(
                                          AppLocalization.of(context)!
                                              .addressInfos,
                                          style: AppStyles
                                              .textStyleSize16W700Primary(
                                                  context),
                                        ),
                                      ),
                                      Container(
                                        width: 150,
                                        height: 150,
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: QrImage(
                                          foregroundColor:
                                              StateContainer.of(context)
                                                  .curTheme
                                                  .text,
                                          data: StateContainer.of(context)
                                              .appWallet!
                                              .appKeychain!
                                              .getAccountSelected()!
                                              .lastAddress!,
                                          version: QrVersions.auto,
                                          size: 150.0,
                                          gapless: false,
                                        ),
                                      ),
                                      Container(
                                        width: 200,
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.all(8),
                                        child: Column(
                                          children: <Widget>[
                                            AutoSizeText(
                                                CaseChange.toUpperCase(
                                                    StateContainer.of(context)
                                                        .appWallet!
                                                        .appKeychain!
                                                        .getAccountSelected()!
                                                        .lastAddress!
                                                        .substring(0, 16),
                                                    StateContainer.of(context)
                                                        .curLanguage
                                                        .getLocaleString()),
                                                style: AppStyles
                                                    .textStyleSize12W100Primary(
                                                        context)),
                                            AutoSizeText(
                                                CaseChange.toUpperCase(
                                                    StateContainer.of(context)
                                                        .appWallet!
                                                        .appKeychain!
                                                        .getAccountSelected()!
                                                        .lastAddress!
                                                        .substring(16, 32),
                                                    StateContainer.of(context)
                                                        .curLanguage
                                                        .getLocaleString()),
                                                style: AppStyles
                                                    .textStyleSize12W100Primary(
                                                        context)),
                                            AutoSizeText(
                                                CaseChange.toUpperCase(
                                                    StateContainer.of(context)
                                                        .appWallet!
                                                        .appKeychain!
                                                        .getAccountSelected()!
                                                        .lastAddress!
                                                        .substring(32, 48),
                                                    StateContainer.of(context)
                                                        .curLanguage
                                                        .getLocaleString()),
                                                style: AppStyles
                                                    .textStyleSize12W100Primary(
                                                        context)),
                                            AutoSizeText(
                                                CaseChange.toUpperCase(
                                                    StateContainer.of(context)
                                                        .appWallet!
                                                        .appKeychain!
                                                        .getAccountSelected()!
                                                        .lastAddress!
                                                        .substring(48),
                                                    StateContainer.of(context)
                                                        .curLanguage
                                                        .getLocaleString()),
                                                style: AppStyles
                                                    .textStyleSize12W100Primary(
                                                        context)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  AppButton.buildAppButton(
                      const Key('viewExplorer'),
                      context,
                      AppButtonType.primary,
                      AppLocalization.of(context)!.viewExplorer,
                      Dimens.buttonTopDimens,
                      icon: Icon(
                        Icons.more_horiz,
                        color: StateContainer.of(context).curTheme.text,
                      ), onPressed: () async {
                    UIUtil.showWebview(
                        context,
                        '${await StateContainer.of(context).curNetwork.getLink()}/explorer/transaction/${StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.lastAddress!}',
                        '');
                  }),
                ],
              ),
              Row(
                children: <Widget>[
                  AppButton.buildAppButton(
                      const Key('share'),
                      context,
                      AppButtonType.primary,
                      AppLocalization.of(context)!.share,
                      Dimens.buttonBottomDimens,
                      icon: Icon(
                        Icons.share,
                        color: StateContainer.of(context).curTheme.text,
                      ), onPressed: () {
                    final RenderBox? box =
                        context.findRenderObject() as RenderBox?;
                    final String textToShare = StateContainer.of(context)
                        .appWallet!
                        .appKeychain!
                        .getAccountSelected()!
                        .lastAddress!
                        .toUpperCase();
                    Share.share(textToShare,
                        sharePositionOrigin:
                            box!.localToGlobal(Offset.zero) & box.size);
                  }),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
