import 'package:aewallet/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'action/import_wallet.dart';
import 'config.dart';

void main() {
  patrolTest('As a user I can send UCOs',
      nativeAutomatorConfig: nativeAutomatorConfig,
      nativeAutomation: true, ($) async {
    await app.main();
    await importWalletAction($);

    await $(#sendUCObutton).tap();
    await $(#UCOreceiverAddress).enterText(
      '00009fe64c7600473a26596058b07f8a4866947b062e7132127f8e9edc05747fd3de',
    );
    await $(#ucoTransferAmount).enterText('100');
    expect($(#transferFeesCalculation).exists, equals(true));
    await $(#ucoTransferButtonOK).tap();
    await $(#ucoTransferButtonConfirm).tap();

    const pinConfirmLength = 6;
    for (var i = pinConfirmLength; i >= 1; i--) {
      await $('0').tap(
        settleTimeout: const Duration(minutes: 10),
      );
    }
    expect($(#transactionHistory), findsOneWidget);
  });
}
