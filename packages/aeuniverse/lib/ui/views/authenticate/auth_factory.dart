import 'package:aeuniverse/ui/views/password_screen.dart';
import 'package:aeuniverse/ui/views/pin_screen.dart';
import 'package:aeuniverse/ui/views/yubikey_screen.dart';
import 'package:core/localization.dart';
import 'package:core/model/authentication_method.dart';
import 'package:core/util/biometrics_util.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/haptic_util.dart';
import 'package:core/util/vault.dart';
import 'package:core_ui/ui/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AuthFactory {
  static Future<bool> authenticate(
      BuildContext context, AuthenticationMethod authMethod,
      {bool transitions = false}) async {
    bool auth = false;
    switch (authMethod.method) {
      case (AuthMethod.yubikeyWithYubicloud):
        auth =
            await _authenticateWithYubikey(context, transitions: transitions);
        break;
      case (AuthMethod.password):
        auth =
            await _authenticateWithPassword(context, transitions: transitions);
        break;
      case (AuthMethod.pin):
        auth = await _authenticateWithPin(context);
        break;
      case (AuthMethod.biometrics):
        final bool hasBiometrics =
            await sl.get<BiometricUtil>().hasBiometrics();
        if (hasBiometrics) {
          auth = await _authenticateWithBiometrics(context);
        }
        break;
      default:
        break;
    }
    if (auth) {
      sl.get<HapticUtil>().feedback(FeedbackType.success);
    } else {
      sl.get<HapticUtil>().feedback(FeedbackType.error);
    }
    return auth;
  }

  static Future<bool> _authenticateWithYubikey(BuildContext context,
      {bool transitions = false}) async {
    bool auth = false;
    if (transitions) {
      auth = await Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return const YubikeyScreen();
      })) as bool;
    } else {
      auth = await Navigator.of(context)
          .push(NoPushTransitionRoute(builder: (BuildContext context) {
        return const YubikeyScreen();
      })) as bool;
    }
    return auth;
  }

  static Future<bool> _authenticateWithPassword(BuildContext context,
      {bool transitions = false}) async {
    bool auth = false;
    if (transitions) {
      auth = await Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return const PasswordScreen();
      })) as bool;
    } else {
      auth = await Navigator.of(context)
          .push(NoPushTransitionRoute(builder: (BuildContext context) {
        return const PasswordScreen();
      })) as bool;
    }
    return auth;
  }

  static Future<bool> _authenticateWithPin(BuildContext context,
      {bool transitions = false}) async {
    final Vault _vault = await Vault.getInstance();
    final String? expectedPin = _vault.getPin();
    bool auth = false;
    if (transitions) {
      auth = await Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return PinScreen(
          PinOverlayType.enterPin,
          expectedPin: expectedPin!,
          description: AppLocalization.of(context)!.pinSecretPhraseBackup,
        );
      })) as bool;
    } else {
      auth = await Navigator.of(context)
          .push(NoPushTransitionRoute(builder: (BuildContext context) {
        return PinScreen(
          PinOverlayType.enterPin,
          expectedPin: expectedPin!,
          description: AppLocalization.of(context)!.pinSecretPhraseBackup,
        );
      })) as bool;
    }
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return auth;
  }

  static Future<bool> _authenticateWithBiometrics(BuildContext context) async {
    final bool auth = await sl.get<BiometricUtil>().authenticateWithBiometrics(
        context, AppLocalization.of(context)!.unlockBiometrics);
    return auth;
  }
}
