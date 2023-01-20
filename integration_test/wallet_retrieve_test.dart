//@Timeout(Duration(seconds: 90))
import 'package:aewallet/main.dart' as app;
import 'package:aewallet/ui/views/transactions/transaction_recent_list.dart';
import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';

import 'config.dart';

void main() {
  patrolTest('As a user I can retrieve my wallet',
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

    await $(#accountName1).tap();
    //final accountSelector = createFinder(RegExp('.*HFF.*'));
    //await $(accountSelector).tap();

    await $(#accessModePIN).tap();

    // code pin 000000 avec confirmation
    const pinLength = 12;
    for (var i = pinLength; i >= 1; i--) {
      await $('0').tap(
        settleTimeout: const Duration(minutes: 10),
      );
    }
    await $(TxListLine).at(0).tap();
  });
}
