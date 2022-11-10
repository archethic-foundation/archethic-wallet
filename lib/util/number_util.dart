/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

// ignore: avoid_classes_with_only_static_members
class NumberUtil {
  /// Convert raw to ban and return as BigDecimal
  ///
  /// @param raw 100000000000000000000000000000
  /// @return Decimal value 1.000000000000000000000000000000
  ///
  static Decimal getRawAsUsableDecimal(String raw) {
    final amount = Decimal.parse(raw);
    return amount;
  }

  /// Return raw as a normal amount.
  ///
  /// @param raw 100000000000000000000000000000
  /// @returns 1
  ///
  static String getRawAsUsableString(String raw) {
    final nf =
        NumberFormat.currency(locale: 'en_US', decimalDigits: 6, symbol: '');
    var asString = nf.format(
      double.tryParse(getRawAsUsableDecimal(raw).truncate().toString()),
    );
    final split = asString.split('.');
    if (split.length > 1) {
      // Remove trailing 0s from this
      if (int.parse(split[1]) == 0) {
        asString = split[0];
      } else {
        var newStr = '${split[0]}.';
        var digits = split[1];
        var endIndex = digits.length;
        for (var i = 1; i <= digits.length; i++) {
          if (int.parse(digits[digits.length - i]) == 0) {
            endIndex--;
          } else {
            break;
          }
        }
        digits = digits.substring(0, endIndex);
        newStr = '${split[0]}.$digits';
        asString = newStr;
      }
    }
    return asString;
  }

  /// Sanitize a number as something that can actually
  /// be parsed. Expects "." to be decimal separator
  /// @param amount $1,512
  /// @returns 1.512
  static String sanitizeNumber(String input, {int maxDecimalDigits = 8}) {
    var sanitized = '';
    var inputSplitted = input;
    final splitStr = inputSplitted.split('.');
    if (splitStr.length > 1) {
      if (splitStr[1].length > maxDecimalDigits) {
        splitStr[1] = splitStr[1].substring(0, maxDecimalDigits);
        inputSplitted = '${splitStr[0]}.${splitStr[1]}';
      }
    }
    for (var i = 0; i < inputSplitted.length; i++) {
      try {
        if (inputSplitted[i] == '.') {
          sanitized = sanitized + inputSplitted[i];
        } else {
          int.parse(inputSplitted[i]);
          sanitized = sanitized + inputSplitted[i];
        }
      } catch (e) {
        return sanitized;
      }
    }
    return sanitized;
  }

  /// Format a number with blank separator for each thousand
  static String formatThousands(
    num input, {
    bool round = false,
    int minAmountToRound = 1000000,
  }) {
    if (round == true && input > minAmountToRound) {
      input.round();
    }

    NumberFormat formatterThousand;
    if (input is double) {
      formatterThousand = NumberFormat('#,##0.000000000', 'en_US');
    } else {
      formatterThousand = NumberFormat('#,##0', 'en_US');
    }
    formatterThousand.maximumFractionDigits = 8;
    formatterThousand.minimumFractionDigits = 0;
    return formatterThousand.format(input).replaceAll(',', ' ');
  }
}
