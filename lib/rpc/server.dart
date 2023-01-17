import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:web_socket_channel/io.dart';

part 'sign_transaction_handler.dart';

class ArchethicRPCErrors {
  static const userRejected = 4001;
  static const unauthorized = 4100;
  static const unsupportedMethod = 4200;
}

class ArchethicRPCServer {
  static const LOG_NAME = 'RPC Server';
  static const HOST = '127.0.0.1';
  static const PORT = 12345;

  static bool get isPlatformCompatible {
    return Platform.isLinux || Platform.isMacOS || Platform.isWindows;
  }

  Future<void> run() async {
    runZonedGuarded(
      () async {
        log('Starting at ws://$HOST:$PORT', name: LOG_NAME);
        final server = await HttpServer.bind(
          HOST,
          PORT,
          shared: true,
        );

        server.listen((HttpRequest request) async {
          log('Received request', name: LOG_NAME);
          final socket = await WebSocketTransformer.upgrade(request);
          final channel = IOWebSocketChannel(socket);
          final server = Server(channel.cast<String>())
            ..registerMethod(
              'signTx',
              (Parameters params) {
                throw RpcException(
                  ArchethicRPCErrors.unsupportedMethod,
                  'Not implemented yet',
                );
              },
            );
          await server.listen();
        });
      },
      (error, stack) {
        log(
          'WebSocket server failed',
          error: error,
          stackTrace: stack,
          name: LOG_NAME,
        );
      },
    );
  }
}
