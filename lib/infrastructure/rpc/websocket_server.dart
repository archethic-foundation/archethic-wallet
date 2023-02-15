import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:aewallet/domain/service/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/service/rpc/commands/send_transaction.dart';
import 'package:aewallet/infrastructure/rpc/websocket_handlers/get_endpoint.dart';
import 'package:aewallet/infrastructure/rpc/websocket_handlers/send_transaction.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:web_socket_channel/io.dart';

class ArchethicRPCServer {
  ArchethicRPCServer({
    required this.signTransactionCommandDispatcher,
  });

  static const LOG_NAME = 'RPC Server';
  static const HOST = '127.0.0.1';
  static const PORT = 12345;

  final CommandDispatcher<RPCSendTransactionCommand, SendTransactionResult>
      signTransactionCommandDispatcher;

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
              'sendTransaction',
              sendTransactionWebsocketHandlerBuilder(
                signTransactionCommandDispatcher,
              ),
            )
            ..registerMethod(
              'getEndpoint',
              getEndpointWebsocketHandlerBuilder(),
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
