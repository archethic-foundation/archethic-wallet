import 'package:aewallet/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'config.dart';

void main() {
  patrolTest('As a user I can send UCOs',
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

    await $(#sendUCObutton).tap();
    await $(#UCOreceiverAddress).enterText(
        '00009fe64c7600473a26596058b07f8a4866947b062e7132127f8e9edc05747fd3de');
    await $(#ucoTransferAmount).enterText('100');
    expect($(#transferFeesCalculation).exists, equals(true));
    await $(#ucoTransferButtonOK).tap();
    await $(#ucoTransferButtonConfirm).tap();

    const pinConfirmLength = 6;
    for (var i = pinConfirmLength; i >= 1; i--) {
      await $('0').tap(
        settleTimeout: const Duration(minutes: 10),
      );
    }
    expect($(#transactionHistory), findsOneWidget);
  });
}
