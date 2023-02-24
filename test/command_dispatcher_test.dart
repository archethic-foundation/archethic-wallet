// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Command dispatcher', () {
    test(
      'Should run commands sequentially and return Handler result',
      () async {
        final dispatcher = CommandDispatcher()
          ..addHandler(
            CommandHandler(
              canHandle: (commandData) => commandData is String,
              handle: (command) async => Result.success(command),
            ),
          );

        final result0 = await dispatcher.add('test command 0');
        final result1 = await dispatcher.add('test command 1');

        expect(result0.valueOrNull, 'test command 0');
        expect(result1.valueOrNull, 'test command 1');
      },
    );

    test(
      'Should rethrow handler errors',
      () async {
        final dispatcher = CommandDispatcher()
          ..addHandler(
            CommandHandler(
              canHandle: (commandData) => commandData is String,
              handle: (_) async {
                throw Exception();
              },
            ),
          );

        expect(
          () => dispatcher.add('test command 0'),
          throwsA(const TypeMatcher<Exception>()),
        );
      },
    );
  });
}
