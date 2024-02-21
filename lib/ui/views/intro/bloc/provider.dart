import 'dart:io';

import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntroProviders {
  static final accessModesProvider = FutureProvider<List<AuthMethod>>(
    (ref) async {
      final biometricsAvailable = await sl.get<BiometricUtil>().hasBiometrics();

      var accessModes = <AuthMethod>[];
      if (kIsWeb) {
        accessModes = <AuthMethod>[
          AuthMethod.password,
        ];
      } else {
        accessModes = <AuthMethod>[
          AuthMethod.pin,
          AuthMethod.password,
        ];
        if (biometricsAvailable) {
          accessModes.add(AuthMethod.biometrics);
        }
        accessModes.add(AuthMethod.yubikeyWithYubicloud);
        if (Platform.isAndroid || Platform.isIOS) {
          accessModes
            ..add(AuthMethod.discord)
            ..add(AuthMethod.google);
        }
      }
      return accessModes;
    },
  );
}
