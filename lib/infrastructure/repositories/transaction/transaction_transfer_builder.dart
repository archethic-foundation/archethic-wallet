/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

extension TransferTransactionBuilder on archethic.Transaction {
  /// Builds a Transfer transfer Transaction
  static Future<archethic.Transaction> build({
    required String message,
    required List<archethic.UCOTransfer> ucoTransferList,
    required List<archethic.TokenTransfer> tokenTransferList,
    required String serviceName,
    required archethic.Keychain keychain,
    required archethic.KeyPair keyPair,
    required int index,
    required String originPrivateKey,
  }) async {
    final transaction = archethic.Transaction(
      type: 'transfer',
      data: archethic.Transaction.initData(),
    );
    for (final transfer in ucoTransferList) {
      transaction.addUCOTransfer(transfer.to!, transfer.amount!);
    }
    for (final transfer in tokenTransferList) {
      transaction.addTokenTransfer(
        transfer.to!,
        transfer.amount!,
        transfer.tokenAddress!,
        tokenId: transfer.tokenId == null ? 0 : transfer.tokenId!,
      );
    }

    if (message.isNotEmpty) {
      final aesKey = archethic.uint8ListToHex(
        Uint8List.fromList(
          List<int>.generate(32, (int i) => Random.secure().nextInt(256)),
        ),
      );

      final authorizedPublicKeys = List<String>.empty(growable: true)
        ..add(archethic.uint8ListToHex(keyPair.publicKey!));

      for (final transfer in ucoTransferList) {
        final firstTxListRecipientMap =
            await sl.get<archethic.ApiService>().getTransactionChain(
          {transfer.to!: ''},
          request: 'previousPublicKey',
        );
        if (firstTxListRecipientMap.isNotEmpty) {
          final firstTxListRecipient = firstTxListRecipientMap[transfer.to!];
          if (firstTxListRecipient != null && firstTxListRecipient.isNotEmpty) {
            authorizedPublicKeys.add(
              firstTxListRecipient.first.previousPublicKey!,
            );
          }
        }
      }

      for (final transfer in tokenTransferList) {
        final firstTxListRecipientMap =
            await sl.get<archethic.ApiService>().getTransactionChain(
          {transfer.to!: ''},
          request: 'previousPublicKey',
        );
        if (firstTxListRecipientMap.isNotEmpty) {
          final firstTxListRecipient = firstTxListRecipientMap[transfer.to!];
          if (firstTxListRecipient != null && firstTxListRecipient.isNotEmpty) {
            authorizedPublicKeys.add(
              firstTxListRecipient.first.previousPublicKey!,
            );
          }
        }
      }

      final authorizedKeys =
          List<archethic.AuthorizedKey>.empty(growable: true);
      for (final key in authorizedPublicKeys) {
        authorizedKeys.add(
          archethic.AuthorizedKey(
            encryptedSecretKey:
                archethic.uint8ListToHex(archethic.ecEncrypt(aesKey, key)),
            publicKey: key,
          ),
        );
      }

      transaction.addOwnership(
        archethic.uint8ListToHex(
          archethic.aesEncrypt(utf8.encode(message), aesKey),
        ),
        authorizedKeys,
      );
    }

    return keychain
        .buildTransaction(
          transaction,
          serviceName,
          index,
        )
        .originSign(originPrivateKey);
  }
}
