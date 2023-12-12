import 'dart:io';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/add_service.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/failure.dart';
import 'package:aewallet/domain/rpc/commands/send_transaction.dart';
import 'package:aewallet/infrastructure/repositories/transaction/archethic_transaction.dart';
import 'package:aewallet/infrastructure/repositories/transaction/transaction_keychain_builder.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/add_service/layouts/add_service_confirmation_form.dart';
import 'package:aewallet/util/notifications_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

class AddServiceHandler extends CommandHandler {
  AddServiceHandler({
    required BuildContext context,
    required WidgetRef ref,
  }) : super(
          canHandle: (command) =>
              command is RPCCommand<RPCAddServiceCommandData>,
          handle: (command) async {
            _showNotification(
              context: context,
              ref: ref,
              command: command,
            );

            if (command.data.name.isEmpty) {
              return Result.failure(
                RPCFailure.invalidParams(),
              );
            }
            final networkSettings = ref.watch(
              SettingsProviders.settings.select((settings) => settings.network),
            );
            final archethicTransactionRepository =
                ArchethicTransactionRepository(
              phoenixHttpEndpoint: networkSettings.getPhoenixHttpLink(),
              websocketEndpoint: networkSettings.getWebsocketUri(),
            );
            final originPrivateKey =
                archethicTransactionRepository.apiService.getOriginKey();
            final session = ref.watch(SessionProviders.session).loggedIn!;
            var keychain = await archethicTransactionRepository.apiService
                .getKeychain(session.wallet.seed);

            final nameEncoded = Uri.encodeFull(
              command.data.name,
            );
            final kDerivationPathWithoutIndex = "m/650'/$nameEncoded/";
            const index = 0;
            final kDerivationPath = '$kDerivationPathWithoutIndex$index';

            if (keychain.services.containsKey(nameEncoded)) {
              return Result.failure(
                RPCFailure.serviceAlreadyExists(),
              );
            }
            keychain = keychain.copyWithService(nameEncoded, kDerivationPath);

            final keychainTransaction = await KeychainTransactionBuilder.build(
              keychain: keychain,
              originPrivateKey: originPrivateKey,
            );

            final newCommand = RPCCommand<RPCSendTransactionCommandData>(
              origin: command.origin,
              data: RPCSendTransactionCommandData(
                data: keychainTransaction.data!,
                version: keychainTransaction.version,
                type: keychainTransaction.type!,
              ),
            );

            if (!kIsWeb &&
                (Platform.isLinux || Platform.isMacOS || Platform.isWindows)) {
              await windowManager.show();
            }

            final result = (await context.push(
              AddServiceConfirmationForm.routerPage,
              extra: {'serviceName': nameEncoded, 'command': newCommand},
            ))! as Result<TransactionConfirmation, TransactionError>;

            return result.map(
                  failure: (failure) => Result.failure(
                    RPCFailure.fromTransactionError(failure),
                  ),
                  success: (success) {
                    Future<void>.sync(() async {
                      final connectivityStatusProvider =
                          ref.read(connectivityStatusProviders);
                      if (connectivityStatusProvider ==
                          ConnectivityStatus.isConnected) {
                        await ref
                            .read(SessionProviders.session.notifier)
                            .refresh();

                        await ref
                            .read(AccountProviders.selectedAccount.notifier)
                            .refreshRecentTransactions();
                      }
                    });

                    return Result.success(
                      success,
                    );
                  },
                ) ??
                Result.failure(
                  RPCFailure.userRejected(),
                );
          },
        );

  static Future<void> _showNotification({
    required BuildContext context,
    required WidgetRef ref,
    required RPCCommand<RPCAddServiceCommandData> command,
  }) async {
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;

    final message =
        AppLocalizations.of(context)!.addServiceCommandReceivedNotification;

    NotificationsUtil.showNotification(
      title: 'Archethic',
      body: message
          .replaceAll(
            '%1',
            command.origin.name,
          )
          .replaceAll('%2', accountSelected!.nameDisplayed),
    );
  }
}
