import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/model/data/messenger/discussion.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class DiscussionRemoteDatasource with MessengerMixin {
  Future<Discussion> createDiscussion({
    required ApiService apiService,
    required MessagingService messagingService,
    required List<String> membersPubKey,
    required String discussionName,
    required List<String> admins,
    required String adminAddress,
    required String serviceName,
    required Keychain keychain,
  }) async {
    final transaction = await messagingService.createDiscussion(
      keychain: keychain,
      apiService: apiService,
      membersPubKey: membersPubKey.map((e) => e).whereType<String>().toList(),
      discussionName: discussionName,
      adminsPubKey: admins.map((e) => e).whereType<String>().toList(),
      adminAddress: adminAddress,
      serviceName: serviceName,
    );

    return Discussion(
      creationDate: DateTime.now(),
      address: transaction.address!.address!,
      name: discussionName,
      membersPubKeys: membersPubKey,
      adminsPubKeys: admins,
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
