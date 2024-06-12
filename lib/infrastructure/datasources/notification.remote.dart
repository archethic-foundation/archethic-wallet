import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:aewallet/domain/repositories/notifications_repository.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
import 'package:socket_io_client/socket_io_client.dart';

class NotificationBackendClient {
  NotificationBackendClient({
    required this.notificationBackendUrl,
    required this.onConnect,
  }) {
    socket = socket_io.io(
      notificationBackendUrl,
      OptionBuilder().setTransports(['websocket']).build(),
    )
      ..onConnectError((e) {
        _logger.severe('Connection failed', e);
      })
      ..onConnect((_) {
        _logger.info('Did connect');
        onConnect();
      })
      ..onReconnect((_) {
        _logger.info('Did reconnect');
      })
      ..onDisconnect((_) {
        _logger.info('Did disconnect');
      });
  }

  final VoidCallback onConnect;

  static final _logger = Logger('NotificationBackendClient');

  final String notificationBackendUrl;

  final _eventsStreamController = StreamController<TxSentEvent>.broadcast();
  Stream<TxSentEvent> get events => _eventsStreamController.stream;

  late final socket_io.Socket socket;

  Future<void> connect() async {
    socket.on(
      'TxSent',
      (event) {
        _logger.info('TxSent event received');
        _eventsStreamController.add(TxSentEvent.fromJson(event));
      },
    );
  }

  Future<void> updatePushSettings({
    required String token,
    required String locale,
  }) async {
    await http.put(
      Uri.parse('$notificationBackendUrl/pushSettings'),
      headers: {HttpHeaders.contentTypeHeader: ContentType.json.mimeType},
      body: jsonEncode({
        'pushToken': token,
        'locale': locale,
      }),
    );
  }

  Future<void> unsubscribePushNotifs({
    required String token,
    required Iterable<String> listenAddresses,
  }) async {
    await http.post(
      Uri.parse('$notificationBackendUrl/unsubscribePush'),
      headers: {HttpHeaders.contentTypeHeader: ContentType.json.mimeType},
      body: jsonEncode({
        'txChainGenesisAddresses': listenAddresses.toList(),
        'pushToken': token,
      }),
    );
  }

  Future<void> subscribePushNotifs({
    required String token,
    required Iterable<String> listenAddresses,
  }) async {
    await http.post(
      Uri.parse('$notificationBackendUrl/subscribePush'),
      headers: {HttpHeaders.contentTypeHeader: ContentType.json.mimeType},
      body: jsonEncode(<String, dynamic>{
        'txChainGenesisAddresses': listenAddresses.toList(),
        'pushToken': token,
      }),
    );
  }

  Future<void> subscribeWebsocketNotifs(
    Iterable<String> listenAddresses,
  ) async {
    socket.emit(
      'subscribe',
      {
        'txChainGenesisAddresses': listenAddresses.toList(),
      },
    );
  }

  Future<void> unsubscribeWebsocketNotifs(
    Iterable<String> listenAddresses,
  ) async {
    socket.emit(
      'unsubscribe',
      jsonEncode({
        'txChainGenesisAddresses': listenAddresses.toList(),
      }),
    );
  }
}
