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
import 'package:aewallet/util/keychain_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class MessengerRepository implements MessengerRepositoryInterface {
  final _localDatasource = HiveTalkDatasource.getInstance();

  // late HiveVaultDatasource? __vaultDatasource;
  // Future<HiveVaultDatasource> get _vaultDatasource async =>
  //     __vaultDatasource ??= await HiveVaultDatasource.getInstance();

  final _remoteDatasource = TalkRemoteDatasource();

  @override
  Future<Result<List<String>, Failure>> getTalkAddresses() async =>
      Result.guard(() async {
        final localDatasource = await _localDatasource;

        return localDatasource.getTalkIds();
      });

  String _serviceName(Account account) =>
      'archethic-wallet-${Uri.encodeFull(account.name)}';

  @override
  Future<Result<Talk, Failure>> createTalk({
    required List<AccessRecipient> members,
    required List<AccessRecipient> admins,
    required Account creator,
    required LoggedInSession session,
    required NetworksSetting networkSettings,
    required String groupName,
  }) {
    return Result.guard(() async {
      final localDatasource = await _localDatasource;

      final newTalk = await _remoteDatasource.createTalk(
        keychain: session.wallet.keychainSecuredInfos.toKeychain(),
        adminAddress: creator.lastAddress!,
        admins: admins,
        endpoint: networkSettings.getLink(),
        groupName: groupName,
        serviceName: _serviceName(creator),
        members: members,
      );
      await localDatasource.addTalk(newTalk);

      return newTalk;
    });
  }

  @override
  Future<Result<Talk, Failure>> getTalk(String talkAddress) =>
      Result.guard(() async {
        final localDatasource = await _localDatasource;

        final talk = await localDatasource.getTalk(talkAddress);
        if (talk == null) {
          throw const Failure.serviceNotFound();
        }
        return talk;
      });

  @override
  Future<Result<List<TalkMessage>, Failure>> getMessages({
    required Account reader,
    required LoggedInSession session,
    required NetworksSetting networkSettings,
    required String talkAddress,
  }) async =>
      Result.guard(
        () async {
          final keyPair = session.wallet.keychainSecuredInfos
              .services[_serviceName(reader)]!.keyPair!;

          final newTalk = await _remoteDatasource.readMessages(
            endpoint: networkSettings.getLink(),
            scAddress: talkAddress,
            readerKeyPair: keyPair.toKeyPair,
          );

          // TODO(Chralu): save locally

          return newTalk
              .map(
                (e) => TalkMessage(
                  address: e.address,
                  content: e.content,
                  senderPublicKey: e.sender,
                  date: DateTime.fromMillisecondsSinceEpoch(e.timestamp),
                ),
              )
              .toList();
        },
      );

  @override
  Future<Result<TalkMessage, Failure>> sendMessage({
    required LoggedInSession session,
    required NetworksSetting networkSettings,
    required String talkAddress,
    required Account creator,
    required String content,
  }) =>
      Result.guard(() async {
        final keyPair = session.wallet.keychainSecuredInfos
            .services[_serviceName(creator)]!.keyPair!;

        final txAddress = await _remoteDatasource.sendMessage(
          endpoint: networkSettings.getLink(),
          scAddress: talkAddress,
          messageContent: content,
          keychain: session.wallet.keychainSecuredInfos.toKeychain(),
          senderAddress: creator.lastAddress!,
          senderServiceName: _serviceName(creator),
          senderKeyPair: keyPair.toKeyPair,
        );

        return TalkMessage(
          address: txAddress.address!,
          content: content,
          date: DateTime.now(),
          senderPublicKey: uint8ListToHex(Uint8List.fromList(keyPair.publicKey))
              .toUpperCase(),
        );
      });
}
