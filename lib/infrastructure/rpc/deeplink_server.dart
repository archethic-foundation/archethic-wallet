import 'dart:async';
import 'dart:developer';

import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:aewallet/infrastructure/rpc/get_accounts/command_handler.dart';
import 'package:aewallet/infrastructure/rpc/get_endpoint/command_handler.dart';
import 'package:aewallet/infrastructure/rpc/send_transaction/command_handler.dart';
import 'package:deeplink_rpc/deeplink_rpc.dart';

class ArchethicDeeplinkRPCServer extends DeeplinkRpcRequestReceiver {
  ArchethicDeeplinkRPCServer() {
    registerHandler(
      DeeplinkRpcRequestHandler(
        route: const DeeplinkRpcRoute('send_transaction'),
        handle: (request) => _handle(
          RPCSendTransactionCommandHandler(),
          request,
        ),
      ),
    );
    registerHandler(
      DeeplinkRpcRequestHandler(
        route: const DeeplinkRpcRoute('get_endpoint'),
        handle: (request) => _handle(
          RPCGetEndpointCommandHandler(),
          request,
        ),
      ),
    );
    registerHandler(
      DeeplinkRpcRequestHandler(
        route: const DeeplinkRpcRoute('get_accounts'),
        handle: (request) => _handle(
          RPCGetAccountsCommandHandler(),
          request,
        ),
      ),
    );
  }

  static Future<Map<String, dynamic>> _handle(
    RPCCommandHandler commandHandler,
    DeeplinkRpcRequest request,
  ) async {
    const logName = 'DeeplinkRpcHandler';

    final result = await commandHandler.handle(request.params);

    return result.map(
      success: commandHandler.resultFromModel,
      failure: (failure) {
        log(
          'Command failed',
          name: logName,
          error: failure,
        );

        throw DeeplinkRpcFailure(
          code: failure.code,
          message: failure.message ?? 'Command failed',
        );
      },
    );
  }
}
