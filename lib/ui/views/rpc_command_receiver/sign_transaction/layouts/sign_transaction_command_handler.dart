import 'dart:async';

import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/domain/service/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/service/rpc/commands/send_transaction.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/sign_transaction/layouts/sign_transaction_confirmation_form.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/notifications_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RPCSignTransactionCommandHandler extends ConsumerWidget {
  RPCSignTransactionCommandHandler({
    super.key,
    required this.child,
  });

  static const logName = 'SignTransactionHandler';
  final Widget child;

  final commandDispatcher = sl.get<
      CommandDispatcher<RPCSendTransactionCommand, SendTransactionResult>>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    commandDispatcher.handler = (command) async {
      _showNotification(
        context: context,
        ref: ref,
        command: command,
      );
      return await Sheets.showAppHeightNineSheet(
            context: context,
            ref: ref,
            widget: TransactionConfirmationForm(command),
          ) ??
          const Result.failure(TransactionError.userRejected());
    };
    return child;
  }

  Future<void> _showNotification({
    required BuildContext context,
    required WidgetRef ref,
    required RPCSendTransactionCommand command,
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
