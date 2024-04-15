import 'package:aewallet/util/universal_platform.dart';
import 'package:window_manager/window_manager.dart';

/// SPDX-License-Identifier: AGPL-3.0-or-later

class WindowUtil {
  Future<void> showFirst() async {
    if (UniversalPlatform.isDesktop) {
      await windowManager.show();
    }
  }
}
