import 'package:aewallet/model/data/access_recipient.dart';
import 'package:aewallet/model/data/messenger/talk.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class TalkRemoteDatasource with MessengerMixin {
  Future<Talk> createTalk({
    required String endpoint,
    required List<AccessRecipient> members,
    required String groupName,
    required List<AccessRecipient> admins,
    required String keychainSeed,
    required String adminAddress,
    required String serviceName,
  }) async {
    final transaction = await createNewSC(
      endpoint: endpoint,
      usersPubKey: members
          .map((e) => e.publicKey?.publicKey)
          .whereType<String>()
          .toList(),
      groupName: groupName,
      adminsPubKey: admins
          .map((e) => e.publicKey?.publicKey)
          .whereType<String>()
          .toList(),
      keychainSeed: keychainSeed,
      adminAddress: adminAddress,
      serviceName: serviceName,
    );

    return Talk(
      address: transaction.address!.address!,
      name: groupName,
      members: members,
      admins: admins,
    );
  }
}
