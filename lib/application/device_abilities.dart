import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

class DeviceAbilities {
  // TODO(reddwarf03): Don't use providers. Not necessary
  static final hasBiometricsProvider = FutureProvider<bool>(
    (ref) async {
      if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
        final localAuth = LocalAuthentication();
        final canCheck = await localAuth.canCheckBiometrics;
        if (canCheck) {
          final availableBiometrics = await localAuth.getAvailableBiometrics();
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
    },
  );

  static final hasNotificationsProvider = Provider<bool>(
    (ref) {
      if (kIsWeb == false &&
          (Platform.isIOS == true ||
              Platform.isAndroid == true ||
              Platform.isLinux == true ||
              Platform.isMacOS == true)) {
        return true;
      }
      return false;
    },
  );

  static final hasQRCodeProvider = Provider<bool>(
    (ref) {
      if (kIsWeb == false &&
          (Platform.isIOS == true || Platform.isAndroid == true)) {
        return true;
      }
      return false;
    },
  );
}
