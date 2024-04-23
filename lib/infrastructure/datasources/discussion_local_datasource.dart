import 'package:aewallet/infrastructure/datasources/secured_datasource_mixin.dart';
import 'package:aewallet/model/data/messenger/discussion.dart';
import 'package:aewallet/model/data/messenger/message.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDiscussionDatasource with SecuredHiveMixin {
  HiveDiscussionDatasource._(this._discussionBox);

  final LazyBox<Discussion> _discussionBox;

  static Future<HiveDiscussionDatasource> getInstance(String? password) async {
    final encryptedBox = await SecuredHiveMixin.openLazySecuredBox<Discussion>(
      'MessengerDiscussion',
      password,
    );
    return HiveDiscussionDatasource._(encryptedBox);
  }

  String _discussionKey({
    required String ownerAddress,
    required String discussionAddress,
  }) =>
      '$ownerAddress-$discussionAddress';

  Iterable<String> getDiscussionAddresses(String ownerAddress) {
    final ownerPrefix = '$ownerAddress-';
    return _discussionBox.keys.whereType<String>().where((element) {
      return element.startsWith(ownerPrefix);
    }).map(
      (e) => e.substring(ownerPrefix.length),
    );
  }

  Future<Discussion?> getDiscussion({
    required String ownerAddress,
    required String discussionAddress,
  }) async =>
      _discussionBox.get(
        _discussionKey(
          ownerAddress: ownerAddress,
          discussionAddress: discussionAddress,
        ),
      );

  Future<void> addDiscussion({
    required String ownerAddress,
    required Discussion discussion,
  }) async {
    await _discussionBox.put(
      _discussionKey(
        ownerAddress: ownerAddress,
        discussionAddress: discussion.address,
      ),
      discussion,
    );
  }

  Future updateDiscussion({
    required Discussion discussion,
    required String ownerAddress,
    required String discussionName,
  }) async {
    await _discussionBox.put(
      _discussionKey(
        ownerAddress: ownerAddress,
        discussionAddress: discussion.address,
      ),
      discussion.copyWith(
        name: discussionName,
      ),
    );
  }

  Future<void> clear() async {
    await _discussionBox.clear();
  }

  Future<void> setDiscussionLastMessage({
    required String ownerAddress,
    required String discussionAddress,
    required DiscussionMessage message,
  }) async {
    final discussionKey = _discussionKey(
      ownerAddress: ownerAddress,
      discussionAddress: discussionAddress,
    );
    final discussion = (await _discussionBox.get(discussionKey))!;

    await _discussionBox.put(
      discussionKey,
      discussion.copyWith(lastMessage: message),
    );
  }

  Future<void> removeDiscussion({
    required String ownerAddress,
    required String discussionAddress,
  }) async {
    final discussionKey = _discussionKey(
      ownerAddress: ownerAddress,
      discussionAddress: discussionAddress,
    );

    await _discussionBox.delete(
      discussionKey,
    );
  }
}
