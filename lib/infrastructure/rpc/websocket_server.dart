import 'dart:async';
import 'dart:io';

import 'package:aewallet/infrastructure/rpc/awc_json_rpc_server.dart';
import 'package:aewallet/util/universal_platform.dart';
import 'package:logging/logging.dart';
import 'package:web_socket_channel/io.dart';

class ArchethicWebsocketRPCServer {
  ArchethicWebsocketRPCServer();

  static final _logger = Logger('Websocket RPC Server');
  static const host = '127.0.0.1';
  static const port = 12345;

  static bool get isPlatformCompatible => UniversalPlatform.isDesktop;

  HttpServer? _runningHttpServer;
  final Set<AWCJsonRPCServer> _openedSockets = {};

  bool get isRunning => _openedSockets.isNotEmpty || _runningHttpServer != null;

  Future<void> run() async => runZonedGuarded(
        () async {
          if (isRunning) {
            _logger.info('Already running. Cancel `start`');
            return;
          }

          _logger.info('Starting at ws://$host:$port');
          final httpServer = await HttpServer.bind(
            host,
            port,
            shared: true,
          );

          httpServer.listen((HttpRequest request) async {
            _logger.info('Received connection');

            final socket = await WebSocketTransformer.upgrade(request);
            final channel = IOWebSocketChannel(socket);

            final peerServer = AWCJsonRPCServer(channel.cast<String>());

            _openedSockets.add(peerServer);
            await peerServer.listen();
          });
          _runningHttpServer = httpServer;
        },
        (error, stack) {
          _logger.severe('WebSocket server failed', error, stack);
        },
      );

  Future<void> stop() async => runZonedGuarded(
        () async {
          if (!isRunning) {
            _logger.info('Already stopped. Cancel `stop`');
            return;
          }

          _logger.info('Closing all websocket connections');
          for (final socket in _openedSockets) {
            await socket.close();
          }
          _openedSockets.clear();

          _logger.info('Stopping at ws://$host:$port');
          await _runningHttpServer?.close();
          _runningHttpServer = null;
          _logger.info('Server stopped at ws://$host:$port');
        },
        (error, stack) {
          _logger.severe('WebSocket server failed to stop', error, stack);
        },
      );
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
