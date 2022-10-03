/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'package:aewallet/util/number_util.dart';

/// Input formatter for Crypto/Fiat amounts
class CurrencyFormatter extends TextInputFormatter {
  CurrencyFormatter({
    this.commaSeparator = ',',
    this.decimalSeparator = '.',
    this.maxDecimalDigits = 2,
  });

  String commaSeparator;
  String decimalSeparator;
  int maxDecimalDigits;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var returnOriginal = true;
    if (newValue.text.contains(decimalSeparator) ||
        newValue.text.contains(commaSeparator)) {
      returnOriginal = false;
    }

    // If no text, or text doesnt contain a period of comma, no work to do here
    if (newValue.selection.baseOffset == 0 || returnOriginal) {
      return newValue;
    }

    var workingText =
        newValue.text.replaceAll(commaSeparator, decimalSeparator);
    // if contains more than 2 decimals in newValue, return oldValue
    if (decimalSeparator.allMatches(workingText).length > 1) {
      return newValue.copyWith(
        text: oldValue.text,
        selection: TextSelection.collapsed(offset: oldValue.text.length),
      );
    } else if (workingText.startsWith(decimalSeparator)) {
      workingText = '0$workingText';
    }

    final splitStr = workingText.split(decimalSeparator);
    // If this string contains more than 1 decimal, move all characters
    // to after the first decimal
    if (splitStr.length > 2) {
      returnOriginal = false;

      for (final val in splitStr) {
        if (splitStr.indexOf(val) > 1) {
          splitStr[1] += val;
        }
      }
    }
    if (splitStr[1].length <= maxDecimalDigits) {
      if (workingText == newValue.text) {
        return newValue;
      } else {
        return newValue.copyWith(
          text: workingText,
          selection: TextSelection.collapsed(offset: workingText.length),
        );
      }
    }
    final newText = splitStr[0] +
        decimalSeparator +
        splitStr[1].substring(0, maxDecimalDigits);
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class LocalCurrencyFormatter extends TextInputFormatter {
  LocalCurrencyFormatter({required this.currencyFormat, required this.active});

  NumberFormat currencyFormat;
  bool active;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.trim() == currencyFormat.currencySymbol.trim() ||
        newValue.text.isEmpty) {
      // Return empty string
      return newValue.copyWith(
        text: '',
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
    // Ensure our input is in the right formatting here
    if (active) {
      // Make local currency = symbol + amount with correct decimal separator
      final curText = newValue.text;
      var shouldBeText =
          NumberUtil.sanitizeNumber(curText.replaceAll(',', '.'));
      shouldBeText = currencyFormat.currencySymbol +
          shouldBeText.replaceAll('.', currencyFormat.symbols.DECIMAL_SEP);
      if (shouldBeText != curText) {
        return newValue.copyWith(
          text: shouldBeText,
          selection: TextSelection.collapsed(offset: shouldBeText.length),
        );
      }
    } else {
      // Make crypto amount have no symbol and formatted as US locale
      final curText = newValue.text;
      final shouldBeText =
          NumberUtil.sanitizeNumber(curText.replaceAll(',', '.'));
      if (shouldBeText != curText) {
        return newValue.copyWith(
          text: shouldBeText,
          selection: TextSelection.collapsed(offset: shouldBeText.length),
        );
      }
    }
    return newValue;
  }
}

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

/// Add blank separator between thousands
class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ' ';

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Short-circuit if the new value is empty
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    var newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    final selectionIndex =
        newValue.text.length - newValue.selection.extentOffset;
    final chars = newValueText.split('');

    var newString = '';
    for (var i = chars.length - 1; i >= 0; i--) {
      if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1) {
        newString = separator + newString;
      }
      newString = chars[i] + newString;
    }

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(
        offset: newString.length - selectionIndex,
      ),
    );
  }
}
