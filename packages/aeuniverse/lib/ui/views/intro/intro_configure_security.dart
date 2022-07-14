/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: always_specify_types

// Flutter imports:
import 'package:aeuniverse/ui/widgets/components/dialog.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/model/primary_currency.dart';
import 'package:core/util/keychain_util.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/authentication_method.dart';
import 'package:core/model/device_lock_timeout.dart';
import 'package:core/util/biometrics_util.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/vault.dart';

// Project imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/views/authenticate/pin_screen.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:aeuniverse/ui/widgets/components/picker_item.dart';
import 'package:aeuniverse/util/preferences.dart';

class IntroConfigureSecurity extends StatefulWidget {
  final List<PickerItem>? accessModes;
  final String? name;
  final String? seed;

  const IntroConfigureSecurity(
      {super.key, this.accessModes, required this.name, required this.seed});

  @override
  State<IntroConfigureSecurity> createState() => _IntroConfigureSecurityState();
}

class _IntroConfigureSecurityState extends State<IntroConfigureSecurity> {
  PickerItem? _accessModesSelected;
  bool? animationOpen;

  @override
  void initState() {
    animationOpen = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  StateContainer.of(context).curTheme.background2Small!),
              fit: BoxFit.fitHeight),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              StateContainer.of(context).curTheme.backgroundDark!,
              StateContainer.of(context).curTheme.background!
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SafeArea(
            minimum: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.075),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsetsDirectional.only(start: 15),
                              height: 50,
                              width: 50,
                              child: BackButton(
                                key: const Key('back'),
                                color: StateContainer.of(context).curTheme.text,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: buildIconWidget(
                              context,
                              'packages/aeuniverse/assets/icons/finger-print.png',
                              90,
                              90),
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(
                            start: 20,
                            end: 20,
                            top: 10,
                          ),
                          alignment: const AlignmentDirectional(-1, 0),
                          child: AutoSizeText(
                            AppLocalization.of(context)!.configureSecurityIntro,
                            style:
                                AppStyles.textStyleSize20W700Warning(context),
                          ),
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(
                              start: 20, end: 20, top: 15.0),
                          child: AutoSizeText(
                            AppLocalization.of(context)!
                                .configureSecurityExplanation,
                            style:
                                AppStyles.textStyleSize16W600Primary(context),
                            textAlign: TextAlign.justify,
                            maxLines: 6,
                            stepGranularity: 0.5,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (widget.accessModes != null)
                          Container(
                            margin:
                                EdgeInsetsDirectional.only(start: 20, end: 20),
                            child: PickerWidget(
                              pickerItems: widget.accessModes,
                              onSelected: (value) async {
                                setState(() {
                                  _accessModesSelected = value;
                                });
                                if (_accessModesSelected == null) return;
                                AuthMethod _authMethod =
                                    _accessModesSelected!.value as AuthMethod;
                                switch (_authMethod) {
                                  case AuthMethod.biometrics:
                                    final bool authenticated = await sl
                                        .get<BiometricUtil>()
                                        .authenticateWithBiometrics(
                                            context,
                                            AppLocalization.of(context)!
                                                .unlockBiometrics);
                                    if (authenticated) {
                                      _showSendingAnimation(context);
                                      final Preferences _preferences =
                                          await Preferences.getInstance();
                                      _preferences.setLock(true);
                                      _preferences.setShowBalances(true);
                                      _preferences.setShowBlog(true);
                                      _preferences.setActiveVibrations(true);
                                      _preferences.setActiveNotifications(true);
                                      _preferences.setPinPadShuffle(false);
                                      _preferences.setShowPriceChart(true);
                                      _preferences.setPrimaryCurrency(
                                          PrimaryCurrencySetting(
                                              AvailablePrimaryCurrency.NATIVE));
                                      _preferences.setLockTimeout(
                                          LockTimeoutSetting(
                                              LockTimeoutOption.one));
                                      _preferences.setAuthMethod(
                                          AuthenticationMethod(
                                              AuthMethod.biometrics));
                                      await sl.get<DBHelper>().clearAppWallet();
                                      final Vault vault =
                                          await Vault.getInstance();
                                      await vault.setSeed(widget.seed!);
                                      StateContainer.of(context).appWallet =
                                          await KeychainUtil().newAppWallet(
                                              widget.seed!, widget.name!);
                                      await StateContainer.of(context)
                                          .requestUpdate();
                                      StateContainer.of(context)
                                          .checkTransactionInputs(
                                              AppLocalization.of(context)!
                                                  .transactionInputNotification);
                                    }
                                    await Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                      '/home',
                                      (Route<dynamic> route) => false,
                                    );
                                    break;
                                  case AuthMethod.password:
                                    Navigator.of(context).pushNamed(
                                        '/intro_password',
                                        arguments: {
                                          'name': widget.name,
                                          'seed': widget.seed
                                        });
                                    break;
                                  case AuthMethod.pin:
                                    final String pin =
                                        await Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                      return const PinScreen(
                                        PinOverlayType.newPin,
                                      );
                                    }));

                                    if (pin.length > 5) {
                                      _showSendingAnimation(context);
                                      final Vault _vault =
                                          await Vault.getInstance();
                                      _vault.setPin(pin);
                                      final Preferences _preferences =
                                          await Preferences.getInstance();
                                      _preferences.setLock(true);
                                      _preferences.setShowBalances(true);
                                      _preferences.setShowBlog(true);
                                      _preferences.setActiveVibrations(true);
                                      _preferences.setActiveNotifications(true);
                                      _preferences.setPinPadShuffle(false);
                                      _preferences.setShowPriceChart(true);
                                      _preferences.setPrimaryCurrency(
                                          PrimaryCurrencySetting(
                                              AvailablePrimaryCurrency.NATIVE));
                                      _preferences.setLockTimeout(
                                          LockTimeoutSetting(
                                              LockTimeoutOption.one));
                                      _preferences.setAuthMethod(
                                          AuthenticationMethod(AuthMethod.pin));
                                      await sl.get<DBHelper>().clearAppWallet();
                                      final Vault vault =
                                          await Vault.getInstance();
                                      await vault.setSeed(widget.seed!);
                                      StateContainer.of(context).appWallet =
                                          await KeychainUtil().newAppWallet(
                                              widget.seed!, widget.name!);
                                      await StateContainer.of(context)
                                          .requestUpdate();
                                      StateContainer.of(context)
                                          .checkTransactionInputs(
                                              AppLocalization.of(context)!
                                                  .transactionInputNotification);
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                        '/home',
                                        (Route<dynamic> route) => false,
                                      );
                                    }
                                    break;
                                  case AuthMethod.yubikeyWithYubicloud:
                                    Navigator.of(context).pushNamed(
                                        '/intro_yubikey',
                                        arguments: {
                                          'name': widget.name,
                                          'seed': widget.seed
                                        });
                                    break;
                                  default:
                                    break;
                                }
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSendingAnimation(BuildContext context) {
    animationOpen = true;
    Navigator.of(context).push(AnimationLoadingOverlay(
        AnimationType.send,
        StateContainer.of(context).curTheme.animationOverlayStrong!,
        StateContainer.of(context).curTheme.animationOverlayMedium!,
        onPoppedCallback: () => animationOpen = false,
        title: AppLocalization.of(context)!.appWalletInitInProgress));
  }
}
