/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'token.freezed.dart';
part 'token.g.dart';

const kTokenFordiddenName = ['UCO', 'MUCO'];

/// Represents a token, blockchain agnostic.
@freezed
class TokenDTO with _$TokenDTO {
  const factory TokenDTO({
    // required String transactionLastAddress,
    // required String accountSelectedName,
    required String name,
    required String symbol,
    required double initialSupply,
    required String type,
    // required List<TokenProperty> properties,
    // required List<int> aeip,
  }) = _TokenDTO;
  const TokenDTO._();

  factory TokenDTO.fromJson(Map<String, dynamic> json) =>
      _$TokenDTOFromJson(json);
}
