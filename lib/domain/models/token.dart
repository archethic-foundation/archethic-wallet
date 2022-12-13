/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/domain/models/token_property.dart';
import 'package:aewallet/model/keychain_service_keypair.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'token.freezed.dart';

/// Represents a token, blockchain agnostic.
@freezed
class Token with _$Token {
  const factory Token({
    required String seed,
    required KeychainServiceKeyPair keychainServiceKeyPair,
    required String accountSelectedName,
    required String name,
    required String symbol,
    required double initialSupply,
    required String type,
    required List<TokenProperty> properties,
    required List<int> aeip,
  }) = _Token;
  const Token._();
}
