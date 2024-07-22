import 'dart:convert';

import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/subscription.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:logging/logging.dart';

/// [RPCCommandHandler] is responsible for converting
/// data between RPC channel (deeplink, websocket ...) DTOs
/// and the application domain models.
abstract class RPCCommandHandler<C, R> {
  const RPCCommandHandler();

  /// Transforms received request into a [RPCCommand] model.
  RPCCommand<C> commandToModel(awc.Request dto);

  Map<String, dynamic> resultFromModel(covariant R model);

  Future<Result<dynamic, awc.Failure>> handle(Map<String, dynamic> data) async {
    final _logger = Logger('RPCCommandHandler [$runtimeType]')
      ..info('Received command : ${jsonEncode(data)}');

    try {
      final requestDTO = awc.Request.fromJson(
        data,
      );

      final commandModel = commandToModel(
        requestDTO,
      );

      return sl.get<CommandDispatcher>().add(commandModel);
      // ignore: avoid_catching_errors
    } on TypeError catch (e, stack) {
      _logger.severe('Invalid data', e, stack);
      return const Result.failure(awc.Failure.invalidParams);
    } catch (e, stack) {
      _logger.severe('Command failed', e, stack);
      return const Result.failure(awc.Failure.other);
    }
  }
}

/// Handles subscription commands.
abstract class RPCSubscriptionHandler<C, N>
    extends RPCCommandHandler<C, RPCSubscription<N>> {
  @override
  Map<String, dynamic> resultFromModel(covariant RPCSubscription model) =>
      awc.Subscription(
        id: model.id,
        updates: model.updates,
      ).toJson();

  Map<String, dynamic> notificationFromModel(covariant N model);
}
