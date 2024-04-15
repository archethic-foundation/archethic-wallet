/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:js_util';

import 'package:aewallet/infrastructure/rpc/browser_extension_aws.js.dart';
import 'package:flutter/foundation.dart';

class WindowUtil {
  Future<void> showFirst() async {
    if (kIsWeb) {
      updateWindow(windowIdCurrent, jsify({'focused': true}));
    }
  }
}
