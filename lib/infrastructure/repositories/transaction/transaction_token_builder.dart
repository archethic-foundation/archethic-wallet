/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:convert';
import 'dart:math';

import 'package:aewallet/domain/models/token_property.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/foundation.dart';

extension AddTokenTransactionBuilder on archethic.Transaction {
  /// Builds a creation of token Transaction
  static archethic.Transaction build({
    required String tokenName,
    required double tokenInitialSupply,
    required String tokenSymbol,
    required String serviceName,
    required archethic.Keychain keychain,
    required archethic.KeyPair keyPair,
    required int index,
    required String originPrivateKey,
    required String tokenType,
    required List<int> aeip,
    required List<TokenProperty> tokenProperties,
    required int txVersion,
  }) {
    final transaction = archethic.Transaction(
      type: 'token',
      version: txVersion,
      data: archethic.Transaction.initData(),
    );

    final tokenPropertiesNotProtected = <String, dynamic>{};
    for (final tokenProperty in tokenProperties) {
      if (tokenProperty.publicKeys.isEmpty) {
        tokenPropertiesNotProtected[tokenProperty.propertyName] =
            tokenProperty.propertyValue;
      } else {
        final authorizedPublicKeys = List<String>.empty(growable: true)
          ..add(archethic.uint8ListToHex(keyPair.publicKey!));

        for (final publicKey in tokenProperty.publicKeys) {
          authorizedPublicKeys.add(
            publicKey.publicKey,
          );
        }

        final aesKey = archethic.uint8ListToHex(
          Uint8List.fromList(
            List<int>.generate(32, (int i) => Random.secure().nextInt(256)),
          ),
        );

        final authorizedKeys =
            List<archethic.AuthorizedKey>.empty(growable: true);
        for (final key in authorizedPublicKeys) {
          if (key.isNotEmpty) {
            authorizedKeys.add(
              archethic.AuthorizedKey(
                encryptedSecretKey:
                    archethic.uint8ListToHex(archethic.ecEncrypt(aesKey, key)),
                publicKey: key,
              ),
            );
          }
        }

        final tokenPropertiesProtected = <String, dynamic>{};
        tokenPropertiesProtected[tokenProperty.propertyName] =
            tokenProperty.propertyValue;
        transaction.addOwnership(
          archethic.uint8ListToHex(
            archethic.aesEncrypt(
              json.encode(tokenPropertiesProtected),
              aesKey,
              isDataHexa: false,
            ),
          ),
          authorizedKeys,
        );
      }
    }

    final token = archethic.Token(
      name: tokenName,
      supply: archethic.toBigInt(tokenInitialSupply),
      type: tokenType,
      symbol: tokenSymbol,
      aeip: aeip,
      properties: tokenPropertiesNotProtected,
    );

    final content = token.tokenToJsonForTxDataContent();
    final newTransactionContent = transaction.setContent(content);
    final newTransactionAddress = newTransactionContent.setAddress(
      archethic.Address(
        address: archethic.uint8ListToHex(
          keychain.deriveAddress(
            serviceName,
            index: index + 1,
          ),
        ),
      ),
    );

    return keychain
        .buildTransaction(
          newTransactionAddress,
          serviceName,
          index,
        )
        .transaction
        .originSign(originPrivateKey);
  }
}
