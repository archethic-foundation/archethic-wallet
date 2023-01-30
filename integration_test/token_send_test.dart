//@Timeout(Duration(seconds: 90))
import 'package:aewallet/main.dart' as app;
import 'package:patrol/patrol.dart';

import 'action/import_wallet.dart';
import 'config.dart';

void main() {
  patrolTest('As a user I can create a token',
      nativeAutomatorConfig: nativeAutomatorConfig,
      nativeAutomation: true, ($) async {
    await app.main();

    await importWalletAction($);

    await $(#fungibleTokenTab).tap();
    await $(#token1sendButton).tap();
    await $(#tokenReceiverAddress).enterText(
      '0000125AF7422FEAF6106C966E1B64D1CD15A18EBDF519DC9360D7669667F1F9C243',
    );
    await $(#ftAmount).enterText('10');
    await $(#sendToken).tap(
      settleTimeout: const Duration(minutes: 10),
    );
    await $(#confirm).tap(
      settleTimeout: const Duration(minutes: 10),
    );
    // code pin 000000
    const pinConfirmationLength = 6;
    for (var i = pinConfirmationLength; i >= 1; i--) {
      await $('0').tap(
        settleTimeout: const Duration(minutes: 10),
      );
    }
  });
}
