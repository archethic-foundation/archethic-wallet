// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/ui/util/dimens.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/ui/util/styles.dart';
import 'package:archethic_wallet/ui/util/ui_util.dart';
import 'package:archethic_wallet/ui/widgets/components/buttons.dart';
import 'package:archethic_wallet/ui/widgets/components/icon_widget.dart';
import 'package:archethic_wallet/util/case_converter.dart';

class ReceiveSheet extends StatefulWidget {
  const ReceiveSheet({Key? key}) : super(key: key);

  @override
  _ReceiveSheetState createState() => _ReceiveSheetState();
}

class _ReceiveSheetState extends State<ReceiveSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
      child: Column(
        children: <Widget>[
          // A row for the address text and close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Empty SizedBox
              const SizedBox(
                width: 60,
                height: 0,
              ),
              Column(
                children: <Widget>[
                  // Sheet handle
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 5,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                      color: StateContainer.of(context).curTheme.primary60,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 140),
                    child: Column(
                      children: <Widget>[
                        // Header
                        AutoSizeText(
                          AppLocalization.of(context)!.receive,
                          style: AppStyles.textStyleSize24W700Primary(context),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          stepGranularity: 0.1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (kIsWeb || Platform.isMacOS || Platform.isWindows)
                Stack(
                  children: <Widget>[
                    const SizedBox(
                      width: 60,
                      height: 40,
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: 10, right: 0),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Column(
                              children: <Widget>[
                                buildIconDataWidget(
                                    context, Icons.close_outlined, 30, 30),
                              ],
                            ))),
                  ],
                )
              else
                const SizedBox(
                  width: 60,
                  height: 40,
                ),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Container(
                  margin: const EdgeInsets.only(top: 0, bottom: 10),
                  child: SafeArea(
                    minimum: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.035,
                    ),
                    child: Column(
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                text: StateContainer.of(context)
                                    .wallet!
                                    .address));
                            UIUtil.showSnackbar('Address copied', context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Material(
                              color: StateContainer.of(context)
                                  .curTheme
                                  .backgroundDarkest,
                              borderRadius: BorderRadius.circular(16),
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                            color: StateContainer.of(context)
                                                .curTheme
                                                .backgroundDarkest,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: QrImage(
                                            foregroundColor: Colors.white,
                                            data: StateContainer.of(context)
                                                .selectedAccount
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
                                                          .selectedAccount
                                                          .lastAddress!
                                                          .substring(0, 16),
                                                      context),
                                                  style: AppStyles
                                                      .textStyleSize12W100Primary(
                                                          context)),
                                              AutoSizeText(
                                                  CaseChange.toUpperCase(
                                                      StateContainer.of(context)
                                                          .selectedAccount
                                                          .lastAddress!
                                                          .substring(16, 32),
                                                      context),
                                                  style: AppStyles
                                                      .textStyleSize12W100Primary(
                                                          context)),
                                              AutoSizeText(
                                                  CaseChange.toUpperCase(
                                                      StateContainer.of(context)
                                                          .selectedAccount
                                                          .lastAddress!
                                                          .substring(32, 48),
                                                      context),
                                                  style: AppStyles
                                                      .textStyleSize12W100Primary(
                                                          context)),
                                              AutoSizeText(
                                                  CaseChange.toUpperCase(
                                                      StateContainer.of(context)
                                                          .selectedAccount
                                                          .lastAddress!
                                                          .substring(48),
                                                      context),
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
                      ],
                    ),
                  )),
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  AppButton.buildAppButton(context, AppButtonType.primary,
                      AppLocalization.of(context)!.copy, Dimens.buttonTopDimens,
                      icon: const Icon(Icons.copy), onPressed: () async {
                    Clipboard.setData(ClipboardData(
                        text: StateContainer.of(context).wallet!.address));
                    UIUtil.showSnackbar('Address copied', context);
                  }),
                ],
              ),
              Row(
                children: <Widget>[
                  AppButton.buildAppButton(
                      context,
                      AppButtonType.primary,
                      AppLocalization.of(context)!.share,
                      Dimens.buttonBottomDimens,
                      icon: const Icon(Icons.share), onPressed: () {
                    final RenderBox? box =
                        context.findRenderObject() as RenderBox?;
                    final String textToShare = StateContainer.of(context)
                        .selectedAccount
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
