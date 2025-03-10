/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/infrastructure/datasources/appdb.hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'account_balance.freezed.dart';
part 'account_balance.g.dart';

class AccountBalanceConverter
    implements JsonConverter<AccountBalance, Map<String, dynamic>> {
  const AccountBalanceConverter();

  @override
  AccountBalance fromJson(Map<String, dynamic> json) {
    return AccountBalance(
      tokensFungiblesNb: json['tokensFungiblesNb'] as int,
      nftNb: json['nftNb'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson(AccountBalance accountBalance) {
    return {
      'tokensFungiblesNb': accountBalance.tokensFungiblesNb,
      'nftNb': accountBalance.nftNb,
    };
  }
}

/// Next field available : 8
@freezed
class AccountBalance with _$AccountBalance {
  @HiveType(typeId: HiveTypeIds.accountBalance)
  factory AccountBalance({
    // @HiveField(0) required double nativeTokenValue,
    // @HiveField(1) required String nativeTokenName,
    @HiveField(5, defaultValue: 0) @Default(0) int tokensFungiblesNb,
    @HiveField(6, defaultValue: 0) @Default(0) int nftNb,
    @HiveField(7, defaultValue: 0) @Default(0) double totalUSD,
  }) = _AccountBalance;

  factory AccountBalance.fromJson(Map<String, dynamic> json) =>
      _$AccountBalanceFromJson(json);

  static const String cryptoCurrencyLabel = 'UCO';
}
