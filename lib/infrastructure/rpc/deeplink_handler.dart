import 'dart:developer';

import 'package:aewallet/domain/service/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/service/rpc/commands/sign_transaction.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_errors.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_sign_transaction_command.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_sign_transaction_result.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:deeplink_rpc/deeplink_rpc.dart';

final deeplinkRpcSignTransactionHandler = DeeplinkRpcRequestHandler(
  route: const DeeplinkRpcRoute('sign_transaction'),
  handle: (request) async {
    const logName = 'DeeplinkRpcHandler';

    final signTransactionCommandDTO = RpcSignTransactionCommand.fromJson(
      request.params,
    );

    final signTransactionCommand = signTransactionCommandDTO.toModel();
    final result = await sl
        .get<CommandDispatcher<SignTransactionCommand, SignTransactionResult>>()
        .add(signTransactionCommand);

    return result.map(
      success: (success) =>
          RpcSignTransactionResult.fromModel(success).toJson(),
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
