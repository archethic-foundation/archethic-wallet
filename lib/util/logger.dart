import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

extension LoggerSetup on Logger {
  static Future<void> setup() async {
    Logger.root.level = kDebugMode ? Level.ALL : Level.INFO;
    if (kIsWeb) {
      Logger.root.onRecord.listen((event) {
        debugPrint('[${event.loggerName}] ${event.message}');
        if (event.error != null) {
          debugPrint('\t${event.error}');
        }
        if (event.stackTrace != null) {
          debugPrint('\t${event.stackTrace}');
        }
      });
    }

    if (!kIsWeb) {
      Logger.root.onRecord.listen((event) {
        dev.log(
          event.message,
          name: event.loggerName,
          error: event.error,
          stackTrace: event.stackTrace,
          level: event.level.value,
          time: event.time,
          sequenceNumber: event.sequenceNumber,
          zone: event.zone,
        );
      });
    }
  }
}
