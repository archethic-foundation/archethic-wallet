/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:freezed_annotation/freezed_annotation.dart';

part 'verified_tokens.freezed.dart';
part 'verified_tokens.g.dart';

@freezed
class VerifiedTokens with _$VerifiedTokens {
  const factory VerifiedTokens({
    required List<String> devnet,
  }) = _VerifiedTokens;

  factory VerifiedTokens.fromJson(Map<String, dynamic> json) =>
      _$VerifiedTokensFromJson(json);
}
