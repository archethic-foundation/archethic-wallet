import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/messenger/message.dart';
import 'package:aewallet/model/data/messenger/talk.dart';

abstract class MessengerRepositoryInterface {
  Future<Result<List<String>, Failure>> getTalkAddresses({
    required Account owner,
  });

  Future<Result<Talk, Failure>> getTalk({
    required Account owner,
    required String talkAddress,
  });

  Future<Result<Talk, Failure>> createTalk({
    required List<String> membersPubKeys,
    required List<String> adminsPubKeys,
    required Account creator,
    required LoggedInSession session,
    required String groupName,
  });

  Future<Result<List<TalkMessage>, Failure>> getMessages({
    required Account reader,
    required LoggedInSession session,
    required String talkAddress,
    int limit = 0,
    int pagingOffset = 0,
  });

  Future<Result<Talk, Failure>> getRemoteTalk({
    required Account currentAccount,
    required LoggedInSession session,
    required String talkAddress,
  });

  Future<Result<Talk, Failure>> addRemoteTalk({
    required Talk talk,
    required Account creator,
  });

  Future<Result<void, Failure>> removeTalk({
    required Talk talk,
    required Account owner,
  });

  Future<Result<TalkMessage, Failure>> sendMessage({
    required LoggedInSession session,
    required String talkAddress,
    required Account creator,
    required String content,
  });

  Future<void> saveMessage({
    required String talkAddress,
    required Account creator,
    required TalkMessage message,
  });

  Future<Result<double, Failure>> calculateFees({
    required LoggedInSession session,
    required String talkAddress,
    required Account creator,
    required String content,
  });

  Future<void> clear();
}
