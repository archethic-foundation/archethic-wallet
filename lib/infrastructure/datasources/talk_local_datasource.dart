import 'package:aewallet/infrastructure/datasources/secured_datasource_mixin.dart';
import 'package:aewallet/model/data/messenger/talk.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveTalkDatasource with SecuredHiveMixin {
  HiveTalkDatasource._(this._talkBox);

  final LazyBox<Talk> _talkBox;

  static Future<HiveTalkDatasource> getInstance() async {
    final encryptedBox =
        await SecuredHiveMixin.openLazySecuredBox<Talk>('MessengerTalk');

    return HiveTalkDatasource._(encryptedBox);
  }

  String _talkKey({
    required String ownerAddress,
    required String talkAddress,
  }) =>
      '$ownerAddress-$talkAddress';

  List<String> getTalkAddresses(String ownerAddress) {
    final ownerPrefix = '$ownerAddress-';
    return _talkBox.keys
        .whereType<String>()
        .where((element) {
          return element.startsWith(ownerPrefix);
        })
        .map(
          (e) => e.substring(ownerPrefix.length),
        )
        .toList();
  }

  Future<void> addTalk({
    required String ownerAddress,
    required Talk talk,
  }) async {
    await _talkBox.put(
      _talkKey(ownerAddress: ownerAddress, talkAddress: talk.address),
      talk,
    );
  }

  Future<Talk?> getTalk({
    required String ownerAddress,
    required String talkAddress,
  }) async =>
      _talkBox.get(
        _talkKey(
          ownerAddress: ownerAddress,
          talkAddress: talkAddress,
        ),
      );

  Future<void> clear() async {
    await _talkBox.clear();
  }
}
