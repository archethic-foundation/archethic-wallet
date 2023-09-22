import 'dart:math';
import 'dart:typed_data';

import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/repositories/messenger_repository.dart';
import 'package:aewallet/infrastructure/datasources/discussion_local_datasource.dart';
import 'package:aewallet/infrastructure/datasources/discussion_remote_datasource.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/messenger/discussion.dart';
import 'package:aewallet/model/data/messenger/message.dart';
import 'package:aewallet/util/constants.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class MessengerRepository
    with NotificationUtil
    implements MessengerRepositoryInterface {
  MessengerRepository({
    required this.networksSetting,
  });

  final NetworksSetting networksSetting;

  final _localDatasource = HiveDiscussionDatasource.getInstance();
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
          transactionIndex: newDiscussion.transactionIndex,
          pushNotification: {
            'en': const PushNotification(
              title: 'AEWallet',
              body: 'A new discussion has been created',
            ),
            'fr': const PushNotification(
              title: 'AEWallet',
              body: 'Une nouvelle discussion a été créée',
            ),
          },
          transactionType: Constants.notificationTypeNewDiscussion,
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
        );

        final localDatasource = await _localDatasource;

        await localDatasource.updateDiscussion(
          ownerAddress: owner.genesisAddress,
          discussion: updatedDiscussion.discussion,
          discussionName: discussionName,
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
          transactionIndex: sendMessageResult.transactionIndex,
          pushNotification: {
            'en': const PushNotification(
              title: 'AEWallet',
              body: 'You received a new AEMessage',
            ),
            'fr': const PushNotification(
              title: 'AEWallet',
              body: 'Vous avez reçu un nouveau AEMessage',
            ),
          },
          transactionType: Constants.notificationTypeNewMessage,
        );

        return message;
      });

  Future<void> _sendTransactionNotification({
    required LoggedInSession session,
    required String notificationRecipientAddress,
    required List<String> listenAddresses,
    required Account creator,
    required Map<String, PushNotification> pushNotification,
    required int transactionIndex,
    required String transactionType,
  }) async {
    final previousKeyPair =
        session.wallet.keychainSecuredInfos.toKeychain().deriveKeypair(
              creator.name,
              index: max(
                0,
                transactionIndex - 1,
              ),
            );

    await sendTransactionNotification(
      notification: TransactionNotification(
        notificationRecipientAddress: notificationRecipientAddress,
        listenAddresses: listenAddresses,
      ),
      pushNotification: pushNotification,
      txIndex: transactionIndex,
      senderKeyPair: previousKeyPair,
      notifBackendBaseUrl: networksSetting.notificationBackendUrl,
      transactionType: transactionType,
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
    final localDatasource = await _localDatasource;
    await localDatasource.clear();
  }
}
