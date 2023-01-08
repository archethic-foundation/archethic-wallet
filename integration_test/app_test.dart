//@Timeout(Duration(seconds: 90))
import 'dart:async';

import 'package:aewallet/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'config.dart';

void main() {
  patrolTest('As a user I can create a Wallet',
      nativeAutomatorConfig: nativeAutomatorConfig,
      nativeAutomation: true, ($) async {
    await app.main();

    // accepter les conditions et créer un nouveau wallet
    await $(CheckboxListTile).tap();
    await $(#newWallet).tap();

    // entrer un nom dans le champ et OK
    await $(#walletName).enterText('test_wallet_001');
    await $(#okButton).tap();

// répondre non à la quesition et vérifier que l'on est sur la saiie de nom
    await $('Non').tap();

// taper sur le réseau et vérifier que l'on arrive sur la sélection de réseau

    //await $('Archethic Main Network').tap();

    // tap sur testnet
    //await $('Archethic Test Network').tap();

    // répondre oui à la question et vérifier que l'on arrive sur
    await $(#okButton).tap();
    await $('Oui').tap();
    await $(#understandButton).tap();
    await $(#iveBackedItUp).tap();
    //await $(#backUpButton).tap();
    await $(#pass).tap();
    await $('Oui').tap();
    await $('PIN').tap();

    // code pin 000000 avec confirmation
    await pincode000000wConfirmation($);
  });

  patrolTest('As a user I can send UCOs',
      nativeAutomatorConfig: nativeAutomatorConfig,
      nativeAutomation: true, ($) async {
    await app.main();
  });

  Future<void> pincode000000wConfirmation(PatrolTester $) async {
    // code pin 000000 avec confirmation
    var length = 12;
    for (var i = length; i >= 1; i--) {
      await $('0').tap();
    }
  }
}
