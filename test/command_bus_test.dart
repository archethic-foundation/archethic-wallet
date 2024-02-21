// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter_test/flutter_test.dart';

class RPCFailureMatcher implements Matcher {
  RPCFailureMatcher(this.expectedFailure);

  final awc.Failure expectedFailure;

  @override
  Description describe(Description description) {
    return description.add('is a Result.failure with $expectedFailure.');
  }

  @override
  Description describeMismatch(
    dynamic item,
    Description mismatchDescription,
    Map matchState,
    bool verbose,
  ) {
    final result = item as Result<dynamic, awc.Failure>;
    return mismatchDescription.add(
      result.map(
        success: (success) => 'is a Result.success',
        failure: (failure) => 'is a Result.failure with $failure',
      ),
    );
  }

  @override
  bool matches(dynamic item, Map matchState) {
    final result = item as Result<dynamic, awc.Failure>;

    return result.map(
      success: (success) {
        return false;
      },
      failure: (failure) {
        return failure == expectedFailure;
      },
    );
  }
}

void main() {
  group('Command bus', () {
    test(
      'Should run commands sequentially and return Handler result',
      () async {
        final commandBus = CommandBus()
          ..addHandler(
            CommandHandler(
              canHandle: (commandData) => commandData is String,
              handle: (command) async => Result.success(command),
            ),
          );

        final result0 = await commandBus.add('test command 0');
        final result1 = await commandBus.add('test command 1');

        expect(result0.valueOrNull, 'test command 0');
        expect(result1.valueOrNull, 'test command 1');
      },
    );

    test(
      'Should rethrow handler errors',
      () async {
        final commandBus = CommandBus()
          ..addHandler(
            CommandHandler(
              canHandle: (commandData) => commandData is String,
              handle: (_) async {
                throw awc.Failure.connectivity;
              },
            ),
          );

        expect(
          commandBus.add('test command 0'),
          completion(RPCFailureMatcher(awc.Failure.connectivity)),
        );
      },
    );
  });
}
