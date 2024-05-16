import 'package:aewallet/domain/repositories/notifications_repository.dart';
import 'package:aewallet/infrastructure/datasources/notification.remote.dart';
import 'package:aewallet/infrastructure/datasources/notification.vault.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsRepositoryImpl
    with NotificationUtil
    implements NotificationsRepository {
  NotificationsRepositoryImpl({required this.networksSetting}) {
    _client = NotificationBackendClient(
      notificationBackendUrl: networksSetting.notificationBackendUrl,
      onConnect: _onConnect,
    );
  }

  late final NotificationBackendClient _client;
  final NetworksSetting networksSetting;

  @override
  Stream<TxSentEvent> get events => _client.events;

  Future<NotificationVaultDatasource> get _localSetup =>
      NotificationVaultDatasource.getInstance();

  Future<String?> get cachedFcmToken async {
    return (await _localSetup).getLastFcmToken();
  }

  @override
  Future<void> updatePushSettings({
    required String locale,
  }) async {
    final fcmToken = await cachedFcmToken;
    if (fcmToken == null) return;

    await _client.updatePushSettings(
      token: fcmToken,
      locale: locale,
    );
  }

  @override
  Future<void> subscribe(List<String> listenAddresses) async {
    final fcmToken = await cachedFcmToken;
    if (fcmToken == null) return;

    await _client.subscribePushNotifs(
      token: fcmToken,
      listenAddresses: listenAddresses,
    );

    await _client.subscribeWebsocketNotifs(listenAddresses);
    await (await _localSetup).addListenedAddresses(listenAddresses);
  }

  @override
  Future<void> unsubscribe(List<String> listenAddresses) async {
    final fcmToken = await cachedFcmToken;
    if (fcmToken == null) return;
    await _client.unsubscribePushNotifs(
      token: fcmToken,
      listenAddresses: listenAddresses,
    );
    await _client.unsubscribeWebsocketNotifs(listenAddresses);
    await (await _localSetup).removeListenedAddresses(listenAddresses);
  }

  @override
  Future<void> unsubscribeAll() async {
    final listenedAddresses = await (await _localSetup).getListenedAddresses();
    await unsubscribe(listenedAddresses);
  }

  Future<void> _onConnect() async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await _updatePushSubscriptions(
        previousToken: await cachedFcmToken,
        newToken: token,
      );
      await (await _localSetup).updateFcmToken(token);
    }

    await _restoreWebsocketSubscriptions();
  }

  @override
  Future<void> initialize() async {
    await _client.connect();
    await Firebase.initializeApp();

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      final previousFcmToken = await cachedFcmToken;

      if (previousFcmToken != fcmToken) {
        await _updatePushSubscriptions(
          previousToken: previousFcmToken,
          newToken: fcmToken,
        );
        await (await _localSetup).updateFcmToken(fcmToken);
      }
    });
  }

  Future<void> _updatePushSubscriptions({
    required String newToken,
    required String? previousToken,
  }) async {
    final localSetup = await _localSetup;
    final listenAddresses = await localSetup.getListenedAddresses();

    if (previousToken != null) {
      await _client.unsubscribePushNotifs(
        token: previousToken,
        listenAddresses: listenAddresses,
      );
    }
    await _client.subscribePushNotifs(
      token: newToken,
      listenAddresses: listenAddresses,
    );
  }

  Future<void> _restoreWebsocketSubscriptions() async {
    final listenAddresses = await (await _localSetup).getListenedAddresses();

    await _client.subscribeWebsocketNotifs(listenAddresses);
  }
}
