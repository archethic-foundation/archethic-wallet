/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:math';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show isHex;

class AppSeeds {
  static bool isValidSeed(String seed) {
    if (seed.length != 64) {
      return false;
    }
    // Ensure seed only contains hex characters, 0-9;A-F
    return isHex(seed);
  }

  static String generateSeed() {
    var result = '';
    const chars = 'abcdef0123456789';
    final rng = Random.secure();
    for (var i = 0; i < 64; i++) {
      // ignore: use_string_buffers
      result += chars[rng.nextInt(chars.length)];
    }
    return result.toUpperCase();
  }
}
