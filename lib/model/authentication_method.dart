// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/model/setting_item.dart';

enum AuthMethod { PIN, BIOMETRICS, YUBIKEY_WITH_YUBICLOUD }

/// Represent the available authentication methods our app supports
class AuthenticationMethod extends SettingSelectionItem {
  AuthenticationMethod(this.method);

  AuthMethod method;

  @override
  String getDisplayName(BuildContext context) {
    switch (method) {
      case AuthMethod.BIOMETRICS:
        return AppLocalization.of(context)!.biometricsMethod;
      case AuthMethod.PIN:
        return AppLocalization.of(context)!.pinMethod;
      case AuthMethod.YUBIKEY_WITH_YUBICLOUD:
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
