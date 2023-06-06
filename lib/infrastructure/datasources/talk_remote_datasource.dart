import 'package:aewallet/model/messenger/talk.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class TalkRemoteDatasource with MessengerMixin {
  Future<Talk> createTalk({
    required String endpoint,
    required List<String> usersPubKey,
    required String groupName,
    required List<String> adminsPubKey,
    required String keychainSeed,
    required String adminAddress,
    required String serviceName,
  }) async {
    final transaction = await createNewSC(
      endpoint: endpoint,
      usersPubKey: usersPubKey,
      groupName: groupName,
      adminsPubKey: adminsPubKey,
      keychainSeed: keychainSeed,
      adminAddress: adminAddress,
      serviceName: serviceName,
    );

    return Talk(
      address: transaction.address!.address!,
      name: groupName,
    );
  }
}
