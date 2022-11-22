/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

/// Custom locale-specific uppercase/lowercase methods
class CaseChange {
  static String toUpperCase(String input, String languageCode) {
    final locale = Locale(languageCode);
    if (locale.languageCode == 'tr') {
      return input.replaceAll('i', 'İ').toUpperCase();
    } else if (locale.languageCode == 'de') {
      return input.replaceAll('ß', 'SS').toUpperCase();
    }
    return input.toUpperCase();
  }
}
