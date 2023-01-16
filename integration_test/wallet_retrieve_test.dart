//@Timeout(Duration(seconds: 90))
import 'package:aewallet/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'config.dart';
import 'user_actions.dart';

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
      final finder = createFinder(Key('seedWord$index'));
      await $(finder).scrollTo().tap();
      await $(finder).enterText(seedWord[index]);
      //await $.native.pressBack();
    }

    await $(#seedWordsOKbutton).tap();
    await Future.delayed(const Duration(seconds: 60));

    final keychainFinder = createFinder(RegExp('HFF'));
    await $(keychainFinder).waitUntilVisible().tap();
    await Future.delayed(const Duration(seconds: 60));

    final pinButtonFinder = createFinder(RegExp('PIN'));
    await $(pinButtonFinder).tap();
    await Future.delayed(const Duration(seconds: 60));

    // code pin 000000 avec confirmation
    const pinLength = 12;
    for (var i = pinLength; i >= 1; i--) {
      await $('0').tap();
    }
  });
}
