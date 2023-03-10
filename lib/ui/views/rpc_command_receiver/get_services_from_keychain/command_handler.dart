import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/get_services_from_keychain.dart';
import 'package:aewallet/infrastructure/repositories/archethic_transaction.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetServicesFromKeychainCommandHandler extends CommandHandler {
  GetServicesFromKeychainCommandHandler({
    required WidgetRef ref,
  }) : super(
          canHandle: (command) =>
              command is RPCCommand<RPCGetServicesFromKeychainCommandData>,
          handle: (command) async {
            command as RPCCommand<RPCGetServicesFromKeychainCommandData>;

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

            final services = <Service>[];
            keychain.services.forEach((key, value) {
              services.add(
                Service(
                  derivationPath: value.derivationPath,
                  curve: value.curve,
                  hashAlgo: value.hashAlgo,
                ),
              );
            });

            return Result.success(
              RPCGetServicesFromKeychainResultData(services: services),
            );
          },
        );
}
