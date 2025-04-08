import 'package:aewallet/modules/messaging_sdk/model/messaging/ae_discussion.dart';
import 'package:aewallet/modules/messaging_sdk/model/messaging/ae_message.dart';
import 'package:aewallet/modules/messaging_sdk/utils/messenger/discussion_util.dart';
import 'package:aewallet/modules/messaging_sdk/utils/messenger/messages_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

class MessagingService with DiscussionMixin, MessagesMixin {
  MessagingService({
    this.logsActivation = true,
  });

  /// [logsActivation] manage log activation
  final bool logsActivation;

  /// Create a new discussion
  /// @param{Keychain} keychain used to send transaction to BC
  /// @param{ApiService} API with blockchain
  /// @param{List<String>} List of ALL members of the discussion (public key)
  /// @param{String} name of the discussion
  /// @param{List<String>} List of ALL admins of the discussion (public key)
  /// @param{String} Address of the admin who want to add members (this address will provision the SC's chain to manage fees)
  /// @param{String} Service name in the current keychain (= admin)
  Future<
      ({
        archethic.Transaction transaction,
        archethic.KeyPair previousKeyPair
      })> createDiscussion({
    required archethic.Keychain keychain,
    required archethic.ApiService apiService,
    required List<String> membersPubKey,
    required String discussionName,
    required List<String> adminsPubKey,
    required String adminAddress,
    required String serviceName,
  }) async {
    return createTransactionSC(
      keychain: keychain,
      apiService: apiService,
      membersPubKey: membersPubKey,
      discussionName: discussionName,
      adminsPubKey: adminsPubKey,
      adminAddress: adminAddress,
      serviceName: serviceName,
    );
  }

  /// Update an existing discussion
  /// @param{Keychain} keychain used to send transaction to BC
  /// @param{ApiService} API with blockchain
  /// @param{String} Smart contract's address
  /// @param{List<String>} List of ALL members of the discussion (public key)
  /// @param{String} name of the discussion
  /// @param{List<String>} List of ALL admins of the discussion (public key)
  /// @param{String} Address of the admin who want to add members (this address will provision the SC's chain to manage fees)
  /// @param{String} Service name in the current keychain (= admin)
  /// @param{String} Update or not the AES Key, members that are deleted won't be able to read the new messages anymore
  Future<
      ({
        archethic.Transaction transaction,
        archethic.KeyPair previousKeyPair
      })> updateDiscussion({
    required archethic.Keychain keychain,
    required archethic.ApiService apiService,
    required String discussionSCAddress,
    required List<String> membersPubKey,
    required String discussionName,
    required List<String> adminsPubKey,
    required String adminAddress,
    required String serviceName,
    required archethic.KeyPair adminKeyPair,
    bool updateSCAESKey = false,
  }) async {
    return updateTransactionSC(
      keychain: keychain,
      apiService: apiService,
      discussionSCAddress: discussionSCAddress,
      discussionName: discussionName,
      adminsPubKey: adminsPubKey,
      membersPubKey: membersPubKey,
      adminAddress: adminAddress,
      serviceName: serviceName,
      adminKeyPair: adminKeyPair,
      updateSCAESKey: updateSCAESKey,
    );
  }

  /// Read messages in existing discussion
  /// @param{ApiService} API with blockchain
  /// @param{String} Smart contract's address
  /// @param{KeyPair} Keypair of the reader
  /// @param{limit}
  /// @param{pagingOffset}
  Future<List<AEMessage>> readMessages({
    required archethic.ApiService apiService,
    required String discussionSCAddress,
    required archethic.KeyPair readerKeyPair,
    int limit = 0,
    int pagingOffset = 0,
  }) async {
    return read(
      apiService: apiService,
      discussionSCAddress: discussionSCAddress,
      readerKeyPair: readerKeyPair,
      limit: limit,
      pagingOffset: pagingOffset,
    );
  }

  /// Send messages in existing discussion
  /// @param{Keychain} keychain used to send transaction to BC
  /// @param{ApiService} API with blockchain
  /// @param{String} Smart contract's address
  /// @param{String} Content of the message (no encrypt)
  /// @param{String} Address of the member who want to send message
  /// @param{String} Service name in the current keychain (= sender)
  /// @param{KeyPair} Keypair of the sender
  Future<
      ({
        archethic.Address transactionAddress,
        archethic.KeyPair previousKeyPair
      })> sendMessage({
    required archethic.Keychain keychain,
    required archethic.ApiService apiService,
    required String discussionSCAddress,
    required String messageContent,
    required String senderAddress,
    required String senderServiceName,
    required archethic.KeyPair senderKeyPair,
  }) async {
    return send(
      keychain: keychain,
      apiService: apiService,
      discussionSCAddress: discussionSCAddress,
      messageContent: messageContent,
      senderAddress: senderAddress,
      senderServiceName: senderServiceName,
      senderKeyPair: senderKeyPair,
    );
  }

  /// Get a discussion from an address
  /// @param{ApiService} API with blockchain
  /// @param{String} Smart contract's address
  /// @param{KeyPair} Keypair of the requester to check if discussion's content can be decrypted
  Future<AEDiscussion?> getDiscussion({
    required archethic.ApiService apiService,
    required String discussionSCAddress,
    required archethic.KeyPair keyPair,
  }) async {
    return getDiscussionFromSCAddress(
      apiService: apiService,
      discussionSCAddress: discussionSCAddress,
      keyPair: keyPair,
    );
  }

  /// Build a message
  /// @param{Keychain} keychain used to send transaction to BC
  /// @param{ApiService} API with blockchain
  /// @param{String} Smart contract's address
  /// @param{String} Content of the message (no encrypt)
  /// @param{String} Address of the member who want to send message
  /// @param{String} Service name in the current keychain (= sender)
  /// @param{KeyPair} Keypair of the sender
  Future<
      ({
        archethic.Transaction transaction,
        archethic.KeyPair previousKeyPair
      })> buildMessage({
    required archethic.Keychain keychain,
    required archethic.ApiService apiService,
    required String discussionSCAddress,
    required String messageContent,
    required String senderAddress,
    required String senderServiceName,
    required archethic.KeyPair senderKeyPair,
  }) async {
    return buildMessageSendTransaction(
      keychain: keychain,
      apiService: apiService,
      discussionSCAddress: discussionSCAddress,
      messageContent: messageContent,
      senderAddress: senderAddress,
      senderServiceName: senderServiceName,
      senderKeyPair: senderKeyPair,
    );
  }

  /// Get the last properties of a discussion
  /// @param{ApiService} API with blockchain
  /// @param{String} Smart contract's address
  /// @param{KeyPair} Keypair of the requester to check if discussion's properties can be decrypted
  Future<String> getDiscussionLastProperties({
    required archethic.ApiService apiService,
    required String discussionSCAddress,
    required archethic.KeyPair readerKeyPair,
  }) async {
    return getSCDiscussionLastContent(
      apiService: apiService,
      discussionSCAddress: discussionSCAddress,
      readerKeyPair: readerKeyPair,
    );
  }
}
