import 'dart:developer';

import 'package:aewallet/domain/service/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/service/rpc/commands/send_transaction.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_errors.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_request.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_send_transaction_command.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_send_transaction_result.dart';
import 'package:json_rpc_2/json_rpc_2.dart';

Function sendTransactionWebsocketHandlerBuilder(
  CommandDispatcher<RPCSendTransactionCommand, SendTransactionResult>
      commandDispatcher,
) =>
    (Parameters params) async {
      const LOG_NAME = 'RPC Server : SendTransactionHandler';

      try {
        log('Received SendTransaction', name: LOG_NAME);

        final commandDTO = RpcRequest.fromJson(
          params.value,
        );
        final commandModel = commandDTO.toSignTransactionModel();
        final result = await commandDispatcher.add(
          commandModel,
        );

        return result.map(
          success: RpcSendTransactionResult.fromModel,
          failure: (failure) {
            log(
              'SendTransaction failed',
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
        throw RpcException.invalidParams(
          'Invalid transaction format',
        );
      }
    };
