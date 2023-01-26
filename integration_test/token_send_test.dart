//@Timeout(Duration(seconds: 90))
import 'package:aewallet/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';

import 'config.dart';

void main() {
  patrolTest('As a user I can create a token',
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
      await $(seedWordFieldFinder).tap();
      await $(seedWordFieldFinder).scrollTo().enterText(seedWord[index]);
    }
    await $(#seedWordsOKbutton).tap(
      settleTimeout: const Duration(minutes: 10),
    );

    await $(#accountName0).tap(
      settleTimeout: const Duration(minutes: 5),
    );

    await $(#accessModePIN).tap();

    // code pin 000000 avec confirmation
    const pinLength = 12;
    for (var i = pinLength; i >= 1; i--) {
      await $('0').tap(
        settleTimeout: const Duration(minutes: 10),
      );
    }

    await $(#fungibleTokenTab).tap();
    await $(#token1sendButton).tap();
    await $(#tokenReceiverAddress).enterText(
      '0000125AF7422FEAF6106C966E1B64D1CD15A18EBDF519DC9360D7669667F1F9C243',
    );
    await $(#ftAmount).enterText('10');
    await $(#sendToken).tap(
      settleTimeout: const Duration(minutes: 10),
    );
    await $(#confirm).tap(
      settleTimeout: const Duration(minutes: 10),
    );
    // code pin 000000
    const pinConfirmationLength = 6;
    for (var i = pinConfirmationLength; i >= 1; i--) {
      await $('0').tap(
        settleTimeout: const Duration(minutes: 10),
      );
    }
  });
}
