import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:aewallet/domain/repositories/notifications_repository.dart';
import 'package:http/http.dart' as http;
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
        log('Connection failed', name: _logName, error: e);
      })
      ..onConnect((_) {
        log('Did connect', name: _logName);
        onConnect();
      })
      ..onReconnect((_) {
        log('Did reconnect', name: _logName);
      })
      ..onDisconnect((_) {
        log('Did disconnect', name: _logName);
      });
  }

  final VoidCallback onConnect;

  static const _logName = 'NotificationBackendClient';

  final String notificationBackendUrl;

  final _eventsStreamController = StreamController<TxSentEvent>.broadcast();
  Stream<TxSentEvent> get events => _eventsStreamController.stream;

  late final socket_io.Socket socket;

  Future<void> connect() async {
    socket.on(
      'TxSent',
      (event) {
        log('TxSent event received', name: _logName);
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
    required Iterable<String> txChainGenesisAddresses,
  }) async {
    await http.post(
      Uri.parse('$notificationBackendUrl/unsubscribePush'),
      headers: {HttpHeaders.contentTypeHeader: ContentType.json.mimeType},
      body: jsonEncode({
        'txChainGenesisAddresses': txChainGenesisAddresses.toList(),
        'pushToken': token,
      }),
    );
  }

  Future<void> subscribePushNotifs({
    required String token,
    required Iterable<String> txChainGenesisAddresses,
  }) async {
    await http.post(
      Uri.parse('$notificationBackendUrl/subscribePush'),
      headers: {HttpHeaders.contentTypeHeader: ContentType.json.mimeType},
      body: jsonEncode(<String, dynamic>{
        'txChainGenesisAddresses': txChainGenesisAddresses.toList(),
        'pushToken': token,
      }),
    );
  }

  Future<void> subscribeWebsocketNotifs(
    Iterable<String> txChainGenesisAddresses,
  ) async {
    socket.emit(
      'subscribe',
      {
        'txChainGenesisAddresses': txChainGenesisAddresses.toList(),
      },
    );
  }

  Future<void> unsubscribeWebsocketNotifs(
    Iterable<String> txChainGenesisAddresses,
  ) async {
    socket.emit(
      'unsubscribe',
      jsonEncode({
        'txChainGenesisAddresses': txChainGenesisAddresses.toList(),
      }),
    );
  }
}
