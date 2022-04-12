// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/localization.dart';
import 'package:core/model/setting_item.dart';

// Package imports:

enum AuthMethod {
  pin,
  biometrics,
  biometricsUniris,
  yubikeyWithYubicloud,
  ledger,
  password
}

/// Represent the available authentication methods our app supports
class AuthenticationMethod extends SettingSelectionItem {
  AuthenticationMethod(this.method);

  AuthMethod method;

  @override
  String getDisplayName(BuildContext context) {
    switch (method) {
      case AuthMethod.biometrics:
        return AppLocalization.of(context)!.biometricsMethod;
      case AuthMethod.biometricsUniris:
        return AppLocalization.of(context)!.biometricsUnirisMethod;
      case AuthMethod.pin:
        return AppLocalization.of(context)!.pinMethod;
      case AuthMethod.yubikeyWithYubicloud:
        return AppLocalization.of(context)!.yubikeyWithYubiCloudMethod;
      case AuthMethod.ledger:
        return AppLocalization.of(context)!.ledgerMethod;
      case AuthMethod.password:
        return AppLocalization.of(context)!.passwordMethod;
      default:
        return AppLocalization.of(context)!.pinMethod;
    }
  }

  String getDescription(BuildContext context) {
    switch (method) {
      case AuthMethod.biometrics:
        return AppLocalization.of(context)!
            .configureSecurityExplanationBiometrics;
      case AuthMethod.biometricsUniris:
        return AppLocalization.of(context)!
            .configureSecurityExplanationUnirisBiometrics;
      case AuthMethod.pin:
        return AppLocalization.of(context)!.configureSecurityExplanationPIN;
      case AuthMethod.yubikeyWithYubicloud:
        return AppLocalization.of(context)!.configureSecurityExplanationYubikey;
      case AuthMethod.ledger:
        return '';
      case AuthMethod.password:
        return AppLocalization.of(context)!
            .configureSecurityExplanationPassword;
      default:
        return AppLocalization.of(context)!.configureSecurityExplanationPIN;
    }
  }

  static String getIcon(AuthMethod _method) {
    switch (_method) {
      case AuthMethod.biometrics:
        return 'packages/aeuniverse/assets/icons/biometrics.png';
      case AuthMethod.biometricsUniris:
        return 'packages/aeuniverse/assets/icons/biometrics-uniris.png';
      case AuthMethod.pin:
        return 'packages/aeuniverse/assets/icons/pin-code.png';
      case AuthMethod.yubikeyWithYubicloud:
        return 'packages/aeuniverse/assets/icons/key-ring.png';
      case AuthMethod.password:
        return 'packages/aeuniverse/assets/icons/password.png';
      default:
        return 'packages/aeuniverse/assets/icons/password.png';
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return method.index;
  }
}
