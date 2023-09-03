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
          discussion: newDiscussion,
        );

        return newDiscussion;
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
    required String discussionAddress,
    int limit = 0,
    int pagingOffset = 0,
  }) async =>
      Result.guard(
        () async {
          final keyPair = session
              .wallet.keychainSecuredInfos.services[reader.name]!.keyPair!;

          final aeMessages = await messagingService.readMessages(
            apiService: sl.get<ApiService>(),
            discussionSCAddress: discussionAddress,
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
    required String discussionAddress,
  }) async =>
      Result.guard(
        () async {
          final keyPair = session.wallet.keychainSecuredInfos
              .services[currentAccount.name]!.keyPair!;

          final aeGroupMessage = await messagingService.getDiscussion(
            apiService: sl.get<ApiService>(),
            discussionSCAddress: discussionAddress,
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
              aeGroupMessage.timestampLastUpdate,
            ),
          );
        },
      );

  @override
  Future<Result<double, Failure>> calculateFees({
    required LoggedInSession session,
    required String discussionAddress,
    required Account creator,
    required String content,
  }) async =>
      Result.guard(
        () {
          final keyPair = session
              .wallet.keychainSecuredInfos.services[creator.name]!.keyPair!;

          return _remoteDatasource.calculateMessageSendFees(
            messagingService: messagingService,
            apiService: sl.get<ApiService>(),
            scAddress: discussionAddress,
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
    required String discussionAddress,
    required Account creator,
    required String content,
  }) =>
      Result.guard(() async {
        final keyPair = session
            .wallet.keychainSecuredInfos.services[creator.name]!.keyPair!;
        final sendMessageResult = await messagingService.sendMessage(
          apiService: sl.get<ApiService>(),
          discussionSCAddress: discussionAddress,
          messageContent: content,
          keychain: session.wallet.keychainSecuredInfos.toKeychain(),
          senderAddress: creator.lastAddress!,
          senderServiceName: creator.name,
          senderKeyPair: keyPair.toKeyPair,
        );

        final txAddress = sendMessageResult.transactionAddress;

        final message = DiscussionMessage(
          address: txAddress.address!,
          content: content,
          date: DateTime.now(),
          senderGenesisPublicKey:
              uint8ListToHex(Uint8List.fromList(keyPair.publicKey))
                  .toUpperCase(),
        );

        final previousKeyPair =
            session.wallet.keychainSecuredInfos.toKeychain().deriveKeypair(
                  creator.name,
                  index: max(
                    0,
                    sendMessageResult.transactionIndex - 1,
                  ),
                );
        await sendTransactionNotification(
          notification: TransactionNotification(
            txAddress: txAddress.address!,
            txChainGenesisAddress: discussionAddress,
          ),
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
          txIndex: sendMessageResult.transactionIndex,
          senderKeyPair: previousKeyPair,
          notifBackendBaseUrl: networksSetting.notificationBackendUrl,
        );

        return message;
      });

  @override
  Future<void> updateDiscussionLastMessage({
    required String discussionAddress,
    required Account creator,
    required DiscussionMessage message,
  }) async {
    await (await _localDatasource).setDiscussionLastMessage(
      ownerAddress: creator.genesisAddress,
      discussionAddress: discussionAddress,
      message: message,
    );
  }

  @override
  Future<void> clear() async {
    await (await _localDatasource).clear();
  }
}
