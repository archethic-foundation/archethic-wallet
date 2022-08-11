/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/authenticate/pin_screen.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:aewallet/util/vault.dart';

class AuthentificationMethodDialog {
  static Future<void> getDialog(BuildContext context, bool hasBiometrics,
      AuthenticationMethod curAuthMethod) async {
    final Preferences preferences = await Preferences.getInstance();
    final List<PickerItem> pickerItemsList =
        List<PickerItem>.empty(growable: true);
    for (var value in AuthMethod.values) {
      bool displayed = false;
      if (value != AuthMethod.ledger) {
        if ((hasBiometrics && value == AuthMethod.biometrics) ||
            value != AuthMethod.biometrics) {
          displayed = true;
        }
      }
      pickerItemsList.add(PickerItem(
          AuthenticationMethod(value).getDisplayName(context),
          AuthenticationMethod(value).getDescription(context),
          AuthenticationMethod.getIcon(value),
          StateContainer.of(context).curTheme.pickerItemIconEnabled,
          value,
          value == AuthMethod.biometricsUniris ? false : true,
          displayed: displayed));
    }
    await showDialog<AuthMethod>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalization.of(context)!.authMethod,
            style: AppStyles.textStyleSize20W700EquinoxPrimary(context),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              side: BorderSide(
                  color: StateContainer.of(context).curTheme.text45!)),
          content: SingleChildScrollView(
            child: PickerWidget(
              pickerItems: pickerItemsList,
              selectedIndex: curAuthMethod.method.index,
              onSelected: (value) async {
                switch (value.value) {
                  case AuthMethod.biometrics:
                    bool auth = await sl
                        .get<BiometricUtil>()
                        .authenticateWithBiometrics(context,
                            AppLocalization.of(context)!.unlockBiometrics);
                    if (auth) {
                      preferences.setAuthMethod(
                          AuthenticationMethod(AuthMethod.biometrics));
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home',
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      Navigator.pop(context, value.value);
                      await getDialog(context, hasBiometrics, curAuthMethod);
                    }
                    break;
                  case AuthMethod.pin:
                    final String pin = await Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const PinScreen(
                        PinOverlayType.newPin,
                      );
                    }));
                    if (pin == '') {
                      Navigator.pop(context, value.value);
                      await getDialog(context, hasBiometrics, curAuthMethod);
                    } else {
                      if (pin.length > 5) {
                        final Vault vault = await Vault.getInstance();
                        vault.setPin(pin);
                        preferences.setAuthMethod(
                            AuthenticationMethod(AuthMethod.pin));
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/home',
                          (Route<dynamic> route) => false,
                        );
                      }
                    }
                    break;
                  case AuthMethod.password:
                    await Navigator.of(context)
                        .pushNamed('/update_password', arguments: {
                      'name': StateContainer.of(context)
                          .appWallet!
                          .appKeychain!
                          .getAccountSelected()!
                          .name,
                      'seed': await StateContainer.of(context).getSeed()
                    });
                    Navigator.pop(context, value.value);
                    await getDialog(context, hasBiometrics, curAuthMethod);
                    break;
                  case AuthMethod.yubikeyWithYubicloud:
                    await Navigator.of(context)
                        .pushNamed('/update_yubikey', arguments: {
                      'name': StateContainer.of(context)
                          .appWallet!
                          .appKeychain!
                          .getAccountSelected()!
                          .name,
                      'seed': await StateContainer.of(context).getSeed()
                    });
                    Navigator.pop(context, value.value);
                    await getDialog(context, hasBiometrics, curAuthMethod);
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
