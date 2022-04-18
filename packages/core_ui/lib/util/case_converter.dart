/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
/// Custom locale-specific uppercase/lowercase methods
class CaseChange {
  static String toUpperCase(String input, String languageCode) {
    final Locale locale = Locale(languageCode);
    if (locale.languageCode == 'tr') {
      input = input.replaceAll('i', 'İ');
    } else if (locale.languageCode == 'de') {
      input = input.replaceAll('ß', 'SS');
    }
    return input.toUpperCase();
  }
}
