/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';

class ScreenUtil {
  static bool isDesktopMode() {
    if (kIsWeb) {
      if (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android) {
        return false;
      } else {
        return true;
      }
    } else {
      if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
        return true;
      } else {
        return false;
      }
    }
  }
}
