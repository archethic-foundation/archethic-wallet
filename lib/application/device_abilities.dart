import 'package:aewallet/util/universal_platform.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

class DeviceAbilities {
  // TODO(reddwarf03): Don't use providers. Not necessary
  static final hasBiometricsProvider = FutureProvider<bool>(
    (ref) async {
      if (UniversalPlatform.isMobile) {
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

  static final hasQRCodeProvider = Provider<bool>(
    (ref) {
      if (UniversalPlatform.isMobile) {
        return true;
      }
      return false;
    },
  );
}
