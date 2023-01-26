import 'dart:async';
import 'dart:developer';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/domain/service/commands/sign_transaction.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/ui/themes/themes.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/command_receiver/command_handler.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/util/confirmations/transaction_sender.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionConfirmationForm extends ConsumerWidget {
  const TransactionConfirmationForm(this.command, {super.key});

  final SignTransactionCommand command;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return TapOutsideUnfocus(
      child: SafeArea(
        minimum: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.035,
        ),
        child: Column(
          children: <Widget>[
            SheetHeader(
              title: localizations.transactionConfirmationFormHeader,
            ),
            Expanded(
              child: ArchethicScrollbar(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 15,
                    right: 15,
                    bottom: bottom + 80,
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        localizations
                            .transactionSignatureCommandReceivedNotification
                            .replaceAll('%1', command.source)
                            .replaceAll('%2', command.accountName),
                        style: theme.textStyleSize14W600Primary,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    AppButtonTiny(
                      AppButtonTinyType.primary,
                      localizations.cancel,
                      Dimens.buttonBottomDimens,
                      onPressed: () {
                        Navigator.of(context).pop(
                          const Result.failure(TransactionError.userRejected()),
                        );
                      },
                    ),
                    AppButtonTiny(
                      AppButtonTinyType.primary,
                      localizations.send,
                      Dimens.buttonBottomDimens,
                      onPressed: () async {
                        ShowSendingAnimation.build(
                          context,
                          theme,
                        );

                        final result = await _sendTransaction(
                          context: context,
                          ref: ref,
                          command: command,
                        );
                        Navigator.of(context).pop(); // Hide SendingAnimation
                        Navigator.of(context).pop(result);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Result<TransactionConfirmation, TransactionError>> _sendTransaction({
    required BuildContext context,
    required WidgetRef ref,
    required SignTransactionCommand command,
  }) async {
    final theme = ref.read(ThemeProviders.selectedTheme);
    const logName = 'SignTransactionHandler';

    final operationCompleter =
        Completer<Result<TransactionConfirmation, TransactionError>>();

    void _fail(TransactionError error) {
      _showSendFailed(context, ref, theme, error);
      operationCompleter.complete(
        Result.failure(error),
      );
    }

    final networkSettings = ref.watch(
      SettingsProviders.settings.select((settings) => settings.network),
    );
    final transactionSender = ArchethicTransactionSender(
      phoenixHttpEndpoint: networkSettings.getPhoenixHttpLink(),
      websocketEndpoint: networkSettings.getWebsocketUri(),
    );

    final apiService = sl.get<archethic.ApiService>();

    final transaction = await command.toArchethicTransaction(
      ref,
      apiService,
    );

    if (transaction == null) {
      const error = TransactionError.invalidTransaction();
      _showSendFailed(
        context,
        ref,
        theme,
        error,
      );
      return const Result.failure(error);
    }

    try {
      // ignore: cascade_invocations
      transactionSender.send(
        transaction: transaction,
        onConfirmation: (confirmation) async {
          _showSendProgress(context, ref, theme, confirmation);
          if (confirmation.isFullyConfirmed) {
            log('Final confirmation received : $confirmation', name: logName);
            await ref
                .read(AccountProviders.selectedAccount.notifier)
                .refreshAll();
            operationCompleter.complete(
              Result.success(confirmation),
            );

            return;
          }

          log('Confirmation received : $confirmation', name: logName);
        },
        onError: (error) async {
          log('Transaction error received', name: logName, error: error);
          _fail(error);
        },
      );
    } catch (e) {
      _fail(const TransactionError.other());
    }

    return operationCompleter.future;
  }

  void _showSendProgress(
    BuildContext context,
    WidgetRef ref,
    BaseTheme theme,
    TransactionConfirmation event,
  ) {
    UIUtil.showSnackbar(
      event.nbConfirmations == 1
          ? AppLocalization.of(context)!
              .transactionConfirmed1
              .replaceAll('%1', event.nbConfirmations.toString())
              .replaceAll('%2', event.maxConfirmations.toString())
          : AppLocalization.of(context)!
              .transactionConfirmed
              .replaceAll('%1', event.nbConfirmations.toString())
              .replaceAll('%2', event.maxConfirmations.toString()),
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
      duration: const Duration(milliseconds: 5000),
    );
  }

  void _showSendFailed(
    BuildContext context,
    WidgetRef ref,
    BaseTheme theme,
    TransactionError error,
  ) {
    UIUtil.showSnackbar(
      error.localizedMessage(AppLocalization.of(context)!),
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
      duration: const Duration(seconds: 5),
    );
  }
}

extension TransactionErrorLocalizedExt on TransactionError {
  String localizedMessage(AppLocalization localization) => map(
        timeout: (_) => localization.transactionTimeOut,
        connectivity: (_) => localization.connectivityWarningDesc,
        consensusNotReached: (_) => localization.consensusNotReached,
        invalidTransaction: (_) => localization.invalidTransaction,
        invalidConfirmation: (_) => localization.notEnoughConfirmations,
        insufficientFunds: (_) => localization.insufficientBalance.replaceAll(
          '%1',
          AccountBalance.cryptoCurrencyLabel,
        ),
        userRejected: (_) => localization.userCancelledOperation,
        unknownAccount: (error) => localization.unknownAccount.replaceAll(
          '%1',
          error.accountName,
        ),
        other: (_) => localization.genericError,
      );
}
