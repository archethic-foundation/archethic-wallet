import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/failure.dart';
import 'package:aewallet/domain/rpc/commands/send_transaction.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/send_transaction/layouts/sign_transaction_confirmation_form.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/notifications_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendTransactionHandler extends CommandHandler {
  SendTransactionHandler({
    required BuildContext context,
    required WidgetRef ref,
  }) : super(
          canHandle: (command) =>
              command is RPCCommand<RPCSendTransactionCommandData>,
          handle: (command) async {
            command as RPCCommand<RPCSendTransactionCommandData>;
            _showNotification(
              context: context,
              ref: ref,
              command: command,
            );
            final result = await Sheets.showAppHeightNineSheet<
                Result<TransactionConfirmation, TransactionError>>(
              context: context,
              ref: ref,
              widget: TransactionConfirmationForm(command),
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
    required RPCCommand<RPCSendTransactionCommandData> command,
  }) async {
    final message = AppLocalization.of(context)!
        .transactionSignatureCommandReceivedNotification;

    NotificationsUtil.showNotification(
      title: 'Archethic',
      body: message.replaceAll(
        '%1',
        command.origin.name,
      ),
    );
  }
}
