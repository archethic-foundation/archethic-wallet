import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:aeroot/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Create new account', (WidgetTester tester) async {
    app.main();
    await Future.delayed(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    final Finder buttonNewWallet = find.byKey(const Key('newWallet'));
    await tester.tap(buttonNewWallet);
    await Future.delayed(const Duration(seconds: 10));
    final Finder buttonUnderstandButton =
        find.byKey(const Key('understandButton'));
    await tester.tap(buttonUnderstandButton);
    await Future.delayed(const Duration(seconds: 10));
    final Finder buttonIveBackedItUp = find.byKey(const Key('iveBackedItUp'));
    await tester.tap(buttonIveBackedItUp);
    await Future.delayed(const Duration(seconds: 10));
    final Finder buttonYes = find.byKey(const Key('yes'));
    await tester.tap(buttonYes);
    await Future.delayed(const Duration(seconds: 10));
    expect(find.text('pin'), findsOneWidget);
  });
}
