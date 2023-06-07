import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/repositories/messenger_repository.dart';
import 'package:aewallet/infrastructure/datasources/talk_local_datasource.dart';
import 'package:aewallet/infrastructure/datasources/talk_remote_datasource.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/messenger/talk.dart';
import 'package:aewallet/model/public_key.dart';

class MessengerRepository implements MessengerRepositoryInterface {
  final _localDatasource = HiveTalkDatasource.getInstance();

  // late HiveVaultDatasource? __vaultDatasource;
  // Future<HiveVaultDatasource> get _vaultDatasource async =>
  //     __vaultDatasource ??= await HiveVaultDatasource.getInstance();

  final _remoteDatasource = TalkRemoteDatasource();

  @override
  Future<Result<List<String>, Failure>> getTalkIds() async =>
      Result.guard(() async {
        final localDatasource = await _localDatasource;

        return localDatasource.getTalkIds();
      });

  @override
  Future<Result<Talk, Failure>> createTalk({
    required List<PublicKey> members,
    required List<PublicKey> admins,
    required Account creator,
    required LoggedInSession session,
    required NetworksSetting networkSettings,
    required String groupName,
  }) {
    return Result.guard(() async {
      final localDatasource = await _localDatasource;

      // final seed = uint8ListToHex(
      //     Uint8List.fromList(session.wallet.keychainSecuredInfos.seed),
      //   );
      final seed = session.wallet.seed;
      final newTalk = await _remoteDatasource.createTalk(
        adminAddress: creator.lastAddress!,
        adminsPubKey: admins.map((e) => e.publicKey).toList(),
        endpoint: networkSettings.getLink(),
        groupName: groupName,
        keychainSeed: seed,
        serviceName: 'archethic-wallet-${Uri.encodeFull(creator.name)}',
        usersPubKey: members.map((e) => e.publicKey).toList(),
      );
      await localDatasource.addTalk(newTalk);

      return newTalk;
    });
  }

  @override
  Future<Result<Talk, Failure>> getTalk(String talkId) =>
      Result.guard(() async {
        final localDatasource = await _localDatasource;

        final talk = await localDatasource.getTalk(talkId);
        if (talk == null) {
          throw const Failure.serviceNotFound();
        }
        return talk;
      });
}
