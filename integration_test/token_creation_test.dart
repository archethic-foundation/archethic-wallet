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
    await $(#createTokenFungible).tap();
    await $(#ftName).enterText('ftTest');
    await $(#ftSymbol).enterText('DCO');
    await $(#ftOffer).enterText('10');
    await $(#createToken).tap();
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
