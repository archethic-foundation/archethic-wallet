import 'dart:developer';

import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/failure.dart';
import 'package:aewallet/domain/rpc/subscription.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_request.dart';
import 'package:aewallet/util/get_it_instance.dart';

/// [RPCCommandHandler] is responsible for converting
/// data between RPC channel (deeplink, websocket ...) DTOs
/// and the application domain models.
abstract class RPCCommandHandler<C, R> {
  const RPCCommandHandler();

  /// Transforms received request into a [RPCCommand] model.
  RPCCommand<C> commandToModel(RPCRequestDTO dto);

  Map<String, dynamic> resultFromModel(covariant R model);

  Future<Result<dynamic, RPCFailure>> handle(Map<String, dynamic> data) async {
    final logName = 'RPCCommandHandler [$runtimeType]';
    log('Received command', name: logName);

    try {
      final requestDTO = RPCRequestDTO.fromJson(
        data,
      );

      final commandModel = commandToModel(
        requestDTO,
      );

      return sl.get<CommandDispatcher>().add(commandModel);
    } on TypeError catch (e, stack) {
      log(
        'Invalid data',
        name: logName,
        error: e,
        stackTrace: stack,
      );
      return Result.failure(RPCFailure.invalidParams());
    }
  }
}

/// Handles subscription commands.
abstract class RPCSubscriptionHandler<C, N>
    extends RPCCommandHandler<C, RPCSubscription<N>> {
  @override
  Map<String, dynamic> resultFromModel(covariant RPCSubscription model) => {
        'id': model.id,
      };

  Map<String, dynamic> notificationFromModel(covariant N model);
}
