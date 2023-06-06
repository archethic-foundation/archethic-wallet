/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/model/data/appdb.dart';
import 'package:hive/hive.dart';

part 'price.g.dart';

/// Next field available : 3
@HiveType(typeId: HiveTypeIds.price)
class Price extends HiveObject {
  Price({
    required this.amount,
    required this.lastLoading,
    required this.useOracleUcoPrice,
  });

  /// Amount
  @HiveField(0)
  final double amount;

  /// Last loading of the value
  @HiveField(1)
  final int lastLoading;

  /// Price from Oracle
  @HiveField(2)
  final bool useOracleUcoPrice;
}
