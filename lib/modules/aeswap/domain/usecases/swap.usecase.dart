/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/domain/repositories/transaction_remote.dart';
import 'package:aewallet/domain/repositories/transaction_validation_ratios.dart';
import 'package:aewallet/modules/aeswap/application/balance.dart';
import 'package:aewallet/modules/aeswap/application/contracts/archethic_contract.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_notification.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/util/notification_service/task_notification_service.dart'
    as ns;
import 'package:aewallet/modules/aeswap/util/string_util.dart';
import 'package:aewallet/ui/views/aeswap_swap/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const logName = 'SwapCase';

class SwapCase with aedappfm.TransactionMixin {
  Future<void> run(
    TransactionRemoteRepositoryInterface transactionRepository,
    WidgetRef ref,
    BuildContext context,
    ns.TaskNotificationService<DexNotification, aedappfm.Failure>
        notificationService,
    String poolGenesisAddress,
    DexToken tokenToSwap,
    DexToken tokenSwapped,
    double tokenToSwapAmount,
    double slippage,
  ) async {
    final operationId = const Uuid().v4();
    final archethicContract = ArchethicContract();
    final swapNotifier = ref.read(SwapFormProvider.swapForm.notifier);

    archethic.Transaction? transactionSwap;
    swapNotifier.setFinalAmount(null);

    var outputAmount = 0.0;
    try {
      final outputAmountMap = await archethicContract.getOutputAmount(
        tokenToSwap,
        tokenToSwapAmount,
        poolGenesisAddress,
      );

      outputAmountMap.map(
        success: (success) {
          outputAmount = success;

          if (outputAmount <= 0) {
            throw const aedappfm.Failure.other(
              cause: 'Error outputAmount',
            );
          }
        },
        failure: (failure) {
          swapNotifier
            ..setFailure(failure)
            ..setCurrentStep(4)
            ..setProcessInProgress(false);
          throw failure;
        },
      );
    } catch (e) {
      throw aedappfm.Failure.fromError(e);
    }

    try {
      final transactionSwapMap = await archethicContract.getSwapTx(
        tokenToSwap,
        tokenToSwapAmount,
        poolGenesisAddress,
        slippage,
        outputAmount,
      );

      transactionSwapMap.map(
        success: (success) {
          transactionSwap = success;
          swapNotifier.setRecoveryTransactionSwap(
            transactionSwap,
          );
        },
        failure: (failure) {
          swapNotifier
            ..setFailure(failure)
            ..setProcessInProgress(false);
          throw failure;
        },
      );
    } catch (e) {
      throw aedappfm.Failure.fromError(e);
    }

    try {
      final keychainSecuredInfos = ref
          .read(sessionNotifierProvider)
          .loggedIn!
          .wallet
          .keychainSecuredInfos;

      final selectedAccount = await ref
          .read(
            AccountProviders.accounts.future,
          )
          .selectedAccount;

      final transationSignedRaw =
          await transactionRepository.buildTransactionRaw(
        keychainSecuredInfos,
        transactionSwap!,
        selectedAccount!.lastAddress!,
        selectedAccount.name,
      );

      await transactionRepository.sendSignedRaw(
        transactionSignedRaw: transationSignedRaw,
        onConfirmation: (sender, confirmation) async {
          if (archethic.TransactionConfirmation.isEnoughConfirmations(
            confirmation.nbConfirmations,
            confirmation.maxConfirmations,
            TransactionValidationRatios.swap,
          )) {
            sender.close();

            swapNotifier
              ..setResumeProcess(false)
              ..setProcessInProgress(false)
              ..setSwapOk(true);

            notificationService.start(
              operationId,
              DexNotification.swap(
                txAddress: transationSignedRaw.address!.address,
                tokenSwapped: tokenSwapped,
              ),
            );

            final amount = await aedappfm.PeriodicFuture.periodic<double>(
              () => getAmountFromTxInput(
                transationSignedRaw.address!.address!,
                tokenSwapped.address,
                aedappfm.sl.get<archethic.ApiService>(),
              ),
              sleepDuration: const Duration(seconds: 3),
              until: (amount) => amount > 0,
              timeout: const Duration(minutes: 1),
            );

            notificationService.succeed(
              operationId,
              DexNotification.swap(
                txAddress: transationSignedRaw.address!.address,
                tokenSwapped: tokenSwapped,
                amountSwapped: amount,
              ),
            );

            unawaited(() async {
              final accountSelected = ref.watch(
                AccountProviders.accounts.select(
                  (accounts) => accounts.valueOrNull?.selectedAccount,
                ),
              );
              final swap = ref.read(SwapFormProvider.swapForm);

              final apiService = aedappfm.sl.get<archethic.ApiService>();
              final balanceSwapped = await ref.read(
                getBalanceProvider(
                  accountSelected!.genesisAddress,
                  swap.tokenSwapped!.isUCO
                      ? 'UCO'
                      : swap.tokenSwapped!.address!,
                  apiService,
                ).future,
              );
              swapNotifier.setTokenSwappedBalance(balanceSwapped);

              final balanceToSwap = await ref.read(
                getBalanceProvider(
                  accountSelected.genesisAddress,
                  swap.tokenToSwap!.isUCO ? 'UCO' : swap.tokenToSwap!.address!,
                  apiService,
                ).future,
              );
              swapNotifier.setTokenToSwapBalance(balanceToSwap);
            }());
          }
        },
        onError: (sender, error) async {
          notificationService.failed(
            operationId,
            aedappfm.Failure.fromError(error.messageLabel),
          );
        },
      );
    } catch (e) {
      notificationService.failed(
        operationId,
        aedappfm.Failure.fromError(e),
      );

      if (e is aedappfm.Failure) {
        swapNotifier.setFailure(e);
        throw aedappfm.Failure.fromError(e);
      }
      swapNotifier.setFailure(
        aedappfm.Failure.other(
          cause: e.toString().replaceAll('Exception: ', '').capitalize(),
        ),
      );

      notificationService.failed(
        operationId,
        aedappfm.Failure.fromError(e),
      );
      throw aedappfm.Failure.fromError(e);
    }
  }

