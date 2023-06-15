import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';

class SecurityManager {
  factory SecurityManager() {
    return _singleton;
  }

  SecurityManager._internal();
  static final SecurityManager _singleton = SecurityManager._internal();

  Future<bool> isDeviceJailbroken() async {
    return FlutterJailbreakDetection.jailbroken;
  }

  Future<bool> isDeviceDeveloperMode() async {
    return FlutterJailbreakDetection.developerMode;
  }
}
