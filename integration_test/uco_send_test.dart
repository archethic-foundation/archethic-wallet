// import 'package:aewallet/main.dart' as app;
// import 'package:flutter_test/flutter_test.dart';
// import 'package:patrol/patrol.dart';

// import 'action/import_wallet.dart';
// import 'action/pin_confirmation.dart';
// import 'config/config.dart';

// void main() {
//   patrolTest('As a user I can send UCOs',
//       nativeAutomatorConfig: nativeAutomatorConfig, ($) async {
//     await app.main();
//     await importWalletAction($);

//     await $(#sendUCObutton).tap();
//     await $(#UCOreceiverAddress).enterText(
//       testWalletConf.aliceAccount.address,
//     );
//     await $(#ucoTransferAmount).enterText('100');
//     expect($(#transferFeesCalculation).exists, equals(true));
//     await $(#ucoTransferButtonOK).tap();
//     await $(#ucoTransferButtonConfirm).tap();

//     await validPinConfirmation($);
//     expect($(#transactionHistory), findsOneWidget);
//   });
// }
