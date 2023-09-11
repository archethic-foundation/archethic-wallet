/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/model/data/appdb.dart';
import 'package:hive/hive.dart';

part 'token_information.g.dart';

/// Next field available : 15
@HiveType(typeId: HiveTypeIds.tokenInformation)
class TokenInformation extends HiveObject {
  TokenInformation({
    this.address,
    this.name,
    this.id,
    this.supply,
    this.type,
    this.symbol,
    this.tokenProperties,
    this.tokenCollection,
    this.aeip,
    this.decimals,
  });

  /// Address of token
  @HiveField(0)
  String? address;

  /// Name of token
  @HiveField(1)
  String? name;

  /// Type
  @HiveField(3)
  String? type;

  /// Symbol
  @HiveField(4)
  String? symbol;

  /// Supply
  @HiveField(9)
  double? supply;

  /// Token's Id
  @HiveField(10)
  String? id;

  /// Token Properties
  @HiveField(12)
  Map<String, dynamic>? tokenProperties;

  /// AEIP
  @HiveField(13)
  List<int>? aeip;

  /// Collection
  @HiveField(14)
  List<Map<String, dynamic>>? tokenCollection;

  /// Decimals
  @HiveField(15)
  int? decimals;
}
