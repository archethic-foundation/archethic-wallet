/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/settings.dart';

import 'package:aewallet/bus/authenticated_event.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/authenticate/pin_screen.dart';
import 'package:aewallet/ui/views/settings/set_password.dart';
import 'package:aewallet/ui/views/settings/set_yubikey.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/dialogs/authentification_method_dialog_help.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:material_symbols_icons/symbols.dart';

class IntroConfigureSecurity extends ConsumerStatefulWidget {
  const IntroConfigureSecurity({
    super.key,
    this.accessModes,
    required this.seed,
  });
  final List<PickerItem>? accessModes;
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
    final localizations = AppLocalizations.of(context)!;
    final preferences = ref.watch(SettingsProviders.settings);
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ArchethicTheme.backgroundSmall,
            ),
            fit: BoxFit.fitHeight,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              ArchethicTheme.backgroundDark,
              ArchethicTheme.background,
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SafeArea(
            minimum: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.075,
            ),
            child: Stack(
              children: [
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsetsDirectional.only(start: 15),
                          height: 50,
                          width: 50,
                          child: BackButton(
                            key: const Key('back'),
                            color: ArchethicTheme.text,
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ArchethicScrollbar(
                        child: Column(
                          children: <Widget>[
                            AutoSizeText(
                              localizations.securityHeader,
                              style: ArchethicThemeStyles
                                  .textStyleSize20W700Primary,
                              textAlign: TextAlign.justify,
                              maxLines: 6,
                              stepGranularity: 0.5,
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 30,
                                left: 20,
                                right: 20,
                              ),
                              alignment: AlignmentDirectional.centerStart,
                              child: AutoSizeText(
                                localizations.configureSecurityIntro,
                                style: ArchethicThemeStyles
                                    .textStyleSize14W600Primary,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 20,
                                left: 20,
                                right: 20,
                              ),
                              child: AutoSizeText(
                                localizations.configureSecurityExplanation,
                                style: ArchethicThemeStyles
                                    .textStyleSize12W100Primary,
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
                                margin: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: PickerWidget(
                                  pickerItems: widget.accessModes,
                                  onSelected: (value) async {
                                    setState(() {
                                      _accessModesSelected = value;
                                    });
                                    if (_accessModesSelected == null) return;
                                    final authMethod = _accessModesSelected!
                                        .value as AuthMethod;
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
                                                description: AppLocalizations
                                                        .of(
                                                  context,
                                                )!
                                                    .configureSecurityExplanationPassword,
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
                                      await ref
                                          .read(
                                            AuthenticationProviders
                                                .settings.notifier,
                                          )
                                          .setAuthMethod(authMethod);
                                      EventTaxiImpl.singleton()
                                          .fire(AuthenticatedEvent());
                                    }
                                  },
                                ),
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: InkWell(
                                onTap: () async {
                                  sl.get<HapticUtil>().feedback(
                                        FeedbackType.light,
                                        preferences.activeVibrations,
                                      );
                                  return AuthentificationMethodDialogHelp
                                      .getDialog(
                                    context,
                                    ref,
                                  );
                                },
                                child: Icon(
                                  Symbols.help,
                                  color: ArchethicTheme.text,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (connectivityStatusProvider ==
                    ConnectivityStatus.isDisconnected)
                  const IconNetworkWarning(
                    alignment: Alignment.topRight,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
