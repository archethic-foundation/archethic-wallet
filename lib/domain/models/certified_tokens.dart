/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'certified_tokens.freezed.dart';
part 'certified_tokens.g.dart';

@freezed
class CertifiedTokens with _$CertifiedTokens {
  const factory CertifiedTokens({
    required List<String> mainnet,
    required List<String> testnet,
    required List<String> devnet,
  }) = _CertifiedTokens;

  factory CertifiedTokens.fromJson(Map<String, dynamic> json) =>
      _$CertifiedTokensFromJson(json);
}
