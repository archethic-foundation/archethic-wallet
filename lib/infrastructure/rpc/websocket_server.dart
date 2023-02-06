import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:aewallet/domain/service/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/service/rpc/commands/sign_transaction.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_errors.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_sign_transaction_command.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_sign_transaction_result.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:web_socket_channel/io.dart';

class ArchethicRPCServer {
  ArchethicRPCServer({
    required this.signTransactionCommandDispatcher,
  });

  static const LOG_NAME = 'RPC Server';
  static const HOST = '127.0.0.1';
  static const PORT = 12345;

  final CommandDispatcher<SignTransactionCommand, SignTransactionResult>
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
              'signTransaction',
              (Parameters params) async {
                try {
                  log('Received SendTokenTransaction', name: LOG_NAME);

                  final signTransactionCommandDTO =
                      RpcSignTransactionCommand.fromJson(
                    params.value,
                  );
                  final signTransactionCommand =
                      signTransactionCommandDTO.toModel();
                  final result = await signTransactionCommandDispatcher.add(
                    signTransactionCommand,
                  );

                  return result.map(
                    success: RpcSignTransactionResult.fromModel,
                    failure: (failure) {
                      log(
                        'SendTokenTransaction failed',
                        name: LOG_NAME,
                        error: failure.message,
                      );
                      throw RpcException(
                        ArchethicRPCErrors.fromTransactionError(failure),
                        failure.message,
                      );
                    },
                  );
                } on TypeError catch (e, stack) {
                  log(
                    'Invalid transaction format',
                    name: LOG_NAME,
                    error: e,
                    stackTrace: stack,
                  );
                  throw RpcException(
                    ArchethicRPCErrors.invalidTransaction,
                    'Invalid transaction format',
                  );
                }
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
