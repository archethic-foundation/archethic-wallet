// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/appstate_container.dart';

// ignore: avoid_classes_with_only_static_members
/// Custom locale-specific uppercase/lowercase methods
class CaseChange {
  static String toUpperCase(String input, BuildContext context) {
    final Locale locale =
        Locale(StateContainer.of(context).curLanguage.getLocaleString());
    if (locale.languageCode == 'tr') {
      input = input.replaceAll('i', 'İ');
    } else if (locale.languageCode == 'de') {
      input = input.replaceAll('ß', 'SS');
    }
    return input.toUpperCase();
  }
}
