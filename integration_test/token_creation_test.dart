// import 'package:aewallet/main.dart' as app;
// import 'package:patrol/patrol.dart';

// import 'action/import_wallet.dart';
// import 'action/pin_confirmation.dart';
// import 'config/config.dart';

// void main() {
//   patrolTest('As a user I can create a token',
//       nativeAutomatorConfig: nativeAutomatorConfig, ($) async {
//     await app.main();
//     await importWalletAction($);

//     await $(#fungibleTokenTab).tap();
//     await $(#createTokenFungible).tap();
//     await $(#ftName).enterText('ftTest');
//     await $(#ftSymbol).enterText('DCO');
//     await $(#ftOffer).enterText('10');
//     await $(#createToken).tap();
//     await $(#confirm).tap(
//       settleTimeout: const Duration(minutes: 10),
//     );

//     await validPinConfirmation($);
//   });
// }
