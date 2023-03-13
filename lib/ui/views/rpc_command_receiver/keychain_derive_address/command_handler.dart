import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/failure.dart';
import 'package:aewallet/domain/rpc/commands/keychain_derive_address.dart';
import 'package:aewallet/infrastructure/repositories/archethic_transaction.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeychainDeriveAddressCommandHandler extends CommandHandler {
  KeychainDeriveAddressCommandHandler({
    required WidgetRef ref,
  }) : super(
          canHandle: (command) =>
              command is RPCCommand<RPCKeychainDeriveAddressCommandData>,
          handle: (command) async {
            command as RPCCommand<RPCKeychainDeriveAddressCommandData>;

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

            final address = uint8ListToHex(
              keychain.deriveAddress(
                command.data.serviceName,
                index: command.data.index ?? 0,
                pathSuffix: command.data.pathSuffix ?? '',
              ),
            );

            return Result.success(
              RPCKeychainDeriveAddressResultData(address: address),
            );
          },
        );
}
