//@Timeout(Duration(seconds: 90))
import 'package:aewallet/main.dart' as app;
import 'package:patrol/patrol.dart';

import 'action/import_wallet.dart';
import 'config.dart';

void main() {
  patrolTest('As a user I can create a NFT',
      nativeAutomatorConfig: nativeAutomatorConfig,
      nativeAutomation: true, ($) async {
    await app.main();
    await importWalletAction($);

    await $(#bottomBarAddressNFTlink).tap();
    await $(#nftCategory0).tap();
    await $(#createNFT).tap();
    await $(#nftCreationField).first.enterText('nftTest');
    await $(#next).tap();
    await $(#nftImportPhoto).tap();
//TODO(tecuzin): Add mock with a simple picture
    await $(#next).tap();
    await $(#nftName).enterText('nftTest');
    await $(#nftValue).enterText('10');
    await $(#next).tap();
    await $(#nftCreationConfirmation).tap();
    await $(#createTheNFT).tap();

    // code pin 000000
    const pinConfirmationLength = 6;
    for (var i = pinConfirmationLength; i >= 1; i--) {
      await $('0').tap(
        settleTimeout: const Duration(minutes: 10),
      );
    }
  });
}
