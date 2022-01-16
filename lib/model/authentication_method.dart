// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/model/setting_item.dart';

enum AuthMethod { pin, biometrics, yubikeyWithYubicloud }

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
      default:
        return AppLocalization.of(context)!.pinMethod;
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return method.index;
  }
}
