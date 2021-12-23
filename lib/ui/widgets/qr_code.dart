// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/util/ui_util.dart';

// ignore: avoid_classes_with_only_static_members
class QRcodeDisplay {
  static Widget buildQRCodeDisplay(
      BuildContext context, Animation<double> _opacityAnimation) {
    return StateContainer.of(context).selectedAccount.lastAddress == null
        ? const SizedBox()
        : Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.70,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 185,
                  decoration: BoxDecoration(
                    color:
                        StateContainer.of(context).curTheme.backgroundDarkest,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: StateContainer.of(context)
                            .curTheme
                            .backgroundDarkest!,
                        blurRadius: 5.0,
                        spreadRadius: 0.0,
                        offset: const Offset(
                            5.0, 5.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: QrImage(
                                foregroundColor: Colors.white,
                                data: StateContainer.of(context)
                                    .selectedAccount
                                    .lastAddress!,
                                version: QrVersions.auto,
                                size: 100.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                  child: Text(
                    AppLocalization.of(context)!.addressInfos,
                    style: AppStyles.textStyleSize12W100Primary60(context),
                  ),
                ),
              ),
            ],
          );
  }

  static Widget buildAddressDisplay(
      BuildContext context, Animation<double> _opacityAnimation) {
    return StateContainer.of(context).selectedAccount.lastAddress == null ||
            StateContainer.of(context).selectedAccount.lastAddress == ''
        ? const SizedBox()
        : Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.70,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 185,
                  decoration: BoxDecoration(
                    color:
                        StateContainer.of(context).curTheme.backgroundDarkest,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: StateContainer.of(context)
                            .curTheme
                            .backgroundDarkest!,
                        blurRadius: 5.0,
                        spreadRadius: 0.0,
                        offset: const Offset(
                            5.0, 5.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                    StateContainer.of(context)
                                        .selectedAccount
                                        .lastAddress!
                                        .substring(0, 16),
                                    style: AppStyles.textStyleSize14W100Primary(
                                        context)),
                                Text(
                                    StateContainer.of(context)
                                        .selectedAccount
                                        .lastAddress!
                                        .substring(16, 32),
                                    style: AppStyles.textStyleSize14W100Primary(
                                        context)),
                                Text(
                                    StateContainer.of(context)
                                        .selectedAccount
                                        .lastAddress!
                                        .substring(32, 48),
                                    style: AppStyles.textStyleSize14W100Primary(
                                        context)),
                                Text(
                                    StateContainer.of(context)
                                        .selectedAccount
                                        .lastAddress!
                                        .substring(48),
                                    style: AppStyles.textStyleSize14W100Primary(
                                        context)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                  child: Text(
                    AppLocalization.of(context)!.addressInfos,
                    style: AppStyles.textStyleSize12W100Primary(context),
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 165.0, top: 90.0),
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                            text: StateContainer.of(context).wallet!.address));
                        UIUtil.showSnackbar('Address copied', context);
                      },
                      child: FaIcon(FontAwesomeIcons.solidCopy,
                          color: StateContainer.of(context).curTheme.primary),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
