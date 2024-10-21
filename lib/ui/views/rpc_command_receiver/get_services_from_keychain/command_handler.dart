import 'package:aewallet/application/address_service.dart';
import 'package:aewallet/application/api_service.dart';
import 'package:aewallet/application/app_service.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/infrastructure/repositories/transaction/archethic_transaction.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetServicesFromKeychainCommandHandler extends CommandHandler {
  GetServicesFromKeychainCommandHandler({
    required WidgetRef ref,
  }) : super(
          canHandle: (command) =>
              command is RPCCommand<awc.GetServicesFromKeychainRequest>,
          handle: (command) async {
            command as RPCCommand<awc.GetServicesFromKeychainRequest>;

            final networkSettings = ref.watch(
              SettingsProviders.settings.select((settings) => settings.network),
            );
            final appService = ref.read(appServiceProvider);
            final apiService = ref.watch(apiServiceProvider);
            final addressService = ref.watch(addressServiceProvider);

            final archethicTransactionRepository =
                ArchethicTransactionRepository(
              phoenixHttpEndpoint: networkSettings.getPhoenixHttpLink(),
              websocketEndpoint: networkSettings.getWebsocketUri(),
              apiService: apiService,
              appService: appService,
              addressService: addressService,
            );
            final session = ref.watch(sessionNotifierProvider).loggedIn!;
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
              awc.GetServicesFromKeychainResult(services: services),
            );
          },
        );
}
