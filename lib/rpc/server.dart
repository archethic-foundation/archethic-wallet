import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:aewallet/rpc/dto/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shelf/shelf.dart';

part 'server.freezed.dart';
part 'server.g.dart';
part 'sign_transaction_handler.dart';

class ArchethicRPCServer {
  static const LOG_NAME = 'RPC Server';
  static const HOST = '0.0.0.0';
  static const PORT = 12345;

  static bool get isPlatformCompatible {
    return Platform.isLinux || Platform.isMacOS || Platform.isWindows;
  }

  Future<void> run() async {
    runZonedGuarded(
      () async {
        log('Starting at ws://$HOST:$PORT', name: LOG_NAME);
        final socketServer = await HttpServer.bind(
          HOST,
          PORT,
          shared: true,
        );

        socketServer.listen(
          onRequest,
          onError: (error, stack) {
            log(
              'WebSocket listen ERROR',
              error: error,
              stackTrace: stack,
              name: LOG_NAME,
            );
          },
          onDone: () {
            log(
              'WebSocket listen DONE',
              name: LOG_NAME,
            );
          },
        );
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

  Future<void> onRequest(HttpRequest request) async {
    log('request : $request', name: LOG_NAME);
    final socket = await WebSocketTransformer.upgrade(request);
    socket.listen(
      (event) {
        log('request : ${event}', name: LOG_NAME);
        socket.add('response to $event');
      },
      onError: (error, stack) {
        log(
          'WebSocket ERROR',
          error: error,
          stackTrace: stack,
          name: LOG_NAME,
        );
      },
      onDone: () {
        log(
          'WebSocket DONE',
          name: LOG_NAME,
        );
      },
    );
  }
}
