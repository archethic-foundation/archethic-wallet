import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/failure.dart';
import 'package:aewallet/domain/rpc/commands/keychain_derive_keypair.dart';
import 'package:aewallet/infrastructure/repositories/archethic_transaction.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeychainDeriveKeypairCommandHandler extends CommandHandler {
  KeychainDeriveKeypairCommandHandler({
    required WidgetRef ref,
  }) : super(
          canHandle: (command) =>
              command is RPCCommand<RPCKeychainDeriveKeypairCommandData>,
          handle: (command) async {
            command as RPCCommand<RPCKeychainDeriveKeypairCommandData>;

            final networkSettings = ref.watch(
              SettingsProviders.settings.select((settings) => settings.network),
            );
            final archethicTransactionRepository =
                ArchethicTransactionRepository(
              phoenixHttpEndpoint: networkSettings.getPhoenixHttpLink(),
              websocketEndpoint: networkSettings.getWebsocketUri(),
            );
            final session = ref.watch(SessionProviders.session).loggedIn!;
            final keychain = await archethicTransactionRepository.apiService
                .getKeychain(session.wallet.seed);

            if (keychain.services.containsKey(command.data.serviceName) ==
                false) {
              return Result.failure(RPCFailure.serviceNotFound());
            }

            final publicKey = uint8ListToHex(
              keychain
                  .deriveKeypair(
                    command.data.serviceName,
                    index: command.data.index ?? 0,
                    pathSuffix: command.data.pathSuffix ?? '',
                  )
                  .publicKey!,
            );

            return Result.success(
              RPCKeychainDeriveKeypairResultData(publicKey: publicKey),
            );
          },
        );
}
