// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:archethic_mobile_wallet/app_icons.dart';
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/dimens.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/model/db/appdb.dart';
import 'package:archethic_mobile_wallet/model/vault.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/widgets/buttons.dart';
import 'package:archethic_mobile_wallet/ui/widgets/pin_screen.dart';
import 'package:archethic_mobile_wallet/util/app_ffi/apputil.dart';
import 'package:archethic_mobile_wallet/util/app_ffi/keys/seeds.dart';
import 'package:archethic_mobile_wallet/util/sharedprefsutil.dart';

class IntroPasswordOnLaunch extends StatefulWidget {
  final String seed;

  const IntroPasswordOnLaunch({this.seed});
  @override
  _IntroPasswordOnLaunchState createState() => _IntroPasswordOnLaunchState();
}

class _IntroPasswordOnLaunchState extends State<IntroPasswordOnLaunch> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
            colors: <Color>[
              StateContainer.of(context).curTheme.backgroundDark,
              StateContainer.of(context).curTheme.background
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SafeArea(
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
                                        .primary,
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
                        alignment: const AlignmentDirectional(-1, 0),
                        child: AutoSizeText(
                          AppLocalization.of(context)
                              .requireAPasswordToOpenHeader,
                          maxLines: 3,
                          stepGranularity: 0.5,
                          style: AppStyles.textStyleLargestW700Primary(context),
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
                          style: AppStyles.textStyleMediumW200Primary(context),
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
                          style: AppStyles.textStyleMediumW700Primary(context),
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
                            StateContainer.of(context).requestUpdate(StateContainer.of(context).selectedAccount);
                            final String pin = await Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                              return const PinScreen(
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
                                .then((String result) {
                              // Update wallet
                              StateContainer.of(context)
                                  .getSeed()
                                  .then((String seed) {
                                AppUtil().loginAccount(seed, context).then((_) {
                                  StateContainer.of(context).requestUpdate(StateContainer.of(context).selectedAccount);
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

  Future<void> _pinEnteredCallback(String pin) async {
    await sl.get<Vault>().writePin(pin);
    final PriceConversion conversion =
        await sl.get<SharedPrefsUtil>().getPriceConversion();
    // Update wallet
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/home', (Route<dynamic> route) => false,
        arguments: conversion);
  }
}
