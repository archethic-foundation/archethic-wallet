/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:aewallet/util/universal_platform.dart';
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
      if (UniversalPlatform.isDesktop) {
        return true;
      } else {
        return false;
      }
    }
  }
}
