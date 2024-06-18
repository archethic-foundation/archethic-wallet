import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/infrastructure/rpc/dto/request_origin.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

class RPCKeychainDeriveKeypairCommandHandler extends RPCCommandHandler<
    awc.KeychainDeriveKeypairRequest, awc.KeychainDeriveKeypairResult> {
  RPCKeychainDeriveKeypairCommandHandler() : super();

  @override
  RPCCommand<awc.KeychainDeriveKeypairRequest> commandToModel(
    awc.Request dto,
  ) =>
      RPCCommand(
        origin: dto.origin.toModel,
        data: awc.KeychainDeriveKeypairRequest(
          serviceName: dto.payload['serviceName'],
          index: dto.payload['index'] ?? 0,
          pathSuffix: dto.payload['pathSuffix'] ?? '',
        ),
      );

  @override
  Map<String, dynamic> resultFromModel(
    awc.KeychainDeriveKeypairResult model,
  ) =>
      model.toJson();
}
