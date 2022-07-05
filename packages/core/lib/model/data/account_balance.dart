/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:hive/hive.dart';
import 'package:core/model/data/price.dart';

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
      return fiatCurrencyValue.toString();
    }
  }

  String nativeTokenValueToString() {
    if (nativeTokenValue == null) {
      return '';
    } else {
      return nativeTokenValue.toString();
    }
  }

  String tokenPriceToString() {
    if (tokenPrice == null || tokenPrice!.amount == null) {
      return '';
    } else {
      return tokenPrice!.amount.toString();
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
