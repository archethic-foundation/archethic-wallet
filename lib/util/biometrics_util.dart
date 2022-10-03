/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:local_auth/local_auth.dart';

class BiometricUtil {
  ///
  /// hasBiometrics()
  ///
  /// @returns true if device has fingerprint/faceID available and registered, false otherwise
  Future<bool> hasBiometrics() async {
    if (!kIsWeb &&
        (Platform.isIOS || Platform.isAndroid || Platform.isWindows)) {
      final localAuth = LocalAuthentication();
      final canCheck = await localAuth.canCheckBiometrics;
      if (canCheck) {
        final availableBiometrics =
            await localAuth.getAvailableBiometrics();
        if (availableBiometrics.contains(BiometricType.face) ||
            availableBiometrics.contains(BiometricType.fingerprint) ||
            availableBiometrics.contains(BiometricType.strong) ||
            availableBiometrics.contains(BiometricType.weak)) {
          return true;
        }
      }
      return false;
    } else {
      return false;
    }
  }

  ///
  /// authenticateWithBiometrics()
  ///
  /// @param [message] Message shown to user in FaceID/TouchID popup
  /// @returns true if successfully authenticated, false otherwise
  Future<bool> authenticateWithBiometrics(
    BuildContext context,
    String message,
  ) async {
    final hasBiometricsEnrolled = await hasBiometrics();
    if (hasBiometricsEnrolled) {
      final localAuth = LocalAuthentication();
      return localAuth.authenticate(
        localizedReason: message,
        options: const AuthenticationOptions(
          useErrorDialogs: false,
          biometricOnly: true,
        ),
      );
    }
    return false;
  }
}
