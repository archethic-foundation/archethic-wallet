/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/authenticate/pin_screen.dart';
import 'package:aewallet/ui/views/settings/set_password.dart';
import 'package:aewallet/ui/views/settings/set_yubikey.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/ui/widgets/dialogs/authentification_method_dialog_help.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class AuthentificationMethodDialog {
  static Future<bool> _applyAuthMethod(
    BuildContext context,
    WidgetRef ref,
    AuthMethod authMethod,
  ) async {
    final localizations = AppLocalizations.of(context)!;

    return switch (authMethod) {
      AuthMethod.biometrics =>
        await sl.get<BiometricUtil>().authenticateWithBiometrics(
              context,
              localizations.unlockBiometrics,
            ),
      AuthMethod.pin => (await context.push(
          PinScreen.routerPage,
          extra: {
            'type': PinOverlayType.newPin.name,
          },
        ))! as bool,
      AuthMethod.password => (await context.push(
          SetPassword.routerPage,
          extra: {
            'header': localizations.setPasswordHeader,
            'description': AppLocalizations.of(
              context,
            )!
                .configureSecurityExplanationPassword,
            'seed': ref.read(SessionProviders.session).loggedIn?.wallet.seed,
          },
        ))! as bool,
      AuthMethod.yubikeyWithYubicloud => (await context.push(
          SetYubikey.routerPage,
          extra: {
            'header': localizations.setYubicloudHeader,
            'description': localizations.setYubicloudDescription,
          },
        ))! as bool,
      AuthMethod.ledger => throw UnimplementedError(),
    };
  }

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
      if (kIsWeb && value != AuthMethod.password) {
        displayed = false;
      } else {
        if (value != AuthMethod.ledger) {
          if ((hasBiometrics && value == AuthMethod.biometrics) ||
              value != AuthMethod.biometrics) {
            displayed = true;
          }
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
      useRootNavigator: false,
      builder: (BuildContext context) {
        return aedappfm.PopupTemplate(
          popupContent: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: PickerWidget(
                  scrollable: true,
                  pickerItems: pickerItemsList,
                  selectedIndexes: [curAuthMethod.method.index],
                  onSelected: (value) async {
                    if (context.canPop()) context.pop();

                    final authMethod = value.value;
                    final success = await _applyAuthMethod(
                      context,
                      ref,
                      authMethod,
                    );

                    if (success) {
                      await settingsNotifier.setAuthMethod(
                        authMethod,
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
          popupTitle: AppLocalizations.of(context)!.authMethod,
        );
      },
    );
  }
}
