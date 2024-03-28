import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:aewallet/infrastructure/rpc/awc_json_rpc_server.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';

class ArchethicWebsocketRPCServer {
  ArchethicWebsocketRPCServer();

  static const logName = 'RPC Server';
  static const host = '127.0.0.1';
  static const port = 12345;

  static bool get isPlatformCompatible {
    return !kIsWeb &&
        (Platform.isLinux || Platform.isMacOS || Platform.isWindows);
  }

  HttpServer? _runningHttpServer;
  final Set<AWCJsonRPCServer> _openedSockets = {};

  bool get isRunning => _openedSockets.isNotEmpty || _runningHttpServer != null;

  Future<void> run() async {
    runZonedGuarded(
      () async {
        if (isRunning) {
          log('Already running. Cancel `start`', name: logName);
          return;
        }

        log('Starting at ws://$host:$port', name: logName);
        final httpServer = await HttpServer.bind(
          host,
          port,
          shared: true,
        );

        httpServer.listen((HttpRequest request) async {
          log('Received request', name: logName);

          final socket = await WebSocketTransformer.upgrade(request);
          final channel = IOWebSocketChannel(socket);

          final peerServer = AWCJsonRPCServer(channel.cast<String>());

          _openedSockets.add(peerServer);
          await peerServer.listen();
        });
        _runningHttpServer = httpServer;
      },
      (error, stack) {
        log(
          'WebSocket server failed',
          error: error,
          stackTrace: stack,
          name: logName,
        );
      },
    );
  }

  Future<void> stop() async {
    runZonedGuarded(
      () async {
        if (!isRunning) {
          log('Already stopped. Cancel `stop`', name: logName);
          return;
        }

        log('Closing all websocket connections', name: logName);
        for (final socket in _openedSockets) {
          await socket.close();
        }
        _openedSockets.clear();

        log('Stopping at ws://$host:$port', name: logName);
        await _runningHttpServer?.close();
        _runningHttpServer = null;
        log('Server stopped at ws://$host:$port', name: logName);
      },
      (error, stack) {
        log(
          'WebSocket server failed to stop',
          error: error,
          stackTrace: stack,
          name: logName,
        );
      },
    );
  }
}

abstract class ExceptionUtil {
  static R guard<R>(
    R Function() call,
    Exception Function(Object) onError,
  ) {
    try {
      return call();
    } catch (e) {
      throw onError(e);
    }
  }
}
