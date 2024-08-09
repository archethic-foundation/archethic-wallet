// //@Timeout(Duration(seconds: 90))

// import 'package:aewallet/main.dart' as app;
// import 'package:flutter/material.dart';
// import 'package:patrol/patrol.dart';

// import 'action/pin_confirmation.dart';
// import 'config/config.dart';

// void main() {
//   patrolTest('As a user I can create a Wallet',
//       nativeAutomatorConfig: nativeAutomatorConfig, ($) async {
//     await app.main();
//     await $.pumpWidgetAndSettle(
//       const app.App(),
//       timeout: const Duration(minutes: 10),
//     );

//     // Accept conditions and request a new wallet
//     await $(CheckboxListTile).tap();
//     await $(#newWallet).tap();

//     await $(#newAccountName).enterText('test_wallet_001');

//     // Select the testnet network
//     final netNameFinder = createFinder(RegExp('.*Archethic Main Network.*'));
//     await $(netNameFinder).tap();
//     final testNetFinder = createFinder(RegExp('.*testnet.*'));
//     await $(testNetFinder).tap();

//     await $(#okButton).tap();

//     // test the confirmation dialog and pass the backup verification stage
//     await $(#cancelButton).tap();
//     await $(#okButton).tap();
//     await $(#yesButton).tap();
//     await $(#understandButton).tap();
//     await $(#iveBackedItUp).tap();
//     await $(#pass).tap();

//     await $(#yesButton).tap();
//     await $('PIN').tap();

//     await validPinConfirmation($);
//     await validPinConfirmation($);
//   });
// }
