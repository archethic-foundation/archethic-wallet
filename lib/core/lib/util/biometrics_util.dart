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
  /// @returns [true] if device has fingerprint/faceID available and registered, [false] otherwise
  Future<bool> hasBiometrics() async {
    if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      final LocalAuthentication localAuth = LocalAuthentication();
      final bool canCheck = await localAuth.canCheckBiometrics;
      if (canCheck) {
        final List<BiometricType> availableBiometrics =
            await localAuth.getAvailableBiometrics();
        //for (BiometricType type in availableBiometrics) {
        //sl.get<Logger>().i(type.toString());
        //sl.get<Logger>().i("${type == BiometricType.face ? 'face' : type == BiometricType.iris ? 'iris' : type == BiometricType.fingerprint ? 'fingerprint' : 'unknown'}");
        //}

        if (availableBiometrics.contains(BiometricType.face)) {
          return true;
        } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
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
  /// @returns [true] if successfully authenticated, [false] otherwise
  Future<bool> authenticateWithBiometrics(
      BuildContext context, String message) async {
    final bool hasBiometricsEnrolled = await hasBiometrics();
    if (hasBiometricsEnrolled) {
      final LocalAuthentication localAuth = LocalAuthentication();
      return await localAuth.authenticate(
          localizedReason: message,
          useErrorDialogs: false,
          biometricOnly: true);
    }
    return false;
  }
}
