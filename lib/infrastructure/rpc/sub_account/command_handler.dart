import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/infrastructure/rpc/dto/request_origin.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

class RPCSubscribeAccountCommandHandler
    extends RPCSubscriptionHandler<awc.SubscribeAccountRequest, awc.Account> {
  @override
  RPCCommand<awc.SubscribeAccountRequest> commandToModel(
    awc.Request dto,
  ) =>
      RPCCommand(
        origin: dto.origin.toModel,
        data: awc.SubscribeAccountRequest(
          serviceName: dto.payload['serviceName'],
        ),
      );

  @override
  Map<String, dynamic> notificationFromModel(covariant awc.Account model) =>
      model.toJson();
}
