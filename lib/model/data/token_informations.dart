/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'dart:convert';
import 'dart:typed_data';

import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:hive/hive.dart';

// Project imports:
import 'package:aewallet/model/data/token_informations_property.dart';

part 'token_informations.g.dart';

@HiveType(typeId: 9)
class TokenInformations extends HiveObject {
  TokenInformations(
      {this.address,
      this.name,
      this.id,
      this.supply,
      this.type,
      this.symbol,
      this.tokenProperties,
      this.onChain});

  /// Address of token
  @HiveField(0)
  String? address;

  /// Name of token
  @HiveField(1)
  String? name;

  /// Supply
  // @HiveField(2)
  // int? supply;

  /// Type
  @HiveField(3)
  String? type;

  /// Symbol
  @HiveField(4)
  String? symbol;

  /// Token on chain or in creation
  @HiveField(7)
  bool? onChain;

  /// Token Properties
  @HiveField(8)
  List<List<TokenInformationsProperty>>? tokenProperties;

  /// Supply
  @HiveField(9)
  double? supply;

  /// Token's Id
  @HiveField(10)
  String? id;

  TokenInformations tokenToTokenInformations(Token token) {
    address = token.address;
    name = token.name;
    id = token.id;
    supply = fromBigInt(token.supply).toDouble();
    type = token.type;
    symbol = token.symbol;
    for (List<TokenProperty> tokenPropertyList in token.tokenProperties!) {
      List<TokenInformationsProperty> tokenInformationsPropertyList =
          List<TokenInformationsProperty>.empty(growable: true);
      for (TokenProperty tokenProperty in tokenPropertyList) {
        TokenInformationsProperty tokenInformationsProperty =
            TokenInformationsProperty(
                name: tokenProperty.name, value: tokenProperty.value);
        tokenInformationsPropertyList.add(tokenInformationsProperty);
      }
      tokenProperties!.add(tokenInformationsPropertyList);
    }
    tokenProperties = tokenProperties;

    return this;
  }

  Uint8List? getImage() {
    Uint8List? imageDecoded;
    if (tokenProperties != null) {
      for (List<TokenInformationsProperty> tokenInformationsPropertyList
          in tokenProperties!) {
        for (TokenInformationsProperty tokenInformationsProperty
            in tokenInformationsPropertyList) {
          if (tokenInformationsProperty.name == 'file') {
            imageDecoded = base64Decode(tokenInformationsProperty.value!);
            return imageDecoded;
          }
        }
      }
    }
    return imageDecoded;
  }
}
