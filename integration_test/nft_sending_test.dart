//@Timeout(Duration(seconds: 90))
import 'package:aewallet/main.dart' as app;
import 'package:patrol/patrol.dart';

import 'action/import_wallet.dart';
import 'config.dart';

void main() {
  patrolTest('As a user I can sent a NFT',
      nativeAutomatorConfig: nativeAutomatorConfig,
      nativeAutomation: true, ($) async {
    await app.main();

    await importWalletAction($);

    await $(#bottomBarAddressNFTlink).tap();
    await $(#nftNocategory).tap();
    await $(#nft0).tap();
    await $(#nftSendButton).tap();
    await $(#nftReceiverAddress).enterText(
      '00009fe64c7600473a26596058b07f8a4866947b062e7132127f8e9edc05747fd3de',
    );
    await $(#nftSend).tap();
    await $(#nftSendConfirmation).tap();
    // code pin 000000
    const pinConfirmationLength = 6;
    for (var i = pinConfirmationLength; i >= 1; i--) {
      await $('0').tap(
        settleTimeout: const Duration(minutes: 10),
      );
    }
  });
}
