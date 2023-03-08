import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:aewallet/infrastructure/rpc/get_accounts/command_handler.dart';
import 'package:aewallet/infrastructure/rpc/get_endpoint/command_handler.dart';
import 'package:aewallet/infrastructure/rpc/send_transaction/command_handler.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:web_socket_channel/io.dart';

class ArchethicWebsocketRPCServer {
  ArchethicWebsocketRPCServer({
    required this.commandDispatcher,
  });

  static const logName = 'RPC Server';
  static const host = '127.0.0.1';
  static const port = 12345;

  final CommandDispatcher commandDispatcher;

  static bool get isPlatformCompatible {
    return Platform.isLinux || Platform.isMacOS || Platform.isWindows;
  }

  Future<void> run() async {
    runZonedGuarded(
      () async {
        log('Starting at ws://$host:$port', name: logName);
        final server = await HttpServer.bind(
          host,
          port,
          shared: true,
        );

        server.listen((HttpRequest request) async {
          log('Received request', name: logName);

          final socket = await WebSocketTransformer.upgrade(request);
          final channel = IOWebSocketChannel(socket);

          final server = Peer(channel.cast<String>())
            ..registerMethod(
              'sendTransaction',
              (params) => _handle(RPCSendTransactionCommandHandler(), params),
            )
            ..registerMethod(
              'getEndpoint',
              (params) => _handle(RPCGetEndpointCommandHandler(), params),
            )
            ..registerMethod(
              'getAccounts',
              (params) => _handle(RPCGetAccountsCommandHandler(), params),
            );
          await server.listen();
        });
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

  Future<Map<String, dynamic>> _handle(
    RPCCommandHandler commandHandler,
    Parameters params,
  ) async {
    final result = await commandHandler.handle(params.value);
    return result.map(
      success: commandHandler.resultFromModel,
      failure: (failure) {
        log(
          'Command failed',
          name: logName,
          error: failure,
        );

        throw RpcException(
          failure.code,
          failure.message ?? 'Command failed',
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
