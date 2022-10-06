import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeviceAbilities {
  static final hasBiometricsProvider = FutureProvider<bool>(
    (ref) async {
      return sl.get<BiometricUtil>().hasBiometrics();
    },
  );
}
