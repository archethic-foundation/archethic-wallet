// @dart=2.9

import 'dart:io';
import 'package:flutter/services.dart';

import 'package:device_info/device_info.dart';
import 'package:vibration/vibration.dart';

/// Utilities for haptic feedback
class HapticUtil {
  /// Return true if this device supports taptic engine (iPhone 7+)
  Future<bool> hasTapicEngine() async {
    if (!Platform.isIOS) {
      return false;
    }
    final IosDeviceInfo deviceInfo = await DeviceInfoPlugin().iosInfo;
    final String deviceIdentifier = deviceInfo.utsname.machine;
    switch (deviceIdentifier) {
      case 'iPhone5,1': // iPhone 5
      case 'iPhone5,2': // iPhone 5
      case 'iPhone5,3': // iPhone 5C
      case 'iPhone5,4': // iPhone 5C
      case 'iPhone6,1': // iPhone 5S
      case 'iPhone6,2': // iPhone 5S
      case 'iPhone7,2': // iPhone 6
      case 'iPhone7,1': // iPhone 6 plus
      case 'iPhone8,1': // iPhone 6s
      case 'iPhone8,2': // iPhone 6s plus
        return false;
      default:
        return true;
    }
  }

  /// Feedback for error
  Future<void> error() async {
    if (Platform.isIOS) {
      // If this is simulator or this device doesnt have tapic then we can't use this
      if (await hasTapicEngine() && await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 200);
      } else {
        HapticFeedback.vibrate();
      }
    } else {
      HapticFeedback.vibrate();
    }
  }

  /// Feedback for success
  Future<void> success() async {
    if (Platform.isIOS) {
      // If this is simulator or this device doesnt have tapic then we can't use this
      if (await hasTapicEngine() && await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 200);
      } else {
        HapticFeedback.mediumImpact();
      }
    } else {
      HapticFeedback.mediumImpact();
    }
  }

  /// Feedback for fingerprint success
  /// iOS-only, since Android already gives us feedback on success
  Future<void> fingerprintSucess() async {
    if (Platform.isIOS) {
      Future.delayed(const Duration(milliseconds: 50), () => success());
    }
  }
}
