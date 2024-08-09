// //@Timeout(Duration(seconds: 90))
// import 'package:aewallet/main.dart' as app;
// import 'package:patrol/patrol.dart';

// import 'action/import_wallet.dart';
// import 'action/pin_confirmation.dart';
// import 'config/config.dart';

// void main() {
//   patrolTest('As a user I can send a NFT',
//       nativeAutomatorConfig: nativeAutomatorConfig, ($) async {
//     await app.main();

//     await importWalletAction($);

//     await $(#bottomBarAddressNFTlink).tap();
//     await $(#nftNocategory).tap();
//     await $(#nft0).tap();
//     await $(#nftSendButton).tap();
//     await $(#nftReceiverAddress).enterText(
//       testWalletConf.aliceAccount.address,
//     );
//     await $(#nftSend).tap();
//     await $(#nftSendConfirmation).tap();

//     await validPinConfirmation($);
//   });
// }
