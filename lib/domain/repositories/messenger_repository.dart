import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/messenger/discussion.dart';
import 'package:aewallet/model/data/messenger/message.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

abstract class MessengerRepositoryInterface {
  Future<Result<List<String>, Failure>> getDiscussionAddresses({
    required Account owner,
  });

  Future<Result<Discussion, Failure>> getDiscussion({
    required Account owner,
    required String discussionAddress,
  });

  Future<Result<Discussion, Failure>> createDiscussion({
    required List<String> membersPubKeys,
    required List<String> adminsPubKeys,
    required Account creator,
    required LoggedInSession session,
    required String discussionName,
  });

  Future<Result<List<DiscussionMessage>, Failure>> getMessages({
    required Account reader,
    required LoggedInSession session,
    required String discussionGenesisAddress,
    int limit = 0,
    int pagingOffset = 0,
  });

  Future<Result<Discussion, Failure>> getRemoteDiscussion({
    required Account currentAccount,
    required LoggedInSession session,
    required String discussionGenesisAddress,
  });

  Future<Result<Discussion, Failure>> addRemoteDiscussion({
    required Discussion discussion,
    required Account creator,
  });

  Future<Result<void, Failure>> removeDiscussion({
    required Discussion discussion,
    required Account owner,
  });

  Future<Result<DiscussionMessage, Failure>> sendMessage({
    required LoggedInSession session,
    required String discussionGenesisAddress,
    required Account creator,
    required String content,
    required List<String> membersPublicKeysForNotifications,
  });

  Future<void> updateDiscussionLastMessage({
    required String discussionAddress,
    required Account creator,
    required DiscussionMessage message,
  });

  Future<Result<double, Failure>> calculateFees({
    required LoggedInSession session,
    required String discussionGenesisAddress,
    required Account creator,
    required String content,
  });

  Future<void> clear();

  Future<Result<Discussion, Failure>> updateDiscussion({
    required String discussionSCAddress,
    required List<String> membersPubKeys,
    required String discussionName,
    required List<String> adminsPubKeys,
    required String adminAddress,
    required String serviceName,
    required LoggedInSession session,
    required KeyPair adminKeyPair,
    required Account owner,
  });
}
