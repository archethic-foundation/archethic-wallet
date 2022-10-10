/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/dialogs/network_dialog.dart';
// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntroWelcome extends ConsumerStatefulWidget {
  const IntroWelcome({super.key});

  @override
  ConsumerState<IntroWelcome> createState() => _IntroWelcomeState();
}

class _IntroWelcomeState extends ConsumerState<IntroWelcome> {
  bool checkedValue = false;
  NetworksSetting _curNetworksSetting = const NetworksSetting(AvailableNetworks.archethicMainNet);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.read(ThemeProviders.theme);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              theme.background4Small!,
            ),
            fit: BoxFit.fitHeight,
            opacity: 0.8,
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) => SafeArea(
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
                        Center(
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
                                  '${theme.assetsFolder!}${theme.logo!}.png',
                                  height: 200,
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
                            localizations.welcomeText,
                            maxLines: 5,
                            style: theme.textStyleSize20W700Primary,
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
                                    localizations.welcomeDisclaimerChoice,
                                    style: theme.textStyleSize14W600Primary,
                                  ),
                                  value: checkedValue,
                                  onChanged: (newValue) {
                                    setState(() {
                                      checkedValue = newValue!;
                                    });
                                  },
                                  checkColor: theme.background,
                                  activeColor: theme.text,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  secondary: IconButton(
                                    icon: const Icon(Icons.read_more),
                                    iconSize: 30,
                                    color: theme.backgroundDarkest,
                                    onPressed: () {
                                      UIUtil.showWebview(
                                        context,
                                        'https://archethic.net',
                                        localizations.welcomeDisclaimerLink,
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
                          ref,
                          checkedValue ? AppButtonType.primary : AppButtonType.primaryOutline,
                          localizations.newWallet,
                          Dimens.buttonTopDimens,
                          onPressed: () async {
                            if (checkedValue) {
                              await _networkDialog();
                              // TODO(reddwarf03): to implement, https://github.com/archethic-foundation/archethic-wallet/issues/144
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
                          ref,
                          checkedValue ? AppButtonType.primary : AppButtonType.primaryOutline,
                          localizations.importWallet,
                          Dimens.buttonBottomDimens,
                          onPressed: () async {
                            if (checkedValue) {
                              // TODO(reddwarf03): to implement, https://github.com/archethic-foundation/archethic-wallet/issues/144
                              /*setState(() {
                                  _curNetworksSetting = NetworksSetting(
                                      AvailableNetworks.archethicTestNet);
                                  StateContainer.of(context).curNetwork =
                                      _curNetworksSetting;
                                });*/
                              await _networkDialog();
                              Navigator.of(context).pushNamed('/intro_import');
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
      ),
    );
  }

  Future<void> _networkDialog() async {
    _curNetworksSetting = (await NetworkDialog.getDialog(context, ref, _curNetworksSetting))!;
    setState(() {});
  }
}
