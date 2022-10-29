/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/bus/authenticated_event.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/authenticate/pin_screen.dart';
import 'package:aewallet/ui/views/settings/set_password.dart';
import 'package:aewallet/ui/views/settings/set_yubikey.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/preferences.dart';
// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntroConfigureSecurity extends ConsumerStatefulWidget {
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
  ConsumerState<IntroConfigureSecurity> createState() =>
      _IntroConfigureSecurityState();
}

class _IntroConfigureSecurityState
    extends ConsumerState<IntroConfigureSecurity> {
  PickerItem? _accessModesSelected;
  bool? animationOpen;

  @override
  void initState() {
    animationOpen = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              theme.background2Small!,
            ),
            fit: BoxFit.fitHeight,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[theme.backgroundDark!, theme.background!],
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
                Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsetsDirectional.only(start: 15),
                      height: 50,
                      width: 50,
                      child: BackButton(
                        key: const Key('back'),
                        color: theme.text,
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsetsDirectional.only(
                              start: 20,
                              end: 20,
                              top: 10,
                            ),
                            alignment: AlignmentDirectional.centerStart,
                            child: AutoSizeText(
                              localizations.configureSecurityIntro,
                              style: theme.textStyleSize20W700Warning,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.only(
                              start: 20,
                              end: 20,
                              top: 15,
                            ),
                            child: AutoSizeText(
                              localizations.configureSecurityExplanation,
                              style: theme.textStyleSize16W600Primary,
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
                                            localizations.unlockBiometrics,
                                          );
                                      break;
                                    case AuthMethod.password:
                                      authenticated =
                                          await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return SetPassword(
                                              header: localizations
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
                                              header: localizations
                                                  .seYubicloudHeader,
                                              description: localizations
                                                  .seYubicloudDescription,
                                            );
                                          },
                                        ),
                                      );
                                      break;
                                    case AuthMethod.biometricsUniris:
                                      break;
                                    case AuthMethod.ledger:
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
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
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
