import 'dart:io';

import 'package:flutter/foundation.dart';

abstract class UniversalPlatform {
  static UniversalPlatformType get value {
    if (kIsWeb) return UniversalPlatformType.Web;
    if (Platform.isWindows) return UniversalPlatformType.Windows;
    if (Platform.isFuchsia) return UniversalPlatformType.Fuchsia;
    if (Platform.isMacOS) return UniversalPlatformType.MacOS;
    if (Platform.isLinux) return UniversalPlatformType.Linux;
    if (Platform.isIOS) return UniversalPlatformType.IOS;
    return UniversalPlatformType.Android;
  }

  static bool get isWeb => value == UniversalPlatformType.Web;
  static bool get isMacOS => value == UniversalPlatformType.MacOS;
  static bool get isWindows => value == UniversalPlatformType.Windows;
  static bool get isLinux => value == UniversalPlatformType.Linux;
  static bool get isAndroid => value == UniversalPlatformType.Android;
  static bool get isIOS => value == UniversalPlatformType.IOS;
  static bool get isFuchsia => value == UniversalPlatformType.Fuchsia;

  static bool get isApple => isIOS || isMacOS;
  static bool get isMobile => isIOS || isAndroid;
  static bool get isDesktop => isMacOS || isLinux || isWindows;
  static bool get isDesktopOrWeb => isDesktop || isWeb;
}

enum UniversalPlatformType { Web, Windows, Linux, MacOS, Android, Fuchsia, IOS }
