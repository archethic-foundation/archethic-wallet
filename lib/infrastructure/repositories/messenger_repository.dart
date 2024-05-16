import 'dart:typed_data';

import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/repositories/messenger_repository.dart';
import 'package:aewallet/infrastructure/datasources/discussion.remote.dart';
import 'package:aewallet/infrastructure/datasources/discussion.vault.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/messenger/discussion.dart';
import 'package:aewallet/model/data/messenger/message.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_messaging_lib_dart/archethic_messaging_lib_dart.dart';

class MessengerRepository
    with NotificationUtil
    implements MessengerRepositoryInterface {
  MessengerRepository({
    required this.networksSetting,
  });

  final NetworksSetting networksSetting;

  Future<DiscussionVaultDatasource> get _localDatasource =>
      DiscussionVaultDatasource.getInstance();
  MessagingService? _messagingService;
  MessagingService get messagingService =>
      _messagingService ??= sl.get<MessagingService>();

  // late HiveVaultDatasource? __vaultDatasource;
  // Future<HiveVaultDatasource> get _vaultDatasource async =>
  //     __vaultDatasource ??= await HiveVaultDatasource.getInstance();

  final _remoteDatasource = DiscussionRemoteDatasource();

  @override
  Future<Result<List<String>, Failure>> getDiscussionAddresses({
    required Account owner,
  }) async =>
      Result.guard(() async {
        final localDatasource = await _localDatasource;

        return localDatasource
            .getDiscussionAddresses(owner.genesisAddress)
            .toList();
      });

  @override
  Future<Result<Discussion, Failure>> getDiscussion({
    required Account owner,
    required String discussionAddress,
  }) =>
      Result.guard(() async {
        final localDatasource = await _localDatasource;

        final discussion = await localDatasource.getDiscussion(
          ownerAddress: owner.genesisAddress,
          discussionAddress: discussionAddress,
        );
        if (discussion == null) {
          throw const Failure.serviceNotFound();
        }
        return discussion;
      });

  @override
  Future<Result<Discussion, Failure>> createDiscussion({
    required List<String> membersPubKeys,
    required List<String> adminsPubKeys,
    required Account creator,
    required LoggedInSession session,
    required String discussionName,
  }) =>
      Result.guard(() async {
        final localDatasource = await _localDatasource;

        final newDiscussion = await _remoteDatasource.createDiscussion(
          messagingService: messagingService,
          keychain: session.wallet.keychainSecuredInfos.toKeychain(),
          adminAddress: creator.lastAddress!,
          adminsPubKeys: adminsPubKeys,
          apiService: sl.get<ApiService>(),
          discussionName: discussionName,
          serviceName: creator.name,
          membersPubKey: membersPubKeys,
        );
        await localDatasource.addDiscussion(
          ownerAddress: creator.genesisAddress,
          discussion: newDiscussion.discussion,
        );

        await _sendTransactionNotification(
          notificationRecipientAddress: newDiscussion.discussion.address,
          listenAddresses: membersPubKeys,
          creator: creator,
          session: session,
          previousKeyPair: newDiscussion.previousKeyPair,
          pushNotification: {
            'en': const PushNotification(
              title: 'Archethic',
              body: 'A new discussion has been created',
            ),
            'fr': const PushNotification(
              title: 'Archethic',
              body: 'Une nouvelle discussion a été créée',
            ),
          },
          transactionType: MessengerConstants.notificationTypeNewDiscussion,
        );

        return newDiscussion.discussion;
      });

  @override
  Future<Result<Discussion, Failure>> updateDiscussion({
    required String discussionSCAddress,
    required List<String> membersPubKeys,
    required String discussionName,
    required List<String> adminsPubKeys,
    required String adminAddress,
    required String serviceName,
    required LoggedInSession session,
    required KeyPair adminKeyPair,
    required Account owner,
    bool updateSCAESKey = false,
    List<String> membersAddedToNotify = const [],
    List<String> membersDeletedToNotify = const [],
  }) async =>
      Result.guard(() async {
        final updatedDiscussion = await _remoteDatasource.updateDiscussion(
          messagingService: messagingService,
          keychain: session.wallet.keychainSecuredInfos.toKeychain(),
          apiService: sl.get<ApiService>(),
          discussionSCAddress: discussionSCAddress,
          membersPubKey: membersPubKeys,
          discussionName: discussionName,
          adminsPubKeys: adminsPubKeys,
          adminAddress: adminAddress,
          serviceName: serviceName,
          adminKeyPair: adminKeyPair,
          updateSCAESKey: updateSCAESKey,
        );

        final localDatasource = await _localDatasource;

        await localDatasource.updateDiscussion(
          ownerAddress: owner.genesisAddress,
          discussion: updatedDiscussion.discussion.copyWith(
            address:
                discussionSCAddress, // we are always saving in DB the genesis address of the discussion
          ),
          discussionName: discussionName,
        );

        var listenAddresses = membersPubKeys;
        // If there are users added or deleted, we will notify only them. Otherwise (like a name changed), we will notify everybody.
        if (membersAddedToNotify.isNotEmpty ||
            membersDeletedToNotify.isNotEmpty) {
          // https://stackoverflow.com/questions/21826342/how-do-i-combine-two-lists-in-dart with If you want to merge two lists and remove duplicates
          listenAddresses =
              {...membersAddedToNotify, ...membersDeletedToNotify}.toList();
        }

        await _sendTransactionNotification(
          notificationRecipientAddress: updatedDiscussion.discussion.address,
          listenAddresses: listenAddresses,
          creator: owner,
          session: session,
          previousKeyPair: updatedDiscussion.previousKeyPair,
          pushNotification: {
            'en': const PushNotification(
              title: 'Archethic',
              body: 'A discussion has been updated',
            ),
            'fr': const PushNotification(
              title: 'Archethic',
              body: 'Une discussion a été mise à jour',
            ),
          },
          transactionType: MessengerConstants.notificationTypeDiscussionUpdated,
          extra: {
            'membersAddedToNotify': membersAddedToNotify,
            'membersDeletedToNotify': membersDeletedToNotify,
          },
        );

        return updatedDiscussion.discussion;
      });

  @override
  Future<Result<Discussion, Failure>> addRemoteDiscussion({
    required Discussion discussion,
    required Account creator,
  }) =>
      Result.guard(() async {
        final localDatasource = await _localDatasource;

        await localDatasource.addDiscussion(
          ownerAddress: creator.genesisAddress,
          discussion: discussion,
        );

        return discussion;
      });

  @override
  Future<Result<void, Failure>> removeDiscussion({
    required Discussion discussion,
    required Account owner,
  }) =>
      Result.guard(() async {
        final localDatasource = await _localDatasource;

        await localDatasource.removeDiscussion(
          ownerAddress: owner.genesisAddress,
          discussionAddress: discussion.address,
        );
      });

  @override
  Future<Result<List<DiscussionMessage>, Failure>> getMessages({
    required Account reader,
    required LoggedInSession session,
    required String discussionGenesisAddress,
    int limit = 0,
    int pagingOffset = 0,
  }) async =>
      Result.guard(
        () async {
          final keyPair = session
              .wallet.keychainSecuredInfos.services[reader.name]!.keyPair!;

          final lastAddressForDiscussion = await sl
              .get<AddressService>()
              .lastAddressFromAddress([discussionGenesisAddress]);

          final aeMessages = await messagingService.readMessages(
            apiService: sl.get<ApiService>(),
            discussionSCAddress:
                lastAddressForDiscussion[discussionGenesisAddress]!,
            readerKeyPair: keyPair.toKeyPair,
            limit: limit,
            pagingOffset: pagingOffset,
          );

          final discussionMessages = aeMessages
              .map(
                (message) => DiscussionMessage(
                  address: message.address,
                  content: message.content,
                  senderGenesisPublicKey: message.senderGenesisPublicKey,
                  date: DateTime.fromMillisecondsSinceEpoch(
                    message.timestampCreation * 1000,
                  ),
                ),
              )
              .toList();

          return discussionMessages;
        },
      );

  @override
  Future<Result<Discussion, Failure>> getRemoteDiscussion({
    required Account currentAccount,
    required LoggedInSession session,
    required String discussionGenesisAddress,
  }) async =>
      Result.guard(
        () async {
          final keyPair = session.wallet.keychainSecuredInfos
              .services[currentAccount.name]!.keyPair!;

          final lastAddressForDiscussion = await sl
              .get<AddressService>()
              .lastAddressFromAddress([discussionGenesisAddress]);

          final aeGroupMessage = await messagingService.getDiscussion(
            apiService: sl.get<ApiService>(),
            discussionSCAddress:
                lastAddressForDiscussion[discussionGenesisAddress]!,
            keyPair: keyPair.toKeyPair,
          );

          if (aeGroupMessage == null) {
            throw const Failure.invalidValue();
          }

          return Discussion(
            address: aeGroupMessage.address,
            adminsPubKeys: aeGroupMessage.adminPublicKey,
            membersPubKeys: aeGroupMessage.usersPubKey,
            creationDate: DateTime.fromMillisecondsSinceEpoch(
              aeGroupMessage.timestampLastUpdate * 1000,
            ),
          );
        },
      );

  @override
  Future<Result<double, Failure>> calculateFees({
    required LoggedInSession session,
    required String discussionGenesisAddress,
    required Account creator,
    required String content,
  }) async =>
      Result.guard(
        () async {
          final keyPair = session
              .wallet.keychainSecuredInfos.services[creator.name]!.keyPair!;

          final lastAddressForDiscussion = await sl
              .get<AddressService>()
              .lastAddressFromAddress([discussionGenesisAddress]);

          return _remoteDatasource.calculateMessageSendFees(
            messagingService: messagingService,
            apiService: sl.get<ApiService>(),
            scAddress: lastAddressForDiscussion[discussionGenesisAddress]!,
            messageContent: content,
            keychain: session.wallet.keychainSecuredInfos.toKeychain(),
            senderAddress: creator.lastAddress!,
            senderServiceName: creator.name,
            senderKeyPair: keyPair.toKeyPair,
          );
        },
      );

  @override
  Future<Result<DiscussionMessage, Failure>> sendMessage({
    required LoggedInSession session,
    required String discussionGenesisAddress,
    required Account creator,
    required String content,
    required List<String> membersPublicKeysForNotifications,
  }) =>
      Result.guard(() async {
        final keyPair = session
            .wallet.keychainSecuredInfos.services[creator.name]!.keyPair!;

        final lastAddressForDiscussion = await sl
            .get<AddressService>()
            .lastAddressFromAddress([discussionGenesisAddress]);

        final sendMessageResult = await messagingService.sendMessage(
          apiService: sl.get<ApiService>(),
          discussionSCAddress:
              lastAddressForDiscussion[discussionGenesisAddress]!,
          messageContent: content,
          keychain: session.wallet.keychainSecuredInfos.toKeychain(),
          senderAddress: creator.lastAddress!,
          senderServiceName: creator.name,
          senderKeyPair: keyPair.toKeyPair,
        );

        final notificationRecipientAddress =
            sendMessageResult.transactionAddress;

        final message = DiscussionMessage(
          address: notificationRecipientAddress.address!,
          content: content,
          date: DateTime.now(),
          senderGenesisPublicKey:
              uint8ListToHex(Uint8List.fromList(keyPair.publicKey))
                  .toUpperCase(),
        );

        await _sendTransactionNotification(
          notificationRecipientAddress: notificationRecipientAddress.address!,
          listenAddresses: membersPublicKeysForNotifications,
          creator: creator,
          session: session,
          previousKeyPair: sendMessageResult.previousKeyPair,
          pushNotification: {
            'en': const PushNotification(
              title: 'Archethic',
              body: 'You have received a new message',
            ),
            'fr': const PushNotification(
              title: 'Archethic',
              body: 'Vous avez reçu un nouveau message',
            ),
          },
          transactionType: MessengerConstants.notificationTypeNewMessage,
        );

        return message;
      });

  Future<void> _sendTransactionNotification({
    required LoggedInSession session,
    required String notificationRecipientAddress,
    required List<String> listenAddresses,
    required Account creator,
    required Map<String, PushNotification> pushNotification,
    required KeyPair previousKeyPair,
    required String transactionType,
    dynamic extra,
  }) async {
    await sendTransactionNotification(
      notification: TransactionNotification(
        notificationRecipientAddress: notificationRecipientAddress,
        listenAddresses: listenAddresses,
      ),
      pushNotification: pushNotification,
      senderKeyPair: previousKeyPair,
      notifBackendBaseUrl: networksSetting.notificationBackendUrl,
      transactionType: transactionType,
      extra: extra,
    );
  }

  @override
  Future<void> updateDiscussionLastMessage({
    required String discussionAddress,
    required Account creator,
    required DiscussionMessage message,
  }) async {
    final localDatasource = await _localDatasource;
    await localDatasource.setDiscussionLastMessage(
      ownerAddress: creator.genesisAddress,
      discussionAddress: discussionAddress,
      message: message,
    );
  }

  @override
  Future<void> clear() async {
    await DiscussionVaultDatasource.clear();
  }
}
