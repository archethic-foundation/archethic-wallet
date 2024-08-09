// //@Timeout(Duration(seconds: 90))
// import 'package:aewallet/main.dart' as app;
// import 'package:patrol/patrol.dart';

// import 'action/import_wallet.dart';
// import 'action/pin_confirmation.dart';
// import 'config/config.dart';

// void main() {
//   patrolTest('As a user I can send a token',
//       nativeAutomatorConfig: nativeAutomatorConfig, ($) async {
//     await app.main();

//     await importWalletAction($);

//     await $(#fungibleTokenTab).tap();
//     await $(#token1sendButton).tap();
//     await $(#tokenReceiverAddress).enterText(
//       testWalletConf.bobAccount.address,
//     );
//     await $(#ftAmount).enterText('10');
//     await $(#sendToken).tap(
//       settleTimeout: const Duration(minutes: 10),
//     );
//     await $(#confirm).tap(
//       settleTimeout: const Duration(minutes: 10),
//     );

//     await validPinConfirmation($);
//   });
// }
