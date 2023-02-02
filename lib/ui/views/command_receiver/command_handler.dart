import 'dart:async';
import 'dart:developer';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/domain/service/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/service/rpc/commands/sign_transaction.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/views/command_receiver/transaction_confirmation_form.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:aewallet/util/notifications_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignTransactionCommandHandler extends ConsumerWidget {
  SignTransactionCommandHandler({
    super.key,
    required this.child,
  });

  static const logName = 'SignTransactionHandler';
  final Widget child;

  final commandDispatcher = sl
      .get<CommandDispatcher<SignTransactionCommand, SignTransactionResult>>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    commandDispatcher.handler = (command) async {
      final account = await ref.read(
        AccountProviders.account(command.accountName).future,
      );

      if (account == null) {
        return Result.failure(
          TransactionError.unknownAccount(
            accountName: command.accountName,
          ),
        );
      }

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
    required SignTransactionCommand command,
  }) async {
    final message = AppLocalization.of(context)!
        .transactionSignatureCommandReceivedNotification;

    NotificationsUtil.showNotification(
      title: 'Archethic',
      body: message
          .replaceAll(
            '%1',
            command.source,
          )
          .replaceAll('%2', command.accountName),
    );
  }
}

extension SignTransactionCommandConversion on SignTransactionCommand {
  Future<archethic.Transaction?> toArchethicTransaction(
    WidgetRef ref,
    archethic.ApiService apiService,
  ) async {
    try {
      final wallet = ref.read(SessionProviders.session).loggedIn!.wallet;
      final keychain = wallet.keychainSecuredInfos.toKeychain();
      final account = wallet.appKeychain.accounts.firstWhere(
        (account) => account.name == accountName,
        orElse: () {
          throw const Failure.other();
          // throw Failure.unknownService();
        },
      );
      final serviceName = 'archethic-wallet-${Uri.encodeFull(accountName)}';

      final indexMap = await apiService.getTransactionIndex(
        [account.genesisAddress],
      );
      final accountIndex = indexMap[account.genesisAddress] ?? 0;
      final originPrivateKey = apiService.getOriginKey();
      final transaction = Transaction(type: type, data: data);

      final builtTransaction = keychain.buildTransaction(
        transaction,
        serviceName,
        accountIndex,
      );

      final signedTransaction = builtTransaction.originSign(originPrivateKey);
      return signedTransaction;
    } catch (e, stack) {
      log('Transaction creation failed', error: e, stackTrace: stack);
      return null;
    }
  }
}
