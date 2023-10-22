/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/domain/models/token_property_access.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_property.freezed.dart';

/// Represents a token property, blockchain agnostic.
@freezed
class TokenProperty with _$TokenProperty {
  const factory TokenProperty({
    required String propertyName,
    required dynamic propertyValue,
    required List<TokenPropertyAccess> publicKeys,
  }) = _TokenProperty;
  const TokenProperty._();
}
