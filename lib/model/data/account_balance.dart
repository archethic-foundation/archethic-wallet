/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/util/number_util.dart';
import 'package:hive/hive.dart';

part 'account_balance.g.dart';

/// Next field available : 7
@HiveType(typeId: 5)
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

  String nativeTokenValueToString() {
    if (nativeTokenValue > 1000000) {
      return NumberUtil.formatThousands(nativeTokenValue.round());
    } else {
      return NumberUtil.formatThousands(nativeTokenValue);
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
