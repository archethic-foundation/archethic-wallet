import 'package:aewallet/domain/repositories/notifications_repository.dart';
import 'package:aewallet/infrastructure/datasources/notification_backend_client.dart';
import 'package:aewallet/infrastructure/datasources/notification_local_datasource.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsRepositoryImpl
    with MessengerMixin, NotificationUtil
    implements NotificationsRepository {
  NotificationsRepositoryImpl({required this.networksSetting}) {
    _client = NotificationBackendClient(
      notificationBackendUrl: networksSetting.notificationBackendUrl,
    );
  }

  late final NotificationBackendClient _client;
  final _localSetup = HiveNotificationLocalDatasource.getInstance();
  final NetworksSetting networksSetting;

  @override
  Stream<TxSentEvent> get events => _client.events;

  Future<String?> get cachedFcmToken async {
    final localSetup = await _localSetup;
    return localSetup.getLastFcmToken();
  }

  @override
  Future<void> subscribe(String txChainGenesisAddress) async {
    final fcmToken = await cachedFcmToken;
    if (fcmToken == null) return;

    await _client.subscribePushNotifs(
      token: fcmToken,
      txChainGenesisAddresses: [txChainGenesisAddress],
    );

    await _client.subscribeWebsocketNotifs([txChainGenesisAddress]);
    await (await _localSetup).addListenedTxChain(txChainGenesisAddress);
  }

  @override
  Future<void> unsubscribe(String txChainGenesisAddress) async {
    final fcmToken = await cachedFcmToken;
    if (fcmToken == null) return;
    await _client.unsubscribePushNotifs(
      token: fcmToken,
      txChainGenesisAddresses: {txChainGenesisAddress},
    );
    await _client.unsubscribeWebsocketNotifs([txChainGenesisAddress]);

    await (await _localSetup).removeListenedTxChain(txChainGenesisAddress);
  }

  @override
  Future<void> initialize() async {
    await _client.connect();

    await Firebase.initializeApp();
    final token = await FirebaseMessaging.instance.getToken();
    (await _localSetup).updateFcmToken(token);

    await _restoreWebsocketSubscriptions();

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      final previousFcmToken = await cachedFcmToken;

      if (previousFcmToken != fcmToken) {
        await _updatePushSubscriptions(
          previousToken: previousFcmToken,
          newToken: fcmToken,
        );
        (await _localSetup).updateFcmToken(fcmToken);
      }
    });
  }

  Future<void> _updatePushSubscriptions({
    required String newToken,
    required String? previousToken,
  }) async {
    final localSetup = await _localSetup;
    final txChainAddresses = await localSetup.getListenedTxChains();

    if (previousToken != null) {
      await _client.unsubscribePushNotifs(
        token: previousToken,
        txChainGenesisAddresses: txChainAddresses,
      );
    }
    await _client.subscribePushNotifs(
      token: newToken,
      txChainGenesisAddresses: txChainAddresses,
    );
  }

  Future<void> _restoreWebsocketSubscriptions() async {
    final txChainAddresses = await (await _localSetup).getListenedTxChains();

    await _client.subscribeWebsocketNotifs(txChainAddresses);
  }
}
