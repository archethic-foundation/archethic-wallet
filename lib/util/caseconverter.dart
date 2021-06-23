// @dart=2.9

// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';

/// Custom locale-specific uppercase/lowercase methods
class CaseChange {
  static String toUpperCase(String input, BuildContext context) {
    final Locale locale =
        Locale(StateContainer.of(context).curLanguage.getLocaleString());
    if (locale != null && locale.languageCode == 'tr') {
      input = input.replaceAll('i', 'İ');
    } else if (locale != null && locale.languageCode == 'de') {
      input = input.replaceAll('ß', 'SS');
    }
    return input.toUpperCase();
  }
}
