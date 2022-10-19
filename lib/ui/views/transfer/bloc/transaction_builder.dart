import 'dart:math';
import 'dart:typed_data';

import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

extension TransferTransactionBuilder on Transaction {
  /// Builds a Transfer transfer Transaction
  static Future<Transaction> build({
    required String message,
    required List<UCOTransfer> ucoTransferList,
    required List<TokenTransfer> tokenTransferList,
    required String serviceName,
    required Keychain keychain,
    required int index,
    required String originPrivateKey,
  }) async {
    final transaction = Transaction(
      type: 'transfer',
      data: Transaction.initData(),
    );
    for (final transfer in ucoTransferList) {
      transaction.addUCOTransfer(transfer.to, transfer.amount!);
    }
    for (final transfer in tokenTransferList) {
      transaction.addTokenTransfer(
        transfer.to,
        transfer.amount!,
        transfer.tokenAddress,
        tokenId: transfer.tokenId == null ? 0 : transfer.tokenId!,
      );
    }

    if (message.isNotEmpty) {
      final aesKey = uint8ListToHex(
        Uint8List.fromList(
          List<int>.generate(32, (int i) => Random.secure().nextInt(256)),
        ),
      );

      final walletKeyPair = keychain.deriveKeypair(serviceName);

      final authorizedPublicKeys = List<String>.empty(growable: true);
      authorizedPublicKeys.add(uint8ListToHex(walletKeyPair.publicKey));

      for (final transfer in ucoTransferList) {
        final firstTxListRecipient = await sl
            .get<ApiService>()
            .getTransactionChain(transfer.to!, request: 'previousPublicKey');
        if (firstTxListRecipient.isNotEmpty) {
          authorizedPublicKeys.add(
            firstTxListRecipient.first.previousPublicKey!,
          );
        }
      }

      for (final transfer in tokenTransferList) {
        final firstTxListRecipient = await sl
            .get<ApiService>()
            .getTransactionChain(transfer.to!, request: 'previousPublicKey');
        if (firstTxListRecipient.isNotEmpty) {
          authorizedPublicKeys.add(
            firstTxListRecipient.first.previousPublicKey!,
          );
        }
      }

      final authorizedKeys = List<AuthorizedKey>.empty(growable: true);
      for (final key in authorizedPublicKeys) {
        authorizedKeys.add(
          AuthorizedKey(
            encryptedSecretKey: uint8ListToHex(ecEncrypt(aesKey, key)),
            publicKey: key,
          ),
        );
      }

      transaction.addOwnership(
        aesEncrypt(message, aesKey),
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
