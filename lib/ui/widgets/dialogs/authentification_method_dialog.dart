/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/authenticate/pin_screen.dart';
import 'package:aewallet/ui/views/settings/set_password.dart';
import 'package:aewallet/ui/views/settings/set_yubikey.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthentificationMethodDialog {
  static Future<void> getDialog(
    BuildContext context,
    WidgetRef ref,
    bool hasBiometrics,
    AuthenticationMethod curAuthMethod,
  ) async {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final settingsNotifier = ref.watch(
      AuthenticationProviders.settings.notifier,
    );
    final pickerItemsList = List<PickerItem>.empty(growable: true);
    for (final value in AuthMethod.values) {
      var displayed = false;
      if (value != AuthMethod.ledger) {
        if ((hasBiometrics && value == AuthMethod.biometrics) ||
            value != AuthMethod.biometrics) {
          displayed = true;
        }
      }
      pickerItemsList.add(
        PickerItem(
          AuthenticationMethod(value).getDisplayName(context),
          AuthenticationMethod(value).getDescription(context),
          AuthenticationMethod.getIcon(value),
          theme.pickerItemIconEnabled,
          value,
          value != AuthMethod.biometricsUniris,
          displayed: displayed,
        ),
      );
    }
    await showDialog<AuthMethod>(
      context: context,
      builder: (BuildContext context) {
        final localizations = AppLocalization.of(context)!;
        return AlertDialog(
          title: Text(
            localizations.authMethod,
            style: theme.textStyleSize24W700EquinoxPrimary,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            side: BorderSide(
              color: theme.text45!,
            ),
          ),
          content: SingleChildScrollView(
            child: PickerWidget(
              pickerItems: pickerItemsList,
              selectedIndex: curAuthMethod.method.index,
              onSelected: (value) async {
                switch (value.value) {
                  case AuthMethod.biometrics:
                    final auth = await sl
                        .get<BiometricUtil>()
                        .authenticateWithBiometrics(
                          context,
                          localizations.unlockBiometrics,
                        );
                    if (auth) {
                      settingsNotifier.setAuthMethod(
                        AuthMethod.biometrics,
                      );
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home',
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      Navigator.pop(context, value.value);
                      await getDialog(
                        context,
                        ref,
                        hasBiometrics,
                        curAuthMethod,
                      );
                    }
                    break;
                  case AuthMethod.pin:
                    final bool authenticated = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const PinScreen(
                            PinOverlayType.newPin,
                          );
                        },
                      ),
                    );
                    if (authenticated == false) {
                      Navigator.pop(context, value.value);
                      await getDialog(
                        context,
                        ref,
                        hasBiometrics,
                        curAuthMethod,
                      );
                    } else {
                      settingsNotifier.setAuthMethod(
                        AuthMethod.pin,
                      );
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home',
                        (Route<dynamic> route) => false,
                      );
                    }
                    break;
                  case AuthMethod.password:
                    final seed = await StateContainer.of(context).getSeed();
                    final bool authenticated = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return SetPassword(
                            name: StateContainer.of(context)
                                .appWallet!
                                .appKeychain!
                                .getAccountSelected()!
                                .name,
                            seed: seed,
                          );
                        },
                      ),
                    );

                    if (authenticated == false) {
                      Navigator.pop(context, value.value);
                      await getDialog(
                        context,
                        ref,
                        hasBiometrics,
                        curAuthMethod,
                      );
                    } else {
                      settingsNotifier.setAuthMethod(
                        AuthMethod.password,
                      );
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home',
                        (Route<dynamic> route) => false,
                      );
                    }
                    break;
                  case AuthMethod.yubikeyWithYubicloud:
                    final bool authenticated = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const SetYubikey();
                        },
                      ),
                    );
                    if (authenticated == false) {
                      Navigator.pop(context, value.value);
                      await getDialog(
                        context,
                        ref,
                        hasBiometrics,
                        curAuthMethod,
                      );
                    } else {
                      settingsNotifier.setAuthMethod(
                        AuthMethod.yubikeyWithYubicloud,
                      );
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home',
                        (Route<dynamic> route) => false,
                      );
                    }
                    break;
                  default:
                    Navigator.pop(context, value.value);
                    break;
                }
              },
            ),
          ),
        );
      },
    );
  }
}
