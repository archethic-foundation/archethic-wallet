import 'package:aewallet/infrastructure/datasources/secured_datasource_mixin.dart';
import 'package:aewallet/model/data/notification_setup_dto.dart';
import 'package:hive/hive.dart';

class HiveNotificationLocalDatasource with SecuredHiveMixin {
  HiveNotificationLocalDatasource._(this._notificationsSetupBox);

  static const _key = 'singleton';

  final LazyBox<NotificationsSetup> _notificationsSetupBox;

  Future<NotificationsSetup> _getSetup() async =>
      (await _notificationsSetupBox.get(_key)) ??
      const NotificationsSetup(
        listenedTxChains: [],
      );

  Future<void> _setSetup(NotificationsSetup setup) =>
      _notificationsSetupBox.put(_key, setup);

  static Future<HiveNotificationLocalDatasource> getInstance() async {
    final encryptedBox =
        await SecuredHiveMixin.openLazySecuredBox<NotificationsSetup>(
      'NotificationsSetup',
    );

    return HiveNotificationLocalDatasource._(encryptedBox);
  }

  Future<void> addListenedTxChain(String txChainGenesisAddress) async {
    final notificationsSetup = await _getSetup();
    await _setSetup(
      notificationsSetup.copyWith(
        listenedTxChains: {
          txChainGenesisAddress,
          ...notificationsSetup.listenedTxChains
        }.toList(),
      ),
    );
  }

  Future<void> removeListenedTxChain(String txChainGenesisAddress) async {
    final notificationsSetup = await _getSetup();
    await _setSetup(
      notificationsSetup.copyWith(
        listenedTxChains: notificationsSetup.listenedTxChains
            .where((txChainAddress) => txChainAddress != txChainGenesisAddress)
            .toList(),
      ),
    );
  }

  Future<List<String>> getListenedTxChains() async {
    final notificationsSetup = await _getSetup();
    return notificationsSetup.listenedTxChains;
  }

  Future<String?> getLastFcmToken() async {
    final notificationsSetup = await _getSetup();
    return notificationsSetup.lastFcmToken;
  }

  Future<void> updateFcmToken(String? remoteFcmToken) async {
    final notificationsSetup = await _getSetup();
    await _setSetup(
      notificationsSetup.copyWith(
        lastFcmToken: remoteFcmToken,
      ),
    );
  }
}
