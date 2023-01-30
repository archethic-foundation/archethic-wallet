//@Timeout(Duration(seconds: 90))

import 'package:aewallet/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';

import 'action/pin_confirmation.dart';
import 'config/config.dart';

void main() {
  patrolTest('As a user I can create a Wallet',
      nativeAutomatorConfig: nativeAutomatorConfig,
      nativeAutomation: true, ($) async {
    await app.main();
    await $.pumpWidgetAndSettle(
      const app.App(),
      timeout: const Duration(minutes: 10),
    );

    // accepter les conditions et créer un nouveau wallet
    await $(CheckboxListTile).tap();
    await $(#newWallet).tap();

    // entrer un nom dans le champ et OK
    await $(#newAccountName).enterText('test_wallet_001');

    // taper sur le réseau et vérifier que l'on arrive sur la sélection de réseau
    final netNameFinder = createFinder(RegExp('.*Archethic Main Network.*'));
    await $(netNameFinder).tap();
    final testNetFinder = createFinder(RegExp('.*testnet.*'));
    await $(testNetFinder).tap();

    await $(#okButton).tap();

// répondre non à la quesition et vérifier que l'on est sur la saiie de nom
    await $(#cancelButton).tap();

    // répondre oui à la question
    await $(#okButton).tap();
    await $(#yesButton).tap();
    await $(#understandButton).tap();
    await $(#iveBackedItUp).tap();
    await $(#pass).tap();

    await $(#yesButton).tap();
    await $('PIN').tap();

    // code pin 000000 avec confirmation
    await validPinConfirmation($);
    await validPinConfirmation($);
  });
}
