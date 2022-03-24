// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// Project imports:
import 'package:aeroot/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Create new account', (WidgetTester tester) async {
    app.main();
    await Future.delayed(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    final Finder buttonNewWallet = find.byKey(const Key('newWallet'));
    await tester.tap(buttonNewWallet);
    await Future.delayed(const Duration(seconds: 2));
    final Finder buttonUnderstandButton =
        find.byKey(const Key('understandButton'));
    await tester.tap(buttonUnderstandButton);
    await Future.delayed(const Duration(seconds: 2));
    final Finder buttonIveBackedItUp = find.byKey(const Key('iveBackedItUp'));
    await tester.tap(buttonIveBackedItUp);
    await Future.delayed(const Duration(seconds: 5));
    await tester.pump();
    final Finder buttonYes = find.byKey(const Key('yes'));
    await tester.tap(buttonYes);
    await Future.delayed(const Duration(seconds: 2));
    final Finder pinButton1 = find.byKey(const Key('pinButton1'));
    await tester.tap(pinButton1);
    await tester.tap(pinButton1);
    await tester.tap(pinButton1);
    await tester.tap(pinButton1);
    await tester.tap(pinButton1);
    await tester.tap(pinButton1);
    await Future.delayed(const Duration(seconds: 2));
    final Finder pinButtonConfirm1 = find.byKey(const Key('pinButton1'));
    await tester.tap(pinButtonConfirm1);
    await tester.tap(pinButtonConfirm1);
    await tester.tap(pinButtonConfirm1);
    await tester.tap(pinButtonConfirm1);
    await tester.tap(pinButtonConfirm1);
    await tester.tap(pinButtonConfirm1);
    await Future.delayed(const Duration(seconds: 5));
    await tester.pump();
    expect(find.byKey(const Key('UCO')), findsOneWidget);
  });
}
