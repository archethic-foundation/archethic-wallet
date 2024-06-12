import 'package:aewallet/util/universal_platform.dart';
import 'package:flutter/widgets.dart';

class WindowSize {
  factory WindowSize() => _instance ??= WindowSize._();
  WindowSize._();

  static WindowSize? _instance;

  Size get idealSize {
    if (UniversalPlatform.isLinux) return const Size(430, 850);
    if (UniversalPlatform.isWeb) return const Size(500, 800);
    return const Size(370, 800);
  }

  BoxConstraints get constraints => BoxConstraints(
        maxWidth: idealSize.width,
      );
}
