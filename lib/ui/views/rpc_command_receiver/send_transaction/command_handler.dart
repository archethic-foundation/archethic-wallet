import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/failure.dart';
import 'package:aewallet/domain/rpc/commands/send_transaction.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/window_util_desktop.dart'
    if (dart.library.js) 'package:aewallet/ui/util/window_util_web.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/send_transaction/layouts/send_transaction_confirmation_form.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';

class SendTransactionHandler extends CommandHandler {
  SendTransactionHandler({
    required BuildContext context,
  }) : super(
          canHandle: (command) =>
              command is RPCCommand<RPCSendTransactionCommandData>,
          handle: (command) async {
            command as RPCCommand<RPCSendTransactionCommandData>;

            if (command.data.generateEncryptedSeedSC != null &&
                command.data.generateEncryptedSeedSC == true) {
              if (command.data.data.code == null ||
                  command.data.data.code!.trim().isEmpty) {
                return Result.failure(
                  RPCFailure.invalidTransaction(),
                );
              }

              final apiService = sl.get<ApiService>();
              final storageNoncePublicKey =
                  await apiService.getStorageNoncePublicKey();
              final seedSC = generateRandomSeed();

              /// AESKey (32-byte (256-bit) random key) manages SC secrets
              final aesKey = generateRandomAESKey();

              final scAuthorizedKeys = [
                AuthorizedKey(
                  publicKey: storageNoncePublicKey,
                  encryptedSecretKey:
                      uint8ListToHex(ecEncrypt(aesKey, storageNoncePublicKey)),
                ),
              ];

              command.data.data.ownerships.insert(
                0,
                Ownership(
                  secret: uint8ListToHex(
                    aesEncrypt(seedSC, aesKey),
                  ),
                  authorizedPublicKeys: scAuthorizedKeys,
                ),
              );
            }

            await WindowUtil().showFirst();

            final result = await showDialog<
                Result<TransactionConfirmation, TransactionError>>(
              useSafeArea: false,
              useRootNavigator: false,
              context: context,
              builder: (context) => Dialog.fullscreen(
                child: DecoratedBox(
                  decoration: ArchethicTheme.getDecorationSheet(),
                  child: SendTransactionConfirmationForm(
                    command,
                  ),
                ),
              ),
            );

            return result!.map(
                  failure: (failure) => Result.failure(
                    RPCFailure.fromTransactionError(failure),
                  ),
                  success: Result.success,
                ) ??
                Result.failure(
                  RPCFailure.userRejected(),
                );
          },
        );
}
