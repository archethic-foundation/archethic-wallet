/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:freezed_annotation/freezed_annotation.dart';
part 'token_property_access.freezed.dart';

/// Represents a token property access, blockchain agnostic.
@freezed
class TokenPropertyAccess with _$TokenPropertyAccess {
  const factory TokenPropertyAccess({
    required String publicKey,
  }) = _TokenPropertyAccess;
  const TokenPropertyAccess._();
}
