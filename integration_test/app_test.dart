// ignore_for_file: avoid_print
import 'package:aewallet/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'config.dart';

// This is an example integration test using Patrol. Use it as a base to
// create your own Patrol-powered test.
//
// To run it, you have to use `patrol drive` instead of `flutter test`.

void main() {
  patrolTest(
    'test',
    nativeAutomatorConfig: nativeAutomatorConfig,
    nativeAutomation: true,
    ($) async {
      // Replace with your own app widget.
      await $.pumpWidgetAndSettle(const App());
    },
  );
}
