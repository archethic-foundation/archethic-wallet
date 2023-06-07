import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/messenger/talk.dart';
import 'package:aewallet/model/public_key.dart';

abstract class MessengerRepositoryInterface {
  Future<Result<List<String>, Failure>> getTalkIds();

  Future<Result<Talk, Failure>> getTalk(String talkId);

  Future<Result<Talk, Failure>> createTalk({
    required List<PublicKey> members,
    required List<PublicKey> admins,
    required Account creator,
    required LoggedInSession session,
    required NetworksSetting networkSettings,
    required String groupName,
  });
}
