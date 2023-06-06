import 'package:aewallet/infrastructure/datasources/secured_datasource_mixin.dart';
import 'package:aewallet/model/messenger/talk.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveTalkDatasource with SecuredHiveMixin {
  HiveTalkDatasource._(this._talkBox);

  final LazyBox<Talk> _talkBox;

  static Future<HiveTalkDatasource> getInstance() async {
    final encryptedBox =
        await SecuredHiveMixin.openLazySecuredBox<Talk>('MessengerTalk');

    return HiveTalkDatasource._(encryptedBox);
  }

  List<String> getTalkIds() {
    return _talkBox.keys.whereType<String>().toList();
  }

  Future<void> addTalk(Talk newTalk) async {
    await _talkBox.put(newTalk.address, newTalk);
  }

  Future<Talk?> getTalk(String talkId) async {
    return _talkBox.get(talkId);
  }
}
