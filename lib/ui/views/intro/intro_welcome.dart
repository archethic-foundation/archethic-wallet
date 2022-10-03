/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: avoid_unnecessary_containers

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/dialogs/network_dialog.dart';

class IntroWelcome extends StatefulWidget {
  const IntroWelcome({super.key});

  @override
  State<IntroWelcome> createState() => _IntroWelcomeState();
}

class _IntroWelcomeState extends State<IntroWelcome> {
  bool checkedValue = false;
  NetworksSetting _curNetworksSetting =
      NetworksSetting(AvailableNetworks.archethicMainNet);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          DecoratedBox(
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
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    StateContainer.of(context).curTheme.background4Small!,
                  ),
                  fit: BoxFit.fitHeight,
                  opacity: 0.8,
                ),
              ),
            ),
          ),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) =>
                SafeArea(
              minimum: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.035,
                top: MediaQuery.of(context).size.height * 0.075,
              ),
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
                                  left: 20,
                                  right: 20,
                                ),
                                child: SizedBox(
                                  height: 200,
                                  child: AspectRatio(
                                    aspectRatio: 3 / 1,
                                    child: Image.asset(
                                      '${StateContainer.of(context).curTheme.assetsFolder!}${StateContainer.of(context).curTheme.logo!}.png',
                                      height: 200,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 20,
                              right: 20,
                              left: 20,
                            ),
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
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                  ),
                                  child: CheckboxListTile(
                                    title: Text(
                                      AppLocalization.of(context)!
                                          .welcomeDisclaimerChoice,
                                      style:
                                          AppStyles.textStyleSize14W600Primary(
                                        context,
                                      ),
                                    ),
                                    value: checkedValue,
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
                                        .text,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    secondary: IconButton(
                                      icon: const Icon(Icons.read_more),
                                      iconSize: 30,
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .backgroundDarkest,
                                      onPressed: () {
                                        UIUtil.showWebview(
                                          context,
                                          'https://archethic.net',
                                          AppLocalization.of(context)!
                                              .welcomeDisclaimerLink,
                                        );
                                      },
                                    ),
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
                            onPressed: () async {
                              if (checkedValue) {
                                await _networkDialog();
                                /* setState(() {
                                  _curNetworksSetting = NetworksSetting(
                                      AvailableNetworks.archethicTestNet);
                                  StateContainer.of(context).curNetwork =
                                      _curNetworksSetting;
                                });*/
                                Navigator.of(context).pushNamed(
                                  '/intro_welcome_get_first_infos',
                                );
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
                            onPressed: () async {
                              if (checkedValue) {
                                /*setState(() {
                                  _curNetworksSetting = NetworksSetting(
                                      AvailableNetworks.archethicTestNet);
                                  StateContainer.of(context).curNetwork =
                                      _curNetworksSetting;
                                });*/
                                await _networkDialog();
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

  Future<void> _networkDialog() async {
    _curNetworksSetting =
        (await NetworkDialog.getDialog(context, _curNetworksSetting))!;
    setState(() {});
  }
}
