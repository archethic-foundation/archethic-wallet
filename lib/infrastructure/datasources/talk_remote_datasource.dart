import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/model/data/access_recipient.dart';
import 'package:aewallet/model/data/messenger/talk.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class TalkRemoteDatasource with MessengerMixin {
  Future<Talk> createTalk({
    required ApiService apiService,
    required List<AccessRecipient> members,
    required String groupName,
    required List<AccessRecipient> admins,
    required String adminAddress,
    required String serviceName,
    required Keychain keychain,
  }) async {
    final transaction = await createNewSC(
      keychain: keychain,
      apiService: apiService,
      usersPubKey: members.map((e) => e.publicKey).whereType<String>().toList(),
      groupName: groupName,
      adminsPubKey: admins.map((e) => e.publicKey).whereType<String>().toList(),
      adminAddress: adminAddress,
      serviceName: serviceName,
    );

    return Talk(
      creationDate: DateTime.now(),
      address: transaction.address!.address!,
      name: groupName,
      members: members,
      admins: admins,
    );
  }

  Future<double> calculateMessageSendFees({
    required Keychain keychain,
    required ApiService apiService,
    required String scAddress,
    required String messageContent,
    required String senderAddress,
    required String senderServiceName,
    required KeyPair senderKeyPair,
  }) async {
    final result = await buildMessageSendTransaction(
      keychain: keychain,
      apiService: apiService,
      scAddress: scAddress,
      messageContent: messageContent,
      senderAddress: senderAddress,
      senderServiceName: senderServiceName,
      senderKeyPair: senderKeyPair,
    );

    final fee = await apiService.getTransactionFee(result.transaction);
    if (fee.fee == null) throw const Failure.invalidValue();
    return fromBigInt(fee.fee).toDouble();
  }
}
