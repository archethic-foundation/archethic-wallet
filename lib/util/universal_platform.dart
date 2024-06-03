import 'dart:io';

import 'package:flutter/foundation.dart';

abstract class UniversalPlatform {
  static UniversalPlatformType get value {
    if (kIsWeb) return UniversalPlatformType.web;
    if (Platform.isWindows) return UniversalPlatformType.windows;
    if (Platform.isFuchsia) return UniversalPlatformType.fuchsia;
    if (Platform.isMacOS) return UniversalPlatformType.macOS;
    if (Platform.isLinux) return UniversalPlatformType.linux;
    if (Platform.isIOS) return UniversalPlatformType.iOS;
    return UniversalPlatformType.android;
  }

  static bool get isWeb => value == UniversalPlatformType.web;
  static bool get isMacOS => value == UniversalPlatformType.macOS;
  static bool get isWindows => value == UniversalPlatformType.windows;
  static bool get isLinux => value == UniversalPlatformType.linux;
  static bool get isAndroid => value == UniversalPlatformType.android;
  static bool get isIOS => value == UniversalPlatformType.iOS;
  static bool get isFuchsia => value == UniversalPlatformType.fuchsia;

  static bool get isApple => isIOS || isMacOS;
  static bool get isMobile => isIOS || isAndroid;
  static bool get isDesktop => isMacOS || isLinux || isWindows;
  static bool get isDesktopOrWeb => isDesktop || isWeb;
}

enum UniversalPlatformType { web, windows, linux, macOS, android, fuchsia, iOS }
