import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/failure.dart';
import 'package:aewallet/domain/rpc/commands/get_storage_nonce_public_key.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetStorageNoncePublicKeyHandler extends CommandHandler {
  GetStorageNoncePublicKeyHandler({
    required WidgetRef ref,
  }) : super(
          canHandle: (command) =>
              command is RPCCommand<RPCGetStorageNoncePublicKeyCommandData>,
          handle: (command) async {
            command as RPCCommand<RPCGetStorageNoncePublicKeyCommandData>;

            final storageNoncePublicKey =
                await sl.get<ApiService>().getStorageNoncePublicKey();
            final session = ref.watch(SessionProviders.session).loggedIn!;

            final nameSelectedAccount =
                ref.read(AccountProviders.selectedAccount).valueOrNull!.name;

            if (session.wallet.keychainSecuredInfos
                    .services[nameSelectedAccount] ==
                null) {
              return Result.failure(RPCFailure.serviceNotFound());
            }

            return Result.success(
              RPCGetStorageNoncePublicKeyResultData(
                authorizedKey: AuthorizedKey(
                  encryptedSecretKey: uint8ListToHex(
                    ecEncrypt(
                      session.wallet.keychainSecuredInfos
                          .services[nameSelectedAccount]!.keyPair!.privateKey,
                      storageNoncePublicKey,
                    ),
                  ),
                  publicKey: storageNoncePublicKey,
                ),
              ),
            );
          },
        );
}
