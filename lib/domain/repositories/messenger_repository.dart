import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/data/access_recipient.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/messenger/message.dart';
import 'package:aewallet/model/data/messenger/talk.dart';

abstract class MessengerRepositoryInterface {
  Future<Result<List<String>, Failure>> getTalkAddresses();

  Future<Result<Talk, Failure>> getTalk(String talkAddress);

  Future<Result<Talk, Failure>> createTalk({
    required List<AccessRecipient> members,
    required List<AccessRecipient> admins,
    required Account creator,
    required LoggedInSession session,
    required NetworksSetting networkSettings,
    required String groupName,
  });

  Future<Result<List<TalkMessage>, Failure>> getMessages({
    required Account reader,
    required LoggedInSession session,
    required NetworksSetting networkSettings,
    required String talkAddress,
  });

  Future<Result<TalkMessage, Failure>> sendMessage({
    required LoggedInSession session,
    required NetworksSetting networkSettings,
    required String talkAddress,
    required Account creator,
    required String content,
  });
}
