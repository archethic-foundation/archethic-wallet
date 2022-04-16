/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';

/// Utilities for haptic feedback
class HapticUtil {
  /// Feedback
  Future<void> feedback(FeedbackType feedbackType) async {
    if ((!kIsWeb && (Platform.isIOS || Platform.isAndroid)) &&
        await Vibrate.canVibrate) {
      Vibrate.feedback(feedbackType);
    }
  }
}
