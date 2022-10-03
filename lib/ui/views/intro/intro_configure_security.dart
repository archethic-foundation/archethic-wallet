/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: always_specify_types

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/bus/authenticated_event.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/authenticate/pin_screen.dart';
import 'package:aewallet/ui/views/settings/set_password.dart';
import 'package:aewallet/ui/views/settings/set_yubikey.dart';
import 'package:aewallet/ui/widgets/components/icon_widget.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/preferences.dart';

class IntroConfigureSecurity extends StatefulWidget {
  const IntroConfigureSecurity({
    super.key,
    this.accessModes,
    required this.name,
    required this.seed,
  });
  final List<PickerItem>? accessModes;
  final String? name;
  final String? seed;

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
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              StateContainer.of(context).curTheme.background2Small!,
            ),
            fit: BoxFit.fitHeight,
          ),
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
              top: MediaQuery.of(context).size.height * 0.075,
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin:
                                  const EdgeInsetsDirectional.only(start: 15),
                              height: 50,
                              width: 50,
                              child: BackButton(
                                key: const Key('back'),
                                color: StateContainer.of(context).curTheme.text,
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: IconWidget.build(
                            context,
                            'assets/icons/finger-print.png',
                            90,
                            90,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(
                            start: 20,
                            end: 20,
                            top: 10,
                          ),
                          alignment: AlignmentDirectional.centerStart,
                          child: AutoSizeText(
                            AppLocalization.of(context)!.configureSecurityIntro,
                            style:
                                AppStyles.textStyleSize20W700Warning(context),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(
                            start: 20,
                            end: 20,
                            top: 15,
                          ),
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
                            margin: const EdgeInsetsDirectional.only(
                              start: 20,
                              end: 20,
                            ),
                            child: PickerWidget(
                              pickerItems: widget.accessModes,
                              onSelected: (value) async {
                                setState(() {
                                  _accessModesSelected = value;
                                });
                                if (_accessModesSelected == null) return;
                                final authMethod =
                                    _accessModesSelected!.value as AuthMethod;
                                var authenticated = false;
                                switch (authMethod) {
                                  case AuthMethod.biometrics:
                                    authenticated = await sl
                                        .get<BiometricUtil>()
                                        .authenticateWithBiometrics(
                                          context,
                                          AppLocalization.of(context)!
                                              .unlockBiometrics,
                                        );
                                    break;
                                  case AuthMethod.password:
                                    authenticated =
                                        await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return SetPassword(
                                            header: AppLocalization.of(context)!
                                                .setPasswordHeader,
                                            description: AppLocalization.of(
                                              context,
                                            )!
                                                .configureSecurityExplanationPassword,
                                            name: widget.name,
                                            seed: widget.seed,
                                          );
                                        },
                                      ),
                                    );
                                    break;
                                  case AuthMethod.pin:
                                    authenticated =
                                        await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return const PinScreen(
                                            PinOverlayType.newPin,
                                          );
                                        },
                                      ),
                                    );
                                    break;
                                  case AuthMethod.yubikeyWithYubicloud:
                                    authenticated =
                                        await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return SetYubikey(
                                            header: AppLocalization.of(context)!
                                                .seYubicloudHeader,
                                            description:
                                                AppLocalization.of(context)!
                                                    .seYubicloudDescription,
                                          );
                                        },
                                      ),
                                    );
                                    break;
                                  default:
                                    break;
                                }
                                if (authenticated) {
                                  await Preferences.initWallet(
                                    AuthenticationMethod(authMethod),
                                  );
                                  EventTaxiImpl.singleton()
                                      .fire(AuthenticatedEvent());
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
}
