/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:typed_data';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:bip39_mnemonic/bip39_mnemonic.dart' as bip39;

// Project imports:
import 'package:aewallet/util/seeds.dart';

// ignore: avoid_classes_with_only_static_members
class AppMnemomics {
  /// Converts a seed to a 24-word mnemonic word list
  static List<String> seedToMnemonic(
    String seed, {
    String languageCode = 'en',
  }) {
    if (!AppSeeds.isValidSeed(seed)) {
      throw Exception('Invalid Seed');
    }
    final String words =
        bip39.Mnemonic(hexToUint8List(seed), getLanguage(languageCode))
            .sentence;
    return words.split(' ');
  }

  /// Convert a 24-word mnemonic word list to a seed
  static String mnemonicListToSeed(
    List<String> words, {
    String languageCode = 'en',
  }) {
    try {
      return uint8ListToHex(
        Uint8List.fromList(
          bip39.Mnemonic.fromSentence(
            words.join(' '),
            getLanguage(languageCode),
          ).entropy,
        ),
      );
    } catch (e) {
      return '';
    }
  }

  /// Validate a mnemonic word list
  static bool validateMnemonic(List<String> words) {
    if (words.length != 24) {
      return false;
    } else {
      return true;
    }
  }

  /// Validate a specific menmonic word
  static bool isValidWord(String word, {String languageCode = 'en'}) {
    final bip39.Language language = getLanguage(languageCode);
    return language.isValid(word);
  }

  static bip39.Language getLanguage(String languageCode) {
    switch (languageCode) {
      case 'fr':
        return bip39.Language.french;
      case 'en':
        return bip39.Language.english;
      default:
        return bip39.Language.english;
    }
  }
}
