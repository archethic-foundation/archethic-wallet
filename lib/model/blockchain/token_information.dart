/// SPDX-License-Identifier: AGPL-3.0-or-later

// Project imports:
import 'package:aewallet/model/data/appdb.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'token_information.g.dart';

class TokenInformationConverter
    implements JsonConverter<TokenInformation, Map<String, dynamic>> {
  const TokenInformationConverter();

  @override
  TokenInformation fromJson(Map<String, dynamic> json) {
    return TokenInformation(
      address: json['address'] as String?,
      name: json['name'] as String?,
      id: json['id'] as String?,
      supply: json['supply'] as double?,
      type: json['type'] as String?,
      symbol: json['symbol'] as String?,
      tokenProperties: json['tokenProperties'] as Map<String, dynamic>?,
      tokenCollection: json['tokenCollection'] as List<Map<String, dynamic>>?,
      aeip: json['aeip'] as List<int>?,
      decimals: json['decimals'] as int?,
    );
  }

  @override
  Map<String, dynamic> toJson(TokenInformation tokenInformation) {
    return {
      'address': tokenInformation.address,
      'name': tokenInformation.name,
      'id': tokenInformation.id,
      'supply': tokenInformation.supply,
      'type': tokenInformation.type,
      'symbol': tokenInformation.symbol,
      'tokenProperties': tokenInformation.tokenProperties,
      'tokenCollection': tokenInformation.tokenCollection,
      'aeip': tokenInformation.aeip,
      'decimals': tokenInformation.decimals,
    };
  }
}

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
