/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:aewallet/util/universal_platform.dart';
// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';

/// Utilities for haptic feedback
class HapticUtil {
  /// Feedback
  void feedback(
    FeedbackType feedbackType,
    bool activeVibrations,
  ) {
    _asyncfeedback(feedbackType, activeVibrations);
  }

  Future<void> _asyncfeedback(
    FeedbackType feedbackType,
    bool activeVibrations,
  ) async {
    if (activeVibrations == false) {
      return;
    }
    if (UniversalPlatform.isMobile && await Vibrate.canVibrate) {
      Vibrate.feedback(feedbackType);
    }
  }
}
