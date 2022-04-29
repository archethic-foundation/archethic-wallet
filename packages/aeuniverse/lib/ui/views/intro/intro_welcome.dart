/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: avoid_unnecessary_containers

// Flutter imports:
import 'package:aeuniverse/ui/util/ui_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/data/hive_db.dart';
import 'package:core/util/seeds.dart';
import 'package:core/util/vault.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:core_ui/util/app_util.dart';
import 'package:flutter_svg/svg.dart';

class IntroWelcome extends StatefulWidget {
  const IntroWelcome({Key? key}) : super(key: key);

  @override
  _IntroWelcomeState createState() => _IntroWelcomeState();
}

class _IntroWelcomeState extends State<IntroWelcome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool checkedValue = false;

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
                                  child: AspectRatio(
                                    aspectRatio: 3 / 1,
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
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 20, right: 20, left: 20),
                            child: AutoSizeText(
                              AppLocalization.of(context)!.welcomeText,
                              maxLines: 5,
                              style:
                                  AppStyles.textStyleSize20W700Primary(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: CheckboxListTile(
                                    title: Text(
                                        AppLocalization.of(context)!
                                            .welcomeDisclaimerChoice,
                                        style: AppStyles
                                            .textStyleSize14W600Primary(
                                                context)),
                                    value: checkedValue,
                                    tristate: false,
                                    onChanged: (newValue) {
                                      setState(() {
                                        checkedValue = newValue!;
                                      });
                                    },
                                    checkColor: StateContainer.of(context)
                                        .curTheme
                                        .background,
                                    activeColor: StateContainer.of(context)
                                        .curTheme
                                        .primary,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    secondary: IconButton(
                                        icon: Icon(Icons.search),
                                        iconSize: 30,
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .backgroundDarkest,
                                        onPressed: () {
                                          UIUtil.showWebview(
                                              context,
                                              'https://archethic.net',
                                              AppLocalization.of(context)!
                                                  .welcomeDisclaimerLink);
                                        }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          AppButton.buildAppButton(
                            const Key('newWallet'),
                            context,
                            checkedValue
                                ? AppButtonType.primary
                                : AppButtonType.primaryOutline,
                            AppLocalization.of(context)!.newWallet,
                            Dimens.buttonTopDimens,
                            onPressed: () {
                              if (checkedValue) {
                                Vault.getInstance().then((Vault _vault) {
                                  final String _seed = AppSeeds.generateSeed();
                                  _vault.setSeed(_seed);
                                  AppUtil()
                                      .loginAccount(_seed, context,
                                          forceNewAccount: true)
                                      .then((Account selectedAcct) {
                                    StateContainer.of(context)
                                        .requestUpdate(account: selectedAcct);
                                    Navigator.of(context).pushNamed(
                                      '/intro_backup_safety',
                                    );
                                  });
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          // Import Wallet Button
                          AppButton.buildAppButton(
                            const Key('importWallet'),
                            context,
                            checkedValue
                                ? AppButtonType.primary
                                : AppButtonType.primaryOutline,
                            AppLocalization.of(context)!.importWallet,
                            Dimens.buttonBottomDimens,
                            onPressed: () {
                              if (checkedValue) {
                                Navigator.of(context)
                                    .pushNamed('/intro_import');
                              }
                            },
                          ),
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
