/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:aewallet/model/data/price.dart';
import 'package:aewallet/util/number_util.dart';

part 'account_balance.g.dart';

@HiveType(typeId: 5)
class AccountBalance extends HiveObject {
  AccountBalance(
      {this.nativeTokenValue,
      this.nativeTokenName,
      this.fiatCurrencyValue,
      this.fiatCurrencyCode,
      this.tokenPrice});

  /// Native Token - Value
  @HiveField(0)
  double? nativeTokenValue;

  /// Native Token - Name
  @HiveField(1)
  String? nativeTokenName;

  /// Fiat Currency - Value
  @HiveField(2)
  double? fiatCurrencyValue;

  /// Fiat Currency - Code
  @HiveField(3)
  String? fiatCurrencyCode;

  /// Token Price
  @HiveField(4)
  Price? tokenPrice;

  String fiatCurrencyValueToString() {
    if (fiatCurrencyValue == null) {
      return '';
    } else {
      return NumberUtil.formatThousands(fiatCurrencyValue!);
    }
  }

  String nativeTokenValueToString() {
    if (nativeTokenValue == null) {
      return '';
    } else {
      if (nativeTokenValue! > 1000000) {
        return NumberUtil.formatThousands(nativeTokenValue!.round());
      } else {
        return NumberUtil.formatThousands(nativeTokenValue!);
      }
    }
  }

  String tokenPriceToString() {
    if (tokenPrice == null || tokenPrice!.amount == null) {
      return '';
    } else {
      return NumberUtil.formatThousands(tokenPrice!.amount!);
    }
  }

  bool isNativeTokenValuePositive() {
    if (nativeTokenValue != null && nativeTokenValue! > 0) {
      return true;
    } else {
      return false;
    }
  }
}
