// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:aewallet/domain/service/rpc/command_dispatcher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Command dispatcher', () {
    test(
      'Should run commands sequentially and return Handler result',
      () async {
        final dispatcher = CommandDispatcher<String, String>();
        dispatcher.handler = (command) async => command;

        final result0 = await dispatcher.add('test command 0');
        final result1 = await dispatcher.add('test command 1');

        expect(result0, 'test command 0');
        expect(result1, 'test command 1');
      },
    );

    test(
      'Should rethrow handler errors',
      () async {
        final dispatcher = CommandDispatcher<String, String>();
        dispatcher.handler = (_) async {
          throw Exception();
        };

        expect(
          () => dispatcher.add('test command 0'),
          throwsA(const TypeMatcher<Exception>()),
        );
      },
    );
  });
}
