//@Timeout(Duration(seconds: 90))
import 'package:aewallet/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';

import 'config.dart';

void main() {
  patrolTest('As a user I can sent a NFT',
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
    await $(#nftNocategory).tap();
    await $(#nft0).tap();
    await $(#nftSendButton).tap();
    await $(#nftReceiverAddress).enterText(
        '00009fe64c7600473a26596058b07f8a4866947b062e7132127f8e9edc05747fd3de',);
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
