import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/get_storage_nonce_public_key.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_request.dart';

class RPCGetStorageNoncePublicKeyCommandHandler extends RPCCommandHandler<
    RPCGetStorageNoncePublicKeyCommandData,
    RPCGetStorageNoncePublicKeyResultData> {
  RPCGetStorageNoncePublicKeyCommandHandler() : super();

  @override
  RPCCommand<RPCGetStorageNoncePublicKeyCommandData> commandToModel(
    RPCRequestDTO dto,
  ) =>
      RPCCommand(
        origin: dto.origin.toModel(),
        data: const RPCGetStorageNoncePublicKeyCommandData(),
      );

  @override
  Map<String, dynamic> resultFromModel(
    RPCGetStorageNoncePublicKeyResultData model,
  ) {
    return {
      'storageNoncePublicKey': model.storageNoncePublicKey,
    };
  }
}
