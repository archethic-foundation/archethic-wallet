// Flutter imports:
import 'package:core/localization.dart';
import 'package:flutter/material.dart';

// Package imports:

// Project imports:
import 'package:core/model/setting_item.dart';

enum AuthMethod { pin, biometrics, yubikeyWithYubicloud, ledger }

/// Represent the available authentication methods our app supports
class AuthenticationMethod extends SettingSelectionItem {
  AuthenticationMethod(this.method);

  AuthMethod method;

  @override
  String getDisplayName(BuildContext context) {
    switch (method) {
      case AuthMethod.biometrics:
        return AppLocalization.of(context)!.biometricsMethod;
      case AuthMethod.pin:
        return AppLocalization.of(context)!.pinMethod;
      case AuthMethod.yubikeyWithYubicloud:
        return AppLocalization.of(context)!.yubikeyWithYubiCloudMethod;
      case AuthMethod.ledger:
        return AppLocalization.of(context)!.ledgerMethod;
      default:
        return AppLocalization.of(context)!.pinMethod;
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return method.index;
  }
}
