import 'dart:convert';
import 'dart:typed_data';

import 'package:aewallet/modules/messaging_sdk/model/messaging/ae_message.dart';
import 'package:aewallet/modules/messaging_sdk/model/messaging/transaction_content_messaging.dart';
import 'package:aewallet/modules/messaging_sdk/utils/messenger/discussion_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archive/archive_io.dart';

/// For group discussions, a dedicated transaction chain will contain a smart contract and its updates, as well as the discussion's rules and description.
/// The messages will be contained in the inputs of the smart contracts in the chain.
/// A general public key for accessing messages is made available.
mixin MessagesMixin {
  Future<({Transaction transaction, KeyPair previousKeyPair})>
      buildMessageSendTransaction({
    required Keychain keychain,
    required ApiService apiService,
    required String discussionSCAddress,
    required String messageContent,
    required String senderAddress,
    required String senderServiceName,
    required KeyPair senderKeyPair,
  }) async {
    final message = '''
      {
        "compressionAlgo": "gzip",
        "message": "${await _encodeMessage(message: messageContent, apiService: apiService, discussionSCAddress: discussionSCAddress, senderKeyPair: senderKeyPair)}"
      }
    ''';

    final tx = Transaction(
      type: 'transfer',
      version: 3, // Old SC
      data: Transaction.initData(),
    ).setContent(message).addRecipient(discussionSCAddress);

    final indexMap = await apiService.getTransactionIndex(
      [senderAddress],
    );

    final index = indexMap[senderAddress] ?? 0;
    final originPrivateKey = apiService.getOriginKey();

    final buildTxResult =
        keychain.buildTransaction(tx, senderServiceName, index);

    return (
      transaction: buildTxResult.transaction.originSign(originPrivateKey),
      previousKeyPair: buildTxResult.keyPair,
    );
  }

  Future<({Address transactionAddress, KeyPair previousKeyPair})> send({
    required Keychain keychain,
    required ApiService apiService,
    required String discussionSCAddress,
    required String messageContent,
    required String senderAddress,
    required String senderServiceName,
    required KeyPair senderKeyPair,
  }) async {
    final result = await buildMessageSendTransaction(
      keychain: keychain,
      apiService: apiService,
      discussionSCAddress: discussionSCAddress,
      messageContent: messageContent,
      senderAddress: senderAddress,
      senderServiceName: senderServiceName,
      senderKeyPair: senderKeyPair,
    );

    final transaction = result.transaction;
    await TransactionUtil().sendTransactions(
      [transaction],
      apiService,
    );
    return (
      transactionAddress: transaction.address!,
      previousKeyPair: result.previousKeyPair,
    );
  }

  /// This method encrypt a message with the AES Key ()
  Future<String> _encodeMessage({
    required String message,
    required ApiService apiService,
    required String discussionSCAddress,
    required KeyPair senderKeyPair,
  }) async {
    final discussionKeyAccess = await DiscussionUtil().getDiscussionKeyAccess(
      apiService: apiService,
      discussionSCAddress: discussionSCAddress,
      keyPair: senderKeyPair,
    );

    // Encode message with message key
    final stringPayload = utf8.encode(message);
    final compressedPayload = const GZipEncoder().encode(stringPayload);
    final cryptedPayload = aesEncrypt(compressedPayload, discussionKeyAccess);
    return base64.encode(cryptedPayload);
  }

  Uint8List _decodeMessage(
    String compressedData,
    String discussionKeyAccess, {
    String compressionAlgo = '',
  }) {
    final payload = base64.decode(compressedData);
    final decryptedPayload = aesDecrypt(
      payload,
      discussionKeyAccess,
    );
    late List<int> decompressedPayload;
    switch (compressionAlgo) {
      case 'gzip':
        decompressedPayload = const GZipDecoder().decodeBytes(decryptedPayload);
        break;
      default:
        decompressedPayload = decryptedPayload;
    }

    return Uint8List.fromList(decompressedPayload);
  }

  Future<List<AEMessage>> read({
    required ApiService apiService,
    required String discussionSCAddress,
    required KeyPair readerKeyPair,
    int limit = 0,
    int pagingOffset = 0,
  }) async {
    final messagesList = await apiService.getTransactionInputs(
      [discussionSCAddress],
      limit: limit,
      pagingOffset: pagingOffset,
    );
    final txContentMessagesList =
        messagesList[discussionSCAddress] ?? <TransactionInput>[];
    final txContentMessagesAddresses = txContentMessagesList
        .where(
          (txContentMessage) =>
              txContentMessage.from != null && txContentMessage.type == 'call',
        )
        .map((txContentMessage) => txContentMessage.from)
        .whereType<String>()
        .toList();

    final aeMessages = <AEMessage>[];
    final contents = await apiService.getTransaction(
      txContentMessagesAddresses,
      request:
          ' address, chainLength, data { content }, previousPublicKey, validationStamp { timestamp } ',
    );

    if (contents.isEmpty) return [];

    final discussionKeyAccess = uint8ListToHex(
      await DiscussionUtil().getDiscussionKeyAccess(
        apiService: apiService,
        discussionSCAddress: discussionSCAddress,
        keyPair: readerKeyPair,
      ),
    );

    for (final contentMessageAddress in txContentMessagesAddresses) {
      final contentMessageTransaction = contents[contentMessageAddress];
      if (contentMessageTransaction == null) continue;

      final transactionContentIM = TransactionContentMessaging.fromJson(
        jsonDecode(contentMessageTransaction.data!.content!),
      );
      final message = utf8.decode(
        _decodeMessage(
          transactionContentIM.message,
          discussionKeyAccess,
          compressionAlgo: transactionContentIM.compressionAlgo,
        ),
      );

      final senderGenesisPublicKeyMap = await apiService.getTransactionChain(
        {contentMessageTransaction.address!.address!: ''},
        request: 'previousPublicKey',
      );
      var senderGenesisPublicKey = '';
      if (senderGenesisPublicKeyMap.isNotEmpty &&
          senderGenesisPublicKeyMap[
                  contentMessageTransaction.address!.address!] !=
              null &&
          senderGenesisPublicKeyMap[
                  contentMessageTransaction.address!.address!]!
              .isNotEmpty) {
        senderGenesisPublicKey = senderGenesisPublicKeyMap[
                    contentMessageTransaction.address!.address!]?[0]
                .previousPublicKey ??
            '';
      }

      final aeMEssage = AEMessage(
        senderGenesisPublicKey: senderGenesisPublicKey,
        address: contentMessageTransaction.address!.address!,
        sender: contentMessageTransaction.previousPublicKey!,
        timestampCreation:
            contentMessageTransaction.validationStamp!.timestamp!,
        content: message,
      );

      aeMessages.add(
        aeMEssage,
      );
    }

    return aeMessages;
  }
}

class DiscussionUtil with DiscussionMixin {}
