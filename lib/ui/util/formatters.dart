/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// Input formatter that ensures text starts with @
class ContactInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var workingText = newValue.text;
    if (!workingText.startsWith('@')) {
      workingText = '@$workingText';
    }

    final splitStr = workingText.split('@');
    // If this string contains more than 1 @, remove all but the first one
    if (splitStr.length > 2) {
      workingText = '@${workingText.replaceAll('@', '')}';
    }

    // If nothing changed, return original
    if (workingText == newValue.text) {
      return newValue;
    }

    return newValue.copyWith(
      text: workingText,
      selection: TextSelection.collapsed(offset: workingText.length),
    );
  }
}

/// Input formatter that ensures only one space between words
class SingleSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    // Don't allow first character to be a space
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    } else if (oldValue.text.isEmpty && newValue.text == ' ') {
      return oldValue;
    } else if (oldValue.text.endsWith(' ') && newValue.text.endsWith('  ')) {
      return oldValue;
    }

    return newValue;
  }
}

/// Ensures input is always uppercase
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

/// Ensures input is always lowercase
class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

class AmountTextInputFormatter extends TextInputFormatter {
  AmountTextInputFormatter({
    this.thousandsSeparator = ' ',
    this.decimalSeparator = '.',
    this.precision = 2,
  });

  String thousandsSeparator;
  String decimalSeparator;
  int precision;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final value =
        newValue.text.unifyDecimalSeparator().removeIllegalNumberCharacters();

    if (!value.isValidNumber()) {
      return oldValue;
    }

    final formattedNumberBuilder = StringBuffer()
      ..write(
        value
            .integerPart(decimalSeparator)
            .splitFromRight(3, thousandsSeparator),
      );

    if (value.hasDecimalPart(decimalSeparator)) {
      formattedNumberBuilder
        ..write(decimalSeparator)
        ..write(value.decimalPart(decimalSeparator).limitLength(precision));
    }

    return newValue.copyWith(
      text: formattedNumberBuilder.toString(),
      selection: TextSelection.collapsed(offset: formattedNumberBuilder.length),
    );
  }
}

extension DoubleNumberExt on double {
  String formatNumber(
    String locale, {
    int? precision,
  }) {
    if (precision != null) {
      if (precision <= 2) {
        final f = NumberFormat(
          '#,##0.${''.padRight(precision, '0')}',
          locale,
        );
        return f.format(this);
      } else {
        final f = NumberFormat(
          '#,##0.00${''.padRight(precision - 2, '#')}',
          locale,
        );
        return f.format(this);
      }
    }
    if (this > 1) {
      final f = NumberFormat(
        '#,##0.00',
        locale,
      );
      return f.format(this);
    }
    final f = NumberFormat(
      '#,##0.00######',
      locale,
    );
    return f.format(this);
  }
}

extension _StringNumberExt on String {
  static final illegalCharacters = RegExp('[^0-9.]');
  String removeIllegalNumberCharacters() => replaceAll(illegalCharacters, '');

  String unifyDecimalSeparator() => replaceAll(',', '.');

  bool isValidNumber() => double.tryParse(this) != null;

  String integerPart(String separator) {
    final parts = split(separator);
    if (parts.isEmpty) return '';

    return parts.first;
  }

  bool hasDecimalPart(String separator) => contains(separator);

  String decimalPart(String separator) {
    final parts = split(separator);
    if (parts.length < 2) return '';

    return parts[1];
  }

  String limitLength(int maxLength) {
    return substring(0, min(length, maxLength));
  }

  String splitFromRight(int interval, String separator) {
    final leftPartLength = length % interval;
    final parts = length ~/ interval;

    final resultBuilder = StringBuffer();

    if (leftPartLength > 0) {
      resultBuilder.write(substring(0, leftPartLength));

      if (parts > 0) resultBuilder.write(separator);
    }

    for (var i = 0; i < parts; i++) {
      final offset = leftPartLength + i * interval;
      resultBuilder.write(substring(offset, offset + interval));
      if (i < parts - 1) {
        resultBuilder.write(separator);
      }
    }
    return resultBuilder.toString();
  }
}