  String getAEStepLabel(
    AppLocalizations localizations,
    int step,
  ) {
    switch (step) {
      case 1:
        return localizations.swapProcessStep1;
      case 2:
        return localizations.swapProcessStep2;
      case 3:
        return localizations.swapProcessStep3;
      case 4:
        return localizations.swapProcessStep4;
      default:
        return localizations.swapProcessStep0;
    }
  }

  Future<double> estimateFees(
    String poolGenesisAddress,
    DexToken tokenToSwap,
    double tokenToSwapAmount,
    double slippage,
  ) async {
    final archethicContract = ArchethicContract();
    archethic.Transaction? transactionSwap;
    var outputAmount = 0.0;

    try {
      final outputAmountMap = await archethicContract.getOutputAmount(
        tokenToSwap,
        tokenToSwapAmount,
        poolGenesisAddress,
      );

      outputAmountMap.map(
        success: (success) {
          outputAmount = success;

          if (outputAmount <= 0) {
            return 0.0;
          }
        },
        failure: (failure) {
          return 0.0;
        },
      );
    } catch (e) {
      return 0.0;
    }

    try {
      final transactionSwapMap = await archethicContract.getSwapTx(
        tokenToSwap,
        tokenToSwapAmount,
        poolGenesisAddress,
        slippage,
        outputAmount,
      );

      return transactionSwapMap.map(
        success: (success) async {
          transactionSwap = success;
          // Add fake signature and address to allow estimation by node
          transactionSwap = transactionSwap!.copyWith(
            address: const archethic.Address(
              address:
                  '00000000000000000000000000000000000000000000000000000000000000000000',
            ),
            previousPublicKey:
                '00000000000000000000000000000000000000000000000000000000000000000000',
          );
          final fees = await calculateFees(
            transactionSwap!,
            aedappfm.sl.get<archethic.ApiService>(),
            slippage: 1.1,
          );
          return fees;
        },
        failure: (failure) {
          return 0.0;
        },
      );
    } catch (e) {
      return 0.0;
    }
  }
}
