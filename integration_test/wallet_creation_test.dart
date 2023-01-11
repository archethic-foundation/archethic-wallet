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
    await $(#newAccountName).enterText('test_wallet_001');
    await $(#okButton).tap();

// répondre non à la quesition et vérifier que l'on est sur la saiie de nom
    await $(#cancelButton).tap();

    // taper sur le réseau et vérifier que l'on arrive sur la sélection de réseau

    //await $('Archethic Main Network').tap();

    // tap sur testnet
    //await $('Archethic Test Network').tap();

    // répondre oui à la question
    await $(#okButton).tap();
    await $(#okButton).tap();
    await $(#understandButton).tap();
    await $(#iveBackedItUp).tap();
    //await $(#backUpButton).tap();
    await $(#pass).tap();

    await $(#okButton).tap();
    await $('PIN').tap();

    // code pin 000000 avec confirmation
    const length = 12;
    for (var i = length; i >= 1; i--) {
      await $('0').tap();
    }

    await Future.delayed(const Duration(seconds: 60));
    expect($(#UCO), findsOneWidget);
  });

  patrolTest('As a user I can create a NFT',
      nativeAutomatorConfig: nativeAutomatorConfig,
      nativeAutomation: true, ($) async {
    $(#nftTab).tap();
    $(#noCategoryNFTs).tap();
    $(#createNFTbutton).tap();
  });
}
