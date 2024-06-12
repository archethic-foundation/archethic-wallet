import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/views/authenticate/biometrics_screen.dart';
import 'package:aewallet/ui/views/authenticate/password_screen.dart';
import 'package:aewallet/ui/views/authenticate/pin_screen.dart';
import 'package:aewallet/ui/views/authenticate/yubikey_screen.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';

class AuthFactory {
  static Future<String> forceAuthenticate(
    BuildContext context,
    WidgetRef ref, {
    required AuthenticationMethod authMethod,
    bool canCancel = true,
  }) async {
    var authResult = await authenticate(
      context,
      ref,
      authMethod: authMethod,
      canCancel: canCancel,
    );

    while (authResult == null) {
      authResult = await authenticate(
        context,
        ref,
        authMethod: authMethod,
        canCancel: canCancel,
      );
    }
    return authResult;
  }

  static Future<String?> authenticate(
    BuildContext context,
    WidgetRef ref, {
    AuthenticationMethod? authMethod,
    bool canCancel = true,
    bool transitions = false,
    bool activeVibrations = false,
  }) async {
    String? auth;

    authMethod ??= AuthenticationMethod(
      ref.read(
        AuthenticationProviders.settings.select(
          (settings) => settings.authenticationMethod,
        ),
      ),
    );

    switch (authMethod.method) {
      case AuthMethod.yubikeyWithYubicloud:
        // TODO(Chralu): Generate a key with Yubikey
        auth = await _authenticateWithYubikey(
          context,
          canCancel: canCancel,
        )
            ? 'should_be_yubikey_generated'
            : null;
        break;
      case AuthMethod.password:
        auth = await _authenticateWithPassword(
          context,
          canCancel: canCancel,
        );
        break;
      case AuthMethod.pin:
        // TODO(Chralu): Use pin as key
        auth = await _authenticateWithPin(
          context,
          canCancel: canCancel,
        )
            ? 'should_be_pin'
            : null;
        break;
      case AuthMethod.biometrics:
        // TODO(Chralu): Generate a key with Biometrics
        final hasBiometrics = await sl.get<BiometricUtil>().hasBiometrics();
        if (hasBiometrics) {
          auth = await _authenticateWithBiometrics(context)
              ? 'should_be_biometrics_generated'
              : null;
        }
        break;
      case AuthMethod.ledger:
        break;
    }
    if (auth != null) {
      sl.get<HapticUtil>().feedback(FeedbackType.success, activeVibrations);
    } else {
      sl.get<HapticUtil>().feedback(FeedbackType.error, activeVibrations);
    }
    return auth;
  }

  static Future<bool> _authenticateWithYubikey(
    BuildContext context, {
    required canCancel,
  }) async {
    final auth = await context.push(
      YubikeyScreen.routerPage,
      extra: {'canNavigateBack': canCancel},
    );

    if (auth != null && auth is bool) {
      return auth;
    }

    return false;
  }

  static Future<String?> _authenticateWithPassword(
    BuildContext context, {
    required bool canCancel,
  }) async {
    final auth = await context.push(
      PasswordScreen.routerPage,
      extra: {'canNavigateBack': canCancel},
    );
    if (auth != null && auth is String) {
      return auth;
    }

    return null;
  }

  static Future<bool> _authenticateWithPin(
    BuildContext context, {
    required bool canCancel,
  }) async {
    final auth = await context.push(
      PinScreen.routerPage,
      extra: {
        'type': PinOverlayType.enterPin.name,
        'canNavigateBack': canCancel,
      },
    );
    if (auth != null && auth is bool) {
      return auth;
    }

    return false;
  }

  static Future<bool> _authenticateWithBiometrics(
    BuildContext context,
  ) async {
    final auth = await context.push(
      BiometricsScreen.routerPage,
    );
    if (auth != null && auth is bool) {
      return auth;
    }

    return false;
  }
}
