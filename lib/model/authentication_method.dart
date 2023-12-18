/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/model/setting_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

enum AuthMethod {
  pin,
  biometrics,
  yubikeyWithYubicloud,
  ledger,
  password,
}

/// Represent the available authentication methods our app supports
@immutable
class AuthenticationMethod extends SettingSelectionItem {
  const AuthenticationMethod(this.method);

  final AuthMethod method;

  @override
  String getDisplayName(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (method) {
      case AuthMethod.biometrics:
        return localizations.biometricsMethod;
      case AuthMethod.pin:
        return localizations.pinMethod;
      case AuthMethod.yubikeyWithYubicloud:
        return localizations.yubikeyWithYubiCloudMethod;
      case AuthMethod.ledger:
        return localizations.ledgerMethod;
      case AuthMethod.password:
        return localizations.passwordMethod;
    }
  }

  String getDescription(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (method) {
      case AuthMethod.biometrics:
        return localizations.configureSecurityExplanationBiometrics;
      case AuthMethod.pin:
        return localizations.configureSecurityExplanationPIN;
      case AuthMethod.yubikeyWithYubicloud:
        return localizations.configureSecurityExplanationYubikey;
      case AuthMethod.ledger:
        return '';
      case AuthMethod.password:
        return localizations.configureSecurityExplanationPassword;
    }
  }

  static String getIcon(AuthMethod method) {
    switch (method) {
      case AuthMethod.biometrics:
        return 'assets/icons/biometrics.png';
      case AuthMethod.pin:
        return 'assets/icons/pin-code.png';
      case AuthMethod.yubikeyWithYubicloud:
        return 'assets/icons/yubikey.png';
      case AuthMethod.password:
        return 'assets/icons/password.png';
      case AuthMethod.ledger:
        return 'assets/icons/password.png';
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return method.index;
  }
}
