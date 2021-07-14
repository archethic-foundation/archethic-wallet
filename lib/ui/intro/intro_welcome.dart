// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/dimens.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/util/particles/particles_flutter.dart';
import 'package:archethic_mobile_wallet/ui/widgets/archethic_text.dart';
import 'package:archethic_mobile_wallet/ui/widgets/buttons.dart';

class IntroWelcomePage extends StatefulWidget {
  @override
  _IntroWelcomePageState createState() => _IntroWelcomePageState();
}

class _IntroWelcomePageState extends State<IntroWelcomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
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
            child: CircularParticle(
              awayRadius: 80,
              numberOfParticles: 80,
              speedOfParticles: 0.5,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              onTapAnimation: true,
              particleColor: StateContainer.of(context)
                  .curTheme
                  .primary10
                  .withAlpha(150)
                  .withOpacity(0.2),
              awayAnimationDuration: const Duration(milliseconds: 600),
              maxParticleSize: 8,
              isRandSize: true,
              isRandomColor: false,
              awayAnimationCurve: Curves.easeInOutBack,
              enableHover: true,
              hoverColor: StateContainer.of(context).curTheme.primary30,
              hoverRadius: 90,
              connectDots: true,
            ),
          ),
          Container(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  SafeArea(
                minimum: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.035,
                  top: MediaQuery.of(context).size.height * 0.10,
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            //
                            width: double.infinity,
                            height: MediaQuery.of(context).size.width * 5 / 8,
                            child: Center(
                              child: ArchEthicText.getLabel(context),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: smallScreen(context) ? 30 : 40,
                                vertical: 20),
                            child: AutoSizeText(
                              AppLocalization.of(context).welcomeText,
                              style: AppStyles.textStyleParagraph(context),
                              maxLines: 4,
                              stepGranularity: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //A column with "New Wallet" and "Import Wallet" buttons
                    Column(
                      children: <Widget>[
                        /*Row(
                    children: <Widget>[
                      // New Wallet Button
                      AppButton.buildAppButton(
                          context,
                          AppButtonType.PRIMARY,
                          AppLocalization.of(context).newWallet,
                          Dimens.BUTTON_TOP_DIMENS, onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/intro_password_on_launch');
                      }),
                    ],
                  ),*/
                        Row(
                          children: <Widget>[
                            // Import Wallet Button
                            AppButton.buildAppButton(
                                context,
                                AppButtonType.PRIMARY,
                                AppLocalization.of(context).nextButton,
                                Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                              Navigator.of(context).pushNamed(
                                  '/intro_enter_transaction_address');
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
        ],
      ),
    );
  }
}
