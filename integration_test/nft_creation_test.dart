//@Timeout(Duration(seconds: 90))
import 'package:aewallet/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';

import 'config.dart';

void main() {
  patrolTest('As a user I can create a NFT',
      nativeAutomatorConfig: nativeAutomatorConfig,
      nativeAutomation: true, ($) async {
    await app.main();
    await $(CheckboxListTile).tap();
    await $(#importWallet).tap();
    final finder = createFinder(RegExp('.*testnet.*'));
    await $(finder).tap();

    final seedWord = [
      'pave',
      'shrug',
      'coffee',
      'daughter',
      'hip',
      'mechanic',
      'scale',
      'trigger',
      'lake',
      'resist',
      'way',
      'repair',
      'good',
      'animal',
      'tennis',
      'boost',
      'walk',
      'story',
      'dash',
      'brass',
      'buzz',
      'orphan',
      'feed',
      'connect'
    ];

    const length = 23;
    for (var index = 0; index <= length; index++) {
      final seedWordFieldFinder = createFinder(Key('seedWord$index'));
      await $(seedWordFieldFinder).scrollTo().enterText(seedWord[index]);
    }
    await $(#seedWordsOKbutton).tap(
      settleTimeout: const Duration(minutes: 10),
    );

    await $(#accessModePIN).tap();

    // code pin 000000 avec confirmation
    const pinLength = 12;
    for (var i = pinLength; i >= 1; i--) {
      await $('0').tap(
        settleTimeout: const Duration(minutes: 10),
      );
    }

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
