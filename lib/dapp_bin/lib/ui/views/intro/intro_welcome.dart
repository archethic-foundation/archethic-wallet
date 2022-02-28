// Flutter imports:
// ignore_for_file: avoid_unnecessary_containers

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/appstate_container.dart';
import 'package:core/localization.dart';
import 'package:core/ui/util/dimens.dart';
import 'package:core/ui/util/styles.dart';
import 'package:core/ui/widgets/components/buttons.dart';
import 'package:core/util/app_util.dart';
import 'package:core/util/seeds.dart';
import 'package:core/util/vault.dart';
import 'package:flutter_svg/svg.dart';

class IntroWelcomePage extends StatefulWidget {
  const IntroWelcomePage({Key? key}) : super(key: key);

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
                  StateContainer.of(context).curTheme.backgroundDark!,
                  StateContainer.of(context).curTheme.background!
                ],
              ),
            ),
            child: StateContainer.of(context)
                .curTheme
                .getBackgroundScreen(context)!,
          ),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) =>
                SafeArea(
              minimum: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.035,
                  top: MediaQuery.of(context).size.height * 0.075),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0),
                                child: SizedBox(
                                  height: 200,
                                  child: kIsWeb
                                      ? Image.asset(
                                          StateContainer.of(context)
                                                  .curTheme
                                                  .assetsFolder! +
                                              StateContainer.of(context)
                                                  .curTheme
                                                  .logo! +
                                              '.png',
                                          height: 200,
                                        )
                                      : SvgPicture.asset(
                                          StateContainer.of(context)
                                                  .curTheme
                                                  .assetsFolder! +
                                              StateContainer.of(context)
                                                  .curTheme
                                                  .logo! +
                                              '.svg',
                                          height: 200,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 20, right: 20, left: 20),
                            child: AutoSizeText(
                              AppLocalization.of(context)!.welcomeText,
                              maxLines: 5,
                              style:
                                  AppStyles.textStyleSize24W600Primary(context),
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
                          AppButton.buildAppButton(
                              context,
                              AppButtonType.primary,
                              AppLocalization.of(context)!.newWallet,
                              Dimens.buttonTopDimens, onPressed: () {
                            Vault.getInstance().then((Vault _vault) {
                              final String _seed = AppSeeds.generateSeed();
                              _vault.setSeed(_seed);
                              AppUtil()
                                  .loginAccount(_seed, context,
                                      forceNewAccount: true)
                                  .then((_) {
                                Navigator.of(context).pushNamed(
                                  '/intro_backup_safety',
                                );
                              });
                            });
                          }),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          // Import Wallet Button
                          AppButton.buildAppButton(
                              context,
                              AppButtonType.primary,
                              AppLocalization.of(context)!.importWallet,
                              Dimens.buttonBottomDimens, onPressed: () {
                            Navigator.of(context).pushNamed('/intro_import');
                          }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
