import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/keychain_derive_keypair.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_request.dart';

class RPCKeychainDeriveKeypairCommandHandler extends RPCCommandHandler<
    RPCKeychainDeriveKeypairCommandData, RPCKeychainDeriveKeypairResultData> {
  RPCKeychainDeriveKeypairCommandHandler() : super();

  @override
  RPCCommand<RPCKeychainDeriveKeypairCommandData> commandToModel(
    RPCRequestDTO dto,
  ) =>
      RPCCommand(
        origin: dto.origin.toModel(),
        data: RPCKeychainDeriveKeypairCommandData(
          serviceName: dto.payload['serviceName'],
          index: dto.payload['index'] ?? 0,
          pathSuffix: dto.payload['pathSuffix'] ?? '',
        ),
      );

  @override
  Map<String, dynamic> resultFromModel(
    RPCKeychainDeriveKeypairResultData model,
  ) =>
      {'publicKey': model.publicKey};
}
