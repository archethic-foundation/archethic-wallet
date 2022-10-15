/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/views/authenticate/password_screen.dart';
import 'package:aewallet/ui/views/authenticate/pin_screen.dart';
import 'package:aewallet/ui/views/authenticate/yubikey_screen.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/vault.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AuthFactory {
  static Future<bool> authenticate(
    BuildContext context,
    WidgetRef ref,
    AuthenticationMethod authMethod, {
    bool transitions = false,
    bool activeVibrations = false,
  }) async {
    var auth = false;
    switch (authMethod.method) {
      case AuthMethod.yubikeyWithYubicloud:
        auth =
            await _authenticateWithYubikey(context, transitions: transitions);
        break;
      case AuthMethod.password:
        auth =
            await _authenticateWithPassword(context, transitions: transitions);
        break;
      case AuthMethod.pin:
        auth =
            await _authenticateWithPin(context, ref, transitions: transitions);
        break;
      case AuthMethod.biometrics:
        final hasBiometrics = await sl.get<BiometricUtil>().hasBiometrics();
        if (hasBiometrics) {
          auth = await _authenticateWithBiometrics(context);
        }
        break;
      case AuthMethod.biometricsUniris:
        break;
      case AuthMethod.ledger:
        break;
    }
    if (auth) {
      sl.get<HapticUtil>().feedback(FeedbackType.success, activeVibrations);
    } else {
      sl.get<HapticUtil>().feedback(FeedbackType.error, activeVibrations);
    }
    return auth;
  }

  static Future<bool> _authenticateWithYubikey(
    BuildContext context, {
    bool transitions = false,
  }) async {
    var auth = false;
    if (transitions) {
      auth = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const YubikeyScreen();
          },
        ),
      ) as bool;
    } else {
      auth = await Navigator.of(context).push(
        NoPushTransitionRoute(
          builder: (BuildContext context) {
            return const YubikeyScreen();
          },
        ),
      ) as bool;
    }
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return auth;
  }

  static Future<bool> _authenticateWithPassword(
    BuildContext context, {
    bool transitions = false,
  }) async {
    var auth = false;
    if (transitions) {
      auth = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const PasswordScreen();
          },
        ),
      ) as bool;
    } else {
      auth = await Navigator.of(context).push(
        NoPushTransitionRoute(
          builder: (BuildContext context) {
            return const PasswordScreen();
          },
        ),
      ) as bool;
    }
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return auth;
  }

  static Future<bool> _authenticateWithPin(
    BuildContext context,
    WidgetRef ref, {
    bool transitions = false,
  }) async {
    final vault = await Vault.getInstance();
    final expectedPin = vault.getPin();
    var auth = false;
    if (transitions) {
      // TODO(redDwarf03): add the description
      auth = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return PinScreen(
              PinOverlayType.enterPin,
              ref.watch(preferenceProvider).pinPadShuffle,
              expectedPin: expectedPin!,
            );
          },
        ),
      ) as bool;
    } else {
      auth = await Navigator.of(context).push(
        NoPushTransitionRoute(
          builder: (BuildContext context) {
            return PinScreen(
              PinOverlayType.enterPin,
              ref.watch(preferenceProvider).pinPadShuffle,
              expectedPin: expectedPin!,
            );
          },
        ),
      ) as bool;
    }
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return auth;
  }

  static Future<bool> _authenticateWithBiometrics(BuildContext context) async {
    final auth = await sl.get<BiometricUtil>().authenticateWithBiometrics(
          context,
          AppLocalization.of(context)!.unlockBiometrics,
        );
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return auth;
  }
}
