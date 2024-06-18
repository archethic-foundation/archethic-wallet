import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/infrastructure/rpc/dto/request_origin.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

class RPCKeychainDeriveAddressCommandHandler extends RPCCommandHandler<
    awc.KeychainDeriveAddressRequest, awc.KeychainDeriveAddressResult> {
  RPCKeychainDeriveAddressCommandHandler() : super();

  @override
  RPCCommand<awc.KeychainDeriveAddressRequest> commandToModel(
    awc.Request dto,
  ) =>
      RPCCommand(
        origin: dto.origin.toModel,
        data: awc.KeychainDeriveAddressRequest(
          serviceName: dto.payload['serviceName'],
          index: dto.payload['index'] ?? 0,
          pathSuffix: dto.payload['pathSuffix'] ?? '',
        ),
      );

  @override
  Map<String, dynamic> resultFromModel(
    awc.KeychainDeriveAddressResult model,
  ) =>
      model.toJson();
}
