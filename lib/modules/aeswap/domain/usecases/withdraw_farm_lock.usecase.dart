/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/domain/repositories/transaction_remote.dart';
import 'package:aewallet/domain/repositories/transaction_validation_ratios.dart';
import 'package:aewallet/modules/aeswap/application/contracts/archethic_contract.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_notification.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/util/notification_service/task_notification_service.dart'
    as ns;
import 'package:aewallet/modules/aeswap/util/string_util.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_withdraw/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const logName = 'WithdrawFarmLockCase';

class WithdrawFarmLockCase with aedappfm.TransactionMixin {
  Future<void> run(
    TransactionRemoteRepositoryInterface transactionRepository,
    WidgetRef ref,
    BuildContext context,
    ns.TaskNotificationService<DexNotification, aedappfm.Failure>
        notificationService,
    String farmGenesisAddress,
    String lpTokenAddress,
    double amount,
    String depositId,
    DexToken rewardToken,
  ) async {
    final operationId = const Uuid().v4();

    final archethicContract = ArchethicContract();
    final farmLockWithdrawNotifier =
        ref.read(FarmLockWithdrawFormProvider.farmLockWithdrawForm.notifier);
    final farmLockWithdrawForm =
        ref.read(FarmLockWithdrawFormProvider.farmLockWithdrawForm);

    archethic.Transaction? transactionWithdraw;
    farmLockWithdrawNotifier
      ..setFinalAmountReward(null)
      ..setFinalAmountWithdraw(null);

    try {
      final transactionWithdrawMap =
          await archethicContract.getFarmLockWithdrawTx(
        farmGenesisAddress,
        amount,
        depositId,
      );

      transactionWithdrawMap.map(
        success: (success) {
          transactionWithdraw = success;
          farmLockWithdrawNotifier.setTransactionWithdrawFarmLock(
            transactionWithdraw!,
          );
        },
        failure: (failure) {
          farmLockWithdrawNotifier
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
        transactionWithdraw!,
        selectedAccount!.lastAddress!,
        selectedAccount.name,
      );

      farmLockWithdrawNotifier
          .setTransactionWithdrawFarmLock(transationSignedRaw);

      await transactionRepository.sendSignedRaw(
        transactionSignedRaw: transationSignedRaw,
        onConfirmation: (sender, confirmation) async {
          if (archethic.TransactionConfirmation.isEnoughConfirmations(
            confirmation.nbConfirmations,
            confirmation.maxConfirmations,
            TransactionValidationRatios.withdrawFarmLock,
          )) {
            sender.close();

            farmLockWithdrawNotifier
              ..setResumeProcess(false)
              ..setProcessInProgress(false)
              ..setFarmLockWithdrawOk(true);

            notificationService.start(
              operationId,
              DexNotification.withdrawFarmLock(
                txAddress: transationSignedRaw.address!.address,
                rewardToken: rewardToken,
                isFarmClose: farmLockWithdrawForm.isFarmClose,
              ),
            );

            await aedappfm.PeriodicFuture.periodic<bool>(
              () => isSCCallExecuted(
                farmGenesisAddress,
                transationSignedRaw.address!.address!,
              ),
              sleepDuration: const Duration(seconds: 3),
              until: (depositOk) => depositOk == true,
              timeout: const Duration(minutes: 1),
            );

            final apiService = aedappfm.sl.get<archethic.ApiService>();
            final amounts =
                await aedappfm.PeriodicFuture.periodic<List<double>>(
              () => Future.wait([
                getAmountFromTxInput(
                  transationSignedRaw.address!.address!,
                  rewardToken.address,
                  apiService,
                ),
                getAmountFromTxInput(
                  transationSignedRaw.address!.address!,
                  lpTokenAddress,
                  apiService,
                ),
              ]),
              sleepDuration: const Duration(seconds: 3),
              until: (amounts) {
                final amountWithdraw = amounts[1];
                return amountWithdraw > 0;
              },
              timeout: const Duration(minutes: 1),
            );

            final amountReward = amounts[0];
            final amountWithdraw = amounts[1];

            notificationService.succeed(
              operationId,
              DexNotification.withdrawFarmLock(
                txAddress: transationSignedRaw.address!.address,
                amountReward: amountReward,
                amountWithdraw: amountWithdraw,
                rewardToken: rewardToken,
                isFarmClose: farmLockWithdrawForm.isFarmClose,
              ),
            );
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
      if (e is aedappfm.Failure) {
        farmLockWithdrawNotifier.setFailure(e);
        throw aedappfm.Failure.fromError(e);
      }
      farmLockWithdrawNotifier.setFailure(
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
    BuildContext context,
    int step,
  ) {
    switch (step) {
      case 1:
        return AppLocalizations.of(context)!.withdrawFarmLockProcessStep1;
      case 2:
        return AppLocalizations.of(context)!.withdrawFarmLockProcessStep2;
      case 3:
        return AppLocalizations.of(context)!.withdrawFarmLockProcessStep3;
      default:
        return AppLocalizations.of(context)!.withdrawFarmLockProcessStep0;
    }
  }
}
