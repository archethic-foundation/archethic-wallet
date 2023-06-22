import 'dart:math';
import 'dart:typed_data';

import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/repositories/messenger_repository.dart';
import 'package:aewallet/infrastructure/datasources/talk_local_datasource.dart';
import 'package:aewallet/infrastructure/datasources/talk_remote_datasource.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/data/access_recipient.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/messenger/message.dart';
import 'package:aewallet/model/data/messenger/talk.dart';
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

  final _localDatasource = HiveTalkDatasource.getInstance();

  // late HiveVaultDatasource? __vaultDatasource;
  // Future<HiveVaultDatasource> get _vaultDatasource async =>
  //     __vaultDatasource ??= await HiveVaultDatasource.getInstance();

  final _remoteDatasource = TalkRemoteDatasource();

  @override
  Future<Result<List<String>, Failure>> getTalkAddresses({
    required Account owner,
  }) async =>
      Result.guard(() async {
        final localDatasource = await _localDatasource;

        return localDatasource.getTalkAddresses(owner.genesisAddress).toList();
      });

  String _serviceName(Account account) =>
      'archethic-wallet-${Uri.encodeFull(account.name)}';

  @override
  Future<Result<Talk, Failure>> getTalk({
    required Account owner,
    required String talkAddress,
  }) =>
      Result.guard(() async {
        final localDatasource = await _localDatasource;

        final talk = await localDatasource.getTalk(
          ownerAddress: owner.genesisAddress,
          talkAddress: talkAddress,
        );
        if (talk == null) {
          throw const Failure.serviceNotFound();
        }
        return talk;
      });

  @override
  Future<Result<Talk, Failure>> createTalk({
    required List<AccessRecipient> members,
    required List<AccessRecipient> admins,
    required Account creator,
    required LoggedInSession session,
    required String groupName,
  }) =>
      Result.guard(() async {
        final localDatasource = await _localDatasource;

        final newTalk = await _remoteDatasource.createTalk(
          keychain: session.wallet.keychainSecuredInfos.toKeychain(),
          adminAddress: creator.lastAddress!,
          admins: admins,
          apiService: sl.get<ApiService>(),
          groupName: groupName,
          serviceName: _serviceName(creator),
          members: members,
        );
        await localDatasource.addTalk(
          ownerAddress: creator.genesisAddress,
          talk: newTalk,
        );

        return newTalk;
      });

  @override
  Future<Result<List<TalkMessage>, Failure>> getMessages({
    required Account reader,
    required LoggedInSession session,
    required String talkAddress,
    int limit = 0,
    int pagingOffset = 0,
  }) async =>
      Result.guard(
        () async {
          final keyPair = session.wallet.keychainSecuredInfos
              .services[_serviceName(reader)]!.keyPair!;

          final aeMessages = await _remoteDatasource.readMessages(
            apiService: sl.get<ApiService>(),
            scAddress: talkAddress,
            readerKeyPair: keyPair.toKeyPair,
            limit: limit,
            pagingOffset: pagingOffset,
          );

          final talkMessages = aeMessages
              .map(
                (message) => TalkMessage(
                  address: message.address,
                  content: message.content,
                  senderGenesisPublicKey: message.genesisPublicKey,
                  date: DateTime.fromMillisecondsSinceEpoch(
                    message.timestamp * 1000,
                  ),
                ),
              )
              .toList();

          return talkMessages;
        },
      );

  @override
  Future<Result<double, Failure>> calculateFees({
    required LoggedInSession session,
    required String talkAddress,
    required Account creator,
    required String content,
  }) async =>
      Result.guard(
        () {
          final keyPair = session.wallet.keychainSecuredInfos
              .services[_serviceName(creator)]!.keyPair!;

          return _remoteDatasource.calculateMessageSendFees(
            apiService: sl.get<ApiService>(),
            scAddress: talkAddress,
            messageContent: content,
            keychain: session.wallet.keychainSecuredInfos.toKeychain(),
            senderAddress: creator.lastAddress!,
            senderServiceName: _serviceName(creator),
            senderKeyPair: keyPair.toKeyPair,
          );
        },
      );

  @override
  Future<Result<TalkMessage, Failure>> sendMessage({
    required LoggedInSession session,
    required String talkAddress,
    required Account creator,
    required String content,
  }) =>
      Result.guard(() async {
        final keyPair = session.wallet.keychainSecuredInfos
            .services[_serviceName(creator)]!.keyPair!;

        final sendMessageResult = await _remoteDatasource.sendMessage(
          apiService: sl.get<ApiService>(),
          scAddress: talkAddress,
          messageContent: content,
          keychain: session.wallet.keychainSecuredInfos.toKeychain(),
          senderAddress: creator.lastAddress!,
          senderServiceName: _serviceName(creator),
          senderKeyPair: keyPair.toKeyPair,
        );

        final txAddress = sendMessageResult.transactionAddress;

        final message = TalkMessage(
          address: txAddress.address!,
          content: content,
          date: DateTime.now(),
          senderGenesisPublicKey:
              uint8ListToHex(Uint8List.fromList(keyPair.publicKey))
                  .toUpperCase(),
        );

        final previousKeyPair =
            session.wallet.keychainSecuredInfos.toKeychain().deriveKeypair(
                  _serviceName(creator),
                  index: max(
                    0,
                    sendMessageResult.transactionIndex - 1,
                  ),
                );
        await sendTransactionNotification(
          notification: TransactionNotification(
            txAddress: txAddress.address!,
            txChainGenesisAddress: talkAddress,
          ),
          txIndex: sendMessageResult.transactionIndex,
          senderKeyPair: previousKeyPair,
          notifBackendBaseUrl: networksSetting.notificationBackendUrl,
        );

        return message;
      });

  @override
  Future<void> saveMessage({
    required String talkAddress,
    required Account creator,
    required TalkMessage message,
  }) async {
    await (await _localDatasource).setTalkLastMessage(
      ownerAddress: creator.genesisAddress,
      talkAddress: talkAddress,
      message: message,
    );
  }

  @override
  Future<void> clear() async {
    await (await _localDatasource).clear();
  }
}
