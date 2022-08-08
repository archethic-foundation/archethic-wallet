/// SPDX-License-Identifier: AGPL-3.0-or-later
// Package imports:

import 'package:core/model/data/token_informations_property.dart';
import 'package:hive/hive.dart';

part 'token_informations.g.dart';

@HiveType(typeId: 9)
class TokenInformations extends HiveObject {
  TokenInformations(
      {this.address,
      this.name,
      this.supply,
      this.type,
      this.symbol,
      this.tokenId,
      this.tokenInformationsProperties});

  /// Address of token
  @HiveField(0)
  String? address;

  /// Name of token
  @HiveField(1)
  String? name;

  /// Supply
  @HiveField(2)
  int? supply;

  /// Type
  @HiveField(3)
  String? type;

  /// Symbol
  @HiveField(4)
  String? symbol;

  /// Token id
  @HiveField(5)
  int? tokenId;

  /// Token Properties
  @HiveField(6)
  List<TokenInformationsProperty>? tokenInformationsProperties;
}
