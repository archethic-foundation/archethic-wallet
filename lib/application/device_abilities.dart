import 'dart:io';

import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeviceAbilities {
  static final hasBiometricsProvider = FutureProvider<bool>(
    (ref) async {
      return sl.get<BiometricUtil>().hasBiometrics();
    },
  );

  static final hasNotificationsProvider = Provider<bool>(
    (ref) {
      if (kIsWeb == false &&
          (Platform.isIOS == true ||
              Platform.isAndroid == true ||
              Platform.isMacOS == true)) {
        return true;
      }
      return false;
    },
  );

  static final hasQRCodeProvider = Provider<bool>(
    (ref) {
      if (!kIsWeb &&
          (Platform.isIOS == true ||
              Platform.isAndroid == true ||
              Platform.isMacOS == true)) {
        return true;
      }
      return false;
    },
  );
}
