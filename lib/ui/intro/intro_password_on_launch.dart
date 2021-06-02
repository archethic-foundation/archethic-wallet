// @dart=2.9

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:uniris_mobile_wallet/appstate_container.dart';
import 'package:uniris_mobile_wallet/dimens.dart';
import 'package:uniris_mobile_wallet/model/db/appdb.dart';
import 'package:uniris_mobile_wallet/styles.dart';
import 'package:uniris_mobile_wallet/localization.dart';
import 'package:uniris_mobile_wallet/app_icons.dart';
import 'package:uniris_mobile_wallet/service_locator.dart';
import 'package:uniris_mobile_wallet/ui/widgets/buttons.dart';
import 'package:uniris_mobile_wallet/ui/widgets/security.dart';
import 'package:uniris_mobile_wallet/util/app_ffi/apputil.dart';
import 'package:uniris_mobile_wallet/model/vault.dart';
import 'package:uniris_mobile_wallet/util/app_ffi/keys/seeds.dart';
import 'package:uniris_mobile_wallet/util/sharedprefsutil.dart';

class IntroPasswordOnLaunch extends StatefulWidget {
  final String seed;

  IntroPasswordOnLaunch({this.seed});
  @override
  _IntroPasswordOnLaunchState createState() => _IntroPasswordOnLaunchState();
}

class _IntroPasswordOnLaunchState extends State<IntroPasswordOnLaunch> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              StateContainer.of(context).curTheme.backgroundDark,
              StateContainer.of(context).curTheme.background
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) => SafeArea(
            minimum: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.035,
                top: MediaQuery.of(context).size.height * 0.075),
            child: Column(
              children: <Widget>[
                //A widget that holds the header, the paragraph and Back Button
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          // Back Button
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: smallScreen(context) ? 15 : 20),
                            height: 50,
                            width: 50,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(AppIcons.back,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .text,
                                    size: 24)),
                          ),
                        ],
                      ),
                      // The header
                      Container(
                        margin: EdgeInsetsDirectional.only(
                          start: smallScreen(context) ? 30 : 40,
                          end: smallScreen(context) ? 30 : 40,
                          top: 10,
                        ),
                        alignment: AlignmentDirectional(-1, 0),
                        child: AutoSizeText(
                          AppLocalization.of(context)
                              .requireAPasswordToOpenHeader,
                          maxLines: 3,
                          stepGranularity: 0.5,
                          style: AppStyles.textStyleHeaderColored(context),
                        ),
                      ),
                      // The paragraph
                      Container(
                        margin: EdgeInsetsDirectional.only(
                            start: smallScreen(context) ? 30 : 40,
                            end: smallScreen(context) ? 30 : 40,
                            top: 16.0),
                        child: AutoSizeText(
                          AppLocalization.of(context)
                              .createPasswordFirstParagraph,
                          style: AppStyles.textStyleParagraph(context),
                          maxLines: 5,
                          stepGranularity: 0.5,
                        ),
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.only(
                            start: smallScreen(context) ? 30 : 40,
                            end: smallScreen(context) ? 30 : 40,
                            top: 20),
                        child: AutoSizeText(
                          AppLocalization.of(context)
                              .createPasswordSecondParagraph,
                          style: AppStyles.textStyleParagraphPrimary(context),
                          maxLines: 5,
                          stepGranularity: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                //A column with "Skip" and "Yes" buttons
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        // Skip Button
                        AppButton.buildAppButton(
                            context,
                            AppButtonType.PRIMARY,
                            AppLocalization.of(context).noSkipButton,
                            Dimens.BUTTON_TOP_DIMENS, onPressed: () async {
                          if (widget.seed != null) {
                            await sl.get<Vault>().setSeed(widget.seed);
                            await sl.get<DBHelper>().dropAccounts();
                            await AppUtil().loginAccount(widget.seed, context);
                            StateContainer.of(context).requestUpdate();
                            String pin = await Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                              return PinScreen(
                                PinOverlayType.NEW_PIN,
                              );
                            }));
                            if (pin != null && pin.length > 5) {
                              _pinEnteredCallback(pin);
                            }
                          } else {
                            sl
                                .get<Vault>()
                                .setSeed(AppSeeds.generateSeed())
                                .then((result) {
                              // Update wallet
                              StateContainer.of(context).getSeed().then((seed) {
                                AppUtil().loginAccount(seed, context).then((_) {
                                  StateContainer.of(context).requestUpdate();
                                  Navigator.of(context)
                                      .pushNamed('/intro_backup_safety');
                                });
                              });
                            });
                          }
                        }),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        // Yes BUTTON
                        AppButton.buildAppButton(
                            context,
                            AppButtonType.PRIMARY,
                            AppLocalization.of(context).yes,
                            Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                          Navigator.of(context).pushNamed('/intro_password',
                              arguments: widget.seed);
                        }),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _pinEnteredCallback(String pin) async {
    await sl.get<Vault>().writePin(pin);
    PriceConversion conversion =
        await sl.get<SharedPrefsUtil>().getPriceConversion();
    // Update wallet
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/home', (Route<dynamic> route) => false,
        arguments: conversion);
  }
}
