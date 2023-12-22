/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/authenticate/pin_screen.dart';
import 'package:aewallet/ui/views/settings/set_password.dart';
import 'package:aewallet/ui/views/settings/set_yubikey.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/ui/widgets/dialogs/authentification_method_dialog_help.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class AuthentificationMethodDialog {
  static Future<void> getDialog(
    BuildContext context,
    WidgetRef ref,
    bool hasBiometrics,
    AuthenticationMethod curAuthMethod,
  ) async {
    final settingsNotifier = ref.read(
      AuthenticationProviders.settings.notifier,
    );
    final preferences = ref.watch(SettingsProviders.settings);
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
          null,
          AuthenticationMethod.getIcon(value),
          ArchethicTheme.pickerItemIconEnabled,
          value,
          true,
          displayed: displayed,
        ),
      );
    }
    await showDialog<AuthMethod>(
      context: context,
      builder: (BuildContext context) {
        final localizations = AppLocalizations.of(context)!;
        return AlertDialog(
          backgroundColor: ArchethicTheme.backgroundPopupColor,
          elevation: 0,
          title: Text(
            localizations.authMethod,
            style: ArchethicThemeStyles.textStyleSize24W700Primary,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PickerWidget(
                scrollable: true,
                pickerItems: pickerItemsList,
                selectedIndexes: [curAuthMethod.method.index],
                onSelected: (value) async {
                  if (context.canPop()) context.pop();
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
                      } else {
                        if (context.canPop()) context.pop(value.value);
                        await getDialog(
                          context,
                          ref,
                          hasBiometrics,
                          curAuthMethod,
                        );
                      }
                      break;
                    case AuthMethod.pin:
                      if (context.canPop()) context.pop();
                      final auth = (await context.push(
                        PinScreen.routerPage,
                        extra: {
                          'type': PinOverlayType.newPin.name,
                        },
                      ))! as bool;

                      if (auth) {
                        settingsNotifier.setAuthMethod(
                          AuthMethod.pin,
                        );
                      } else {
                        if (context.canPop()) context.pop(value.value);
                        await getDialog(
                          context,
                          ref,
                          hasBiometrics,
                          curAuthMethod,
                        );
                      }
                      break;
                    case AuthMethod.password:
                      if (context.canPop()) context.pop();
                      final auth = (await context.push(
                        SetPassword.routerPage,
                        extra: {
                          'header': localizations.setPasswordHeader,
                          'description': AppLocalizations.of(
                            context,
                          )!
                              .configureSecurityExplanationPassword,
                          'seed': ref
                              .read(SessionProviders.session)
                              .loggedIn
                              ?.wallet
                              .seed,
                        },
                      ))! as bool;

                      if (auth) {
                        settingsNotifier.setAuthMethod(
                          AuthMethod.password,
                        );
                      } else {
                        if (context.canPop()) context.pop(value.value);
                        await getDialog(
                          context,
                          ref,
                          hasBiometrics,
                          curAuthMethod,
                        );
                      }
                      break;
                    case AuthMethod.yubikeyWithYubicloud:
                      if (context.canPop()) context.pop();
                      final auth = (await context.push(
                        SetYubikey.routerPage,
                        extra: {
                          'header': localizations.setYubicloudHeader,
                          'description': localizations.setYubicloudDescription,
                        },
                      ))! as bool;

                      if (auth) {
                        settingsNotifier.setAuthMethod(
                          AuthMethod.yubikeyWithYubicloud,
                        );
                      } else {
                        if (context.canPop()) context.pop(value.value);
                        await getDialog(
                          context,
                          ref,
                          hasBiometrics,
                          curAuthMethod,
                        );
                      }
                      break;
                    default:
                      if (context.canPop()) context.pop(value.value);
                      break;
                  }
                },
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
                    return AuthentificationMethodDialogHelp.getDialog(
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
        );
      },
    );
  }
}
