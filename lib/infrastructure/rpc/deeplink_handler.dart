import 'dart:developer';

import 'package:aewallet/domain/service/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/service/rpc/commands/send_transaction.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_errors.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_request.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_send_transaction_command.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_send_transaction_result.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:deeplink_rpc/deeplink_rpc.dart';

final deeplinkRpcSendTransactionHandler = DeeplinkRpcRequestHandler(
  route: const DeeplinkRpcRoute('send_transaction'),
  handle: (request) async {
    const logName = 'DeeplinkRpcHandler';

    final signTransactionCommandDTO = RpcRequest.fromJson(
      request.params,
    );

    final signTransactionCommand =
        signTransactionCommandDTO.toSignTransactionModel();
    final result = await sl
        .get<
            CommandDispatcher<RPCSendTransactionCommand,
                SendTransactionResult>>()
        .add(signTransactionCommand);

    return result.map(
      success: (success) =>
          RpcSendTransactionResult.fromModel(success).toJson(),
      failure: (failure) {
        log(
          'SendTokenTransaction failed',
          name: logName,
          error: failure.message,
        );
        throw DeeplinkRpcFailure(
          message: failure.message,
          code: ArchethicRPCErrors.fromTransactionError(failure),
        );
      },
    );
  },
);
