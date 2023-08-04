import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/get_storage_nonce_public_key.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class GetStorageNoncePublicKeyHandler extends CommandHandler {
  GetStorageNoncePublicKeyHandler()
      : super(
          canHandle: (command) =>
              command is RPCCommand<RPCGetStorageNoncePublicKeyCommandData>,
          handle: (command) async {
            command as RPCCommand<RPCGetStorageNoncePublicKeyCommandData>;
            final storageNoncePublicKey =
                await sl.get<ApiService>().getStorageNoncePublicKey();

            return Result.success(
              RPCGetStorageNoncePublicKeyResultData(
                storageNoncePublicKey: storageNoncePublicKey,
              ),
            );
          },
        );
}
