// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/dimens.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/widgets/buttons.dart';

class IntroBackupSafetyPage extends StatefulWidget {
  @override
  _IntroBackupSafetyState createState() => _IntroBackupSafetyState();
}

class _IntroBackupSafetyState extends State<IntroBackupSafetyPage> {
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
                //A widget that holds the header, the paragraph, the seed, "seed copied" text and the back button
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: smallScreen(context) ? 15 : 20),
                            height: 50,
                            width: 50,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: FaIcon(FontAwesomeIcons.chevronLeft,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .primary,
                                    size: 24)),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.only(
                          start: smallScreen(context) ? 30 : 40,
                          top: 15,
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.exclamationTriangle,
                          size: 60,
                          color: StateContainer.of(context).curTheme.primary,
                        ),
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
                          'Warning',
                          style: AppStyles.textStyleSize28W700Primary(context),
                          stepGranularity: 0.1,
                          maxLines: 1,
                          minFontSize: 12,
                        ),
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.only(
                            start: smallScreen(context) ? 30 : 40,
                            end: smallScreen(context) ? 30 : 40,
                            top: 15.0),
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'In the next screen, you will see your recovery phrase.',
                              style:
                                  AppStyles.textStyleSize16W600Primary(context),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              'What is a recovery phrase ?',
                              style:
                                  AppStyles.textStyleSize16W700Primary(context),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            AutoSizeText(
                              'A recovery phrase is essentially a human readable form of your crypto\'s wallet private key, and is displayed as 24 mnemonic words. After mastering the mnemonic words, you can restore your wallet at will. Please keep the words properly and don\'t leak them to anyone.',
                              style:
                                  AppStyles.textStyleSize16W600Primary(context),
                              maxLines: 5,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'How to back up ?',
                              style:
                                  AppStyles.textStyleSize16W700Primary(context),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            AutoSizeText(
                              'Write down the mnemonic words in the correct order on a piece of papier and store them in a safe place.\nPlease don\'t store the recovery phrase on electronic devices in any form, including sreenshot.\nRemember the safety of the recovery phrase is relevant to the safety of your digital assets',
                              style:
                                  AppStyles.textStyleSize16W600Primary(context),
                              maxLines: 5,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Insecure ways of backup',
                              style:
                                  AppStyles.textStyleSize16W700Primary(context),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '1. Screenshot\n2. Take a photo',
                              style:
                                  AppStyles.textStyleSize12W600Primary(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Next Screen Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AppButton.buildAppButton(
                        context,
                        AppButtonType.PRIMARY,
                        AppLocalization.of(context).understandButton,
                        Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                      Navigator.of(context).pushNamed('/intro_backup',
                          arguments:
                              StateContainer.of(context).encryptedSecret);
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
