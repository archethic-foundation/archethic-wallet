// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show uint8ListToHex;
import 'package:flutter_svg/svg.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/dimens.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/model/vault.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/widgets/buttons.dart';
import 'package:archethic_mobile_wallet/util/app_ffi/apputil.dart';
import 'package:archethic_mobile_wallet/util/app_ffi/encrypt/crypter.dart';
import 'package:archethic_mobile_wallet/util/app_ffi/keys/seeds.dart';

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
                  StateContainer.of(context).curTheme.backgroundDark!,
                  StateContainer.of(context).curTheme.background!
                ],
              ),
            ),
            child: StateContainer.of(context)
                .curTheme
                .getBackgroundScreen(context)!,
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
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.width * 5 / 8,
                              child: Center(
                                child: Container(
                                  child: SizedBox(
                                    height: 300,
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
                              margin: EdgeInsets.symmetric(
                                  horizontal: smallScreen(context) ? 30 : 40,
                                  vertical: 20),
                              child: Text(
                                AppLocalization.of(context)!.welcomeText,
                                style: AppStyles.textStyleSize14W600Primary(
                                    context),
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
                                AppButtonType.PRIMARY,
                                AppLocalization.of(context)!.newWallet,
                                Dimens.BUTTON_TOP_DIMENS, onPressed: () {
                              sl
                                  .get<Vault>()
                                  .setSeed(AppSeeds.generateSeed())
                                  .then((String result) {
                                StateContainer.of(context)
                                    .getSeed()
                                    .then((String seed) async {
                                  StateContainer.of(context).setEncryptedSecret(
                                      uint8ListToHex(AppCrypt.encrypt(
                                          seed,
                                          await sl
                                              .get<Vault>()
                                              .getSessionKey())!));
                                  AppUtil()
                                      .loginAccount(seed, context,
                                          forceNewAccount: true)
                                      .then((_) {
                                    Navigator.of(context).pushNamed(
                                      '/intro_backup_safety',
                                    );
                                  });
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
                                AppButtonType.PRIMARY,
                                AppLocalization.of(context)!.importWallet,
                                Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
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
          ),
        ],
      ),
    );
  }
}
