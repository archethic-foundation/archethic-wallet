/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/infrastructure/datasources/appdb.hive.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'account_balance.g.dart';

class AccountBalanceConverter
    implements JsonConverter<AccountBalance, Map<String, dynamic>> {
  const AccountBalanceConverter();

  @override
  AccountBalance fromJson(Map<String, dynamic> json) {
    return AccountBalance(
      nativeTokenValue: json['nativeTokenValue'] as double,
      nativeTokenName: json['nativeTokenName'] as String,
      tokensFungiblesNb: json['tokensFungiblesNb'] as int,
      nftNb: json['nftNb'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson(AccountBalance accountBalance) {
    return {
      'nativeTokenValue': accountBalance.nativeTokenValue,
      'nativeTokenName': accountBalance.nativeTokenName,
      'tokensFungiblesNb': accountBalance.tokensFungiblesNb,
      'nftNb': accountBalance.nftNb,
    };
  }
}

/// Next field available : 7
@HiveType(typeId: HiveTypeIds.accountBalance)
class AccountBalance extends HiveObject {
  AccountBalance({
    required this.nativeTokenValue,
    required this.nativeTokenName,
    this.tokensFungiblesNb = 0,
    this.nftNb = 0,
  });

  static const String cryptoCurrencyLabel = 'UCO';

  /// Native Token - Value
  @HiveField(0)
  final double nativeTokenValue;

  /// Native Token - Name
  @HiveField(1)
  final String nativeTokenName;

  /// Token Price
  @HiveField(5, defaultValue: 0)
  int tokensFungiblesNb;

  /// Token Price
  @HiveField(6, defaultValue: 0)
  int nftNb;

  String nativeTokenValueToString(String locale, {int? digits}) {
    if (nativeTokenValue > 1000000) {
      return NumberUtil.formatThousands(nativeTokenValue.round());
    } else {
      if (digits == null || nativeTokenValue == 0) {
        return NumberUtil.formatThousands(nativeTokenValue);
      }
      return nativeTokenValue.formatNumber(locale, precision: digits);
    }
  }

  bool isNativeTokenValuePositive() {
    if (nativeTokenValue > 0) {
      return true;
    } else {
      return false;
    }
  }
}
