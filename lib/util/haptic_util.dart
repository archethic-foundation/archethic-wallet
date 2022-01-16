// Flutter imports:
import 'dart:io';

// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';

/// Utilities for haptic feedback
class HapticUtil {
  /// Feedback
  Future<void> feedback(FeedbackType feedbackType) async {
    if ((Platform.isIOS || Platform.isAndroid) && await Vibrate.canVibrate) {
      Vibrate.feedback(feedbackType);
    }
  }
}
