// @dart=2.9

// Dart imports:
import 'dart:math';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show isHex;

class AppSeeds {
  static bool isValidSeed(String seed) {
    if (seed == null || seed.length != 64) {
      return false;
    }
    // Ensure seed only contains hex characters, 0-9;A-F
    return isHex(seed);
  }

  static String generateSeed() {
    String result = '';
    const String chars = 'abcdef0123456789';
    final Random rng = Random.secure();
    for (int i = 0; i < 64; i++) {
      result += chars[rng.nextInt(chars.length)];
    }
    return result.toUpperCase();
  }
}
