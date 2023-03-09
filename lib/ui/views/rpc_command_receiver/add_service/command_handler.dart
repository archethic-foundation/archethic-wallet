import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/add_service.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/failure.dart';
import 'package:aewallet/domain/rpc/commands/send_transaction.dart';
import 'package:aewallet/infrastructure/repositories/archethic_transaction.dart';
import 'package:aewallet/infrastructure/repositories/transaction_keychain_builder.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/send_transaction/layouts/sign_transaction_confirmation_form.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/notifications_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddServicenHandler extends CommandHandler {
  AddServicenHandler({
    required BuildContext context,
    required WidgetRef ref,
  }) : super(
          canHandle: (command) =>
              command is RPCCommand<RPCAddServiceCommandData>,
          handle: (command) async {
            /*  _showNotification(
              context: context,
              ref: ref,
              command: command,
            );*/

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

            final result = await Sheets.showAppHeightNineSheet<
                Result<TransactionConfirmation, TransactionError>>(
              context: context,
              ref: ref,
              widget: TransactionConfirmationForm(newCommand),
            );

            return result?.map(
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

  static Future<void> _showNotification({
    required BuildContext context,
    required WidgetRef ref,
    required RPCCommand<RPCAddServiceCommandData> command,
  }) async {
    final message =
        AppLocalization.of(context)!.addServiceCommandReceivedNotification;

    NotificationsUtil.showNotification(
      title: 'Archethic',
      body: message.replaceAll(
        '%1',
        command.origin.name,
      ),
    );
  }
}
