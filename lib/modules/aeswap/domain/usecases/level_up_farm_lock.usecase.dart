/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/domain/repositories/transaction_remote.dart';
import 'package:aewallet/domain/repositories/transaction_validation_ratios.dart';
import 'package:aewallet/modules/aeswap/application/contracts/archethic_contract.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_notification.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/farm_lock_duration_type.dart';
import 'package:aewallet/modules/aeswap/util/notification_service/task_notification_service.dart'
    as ns;
import 'package:aewallet/modules/aeswap/util/string_util.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_level_up/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const logName = 'LevelUpFarmLockCase';

class LevelUpFarmLockCase with aedappfm.TransactionMixin {
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
    String farmAddress,
    bool isUCO,
    FarmLockDepositDurationType durationType,
    String level,
  ) async {
    final operationId = const Uuid().v4();
    final archethicContract = ArchethicContract();
    final farmLevelUpNotifier =
        ref.read(FarmLockLevelUpFormProvider.farmLockLevelUpForm.notifier);

    archethic.Transaction? transactionLevelUp;
    farmLevelUpNotifier.setFinalAmount(null);

    try {
      final transactionLevelUpMap = await archethicContract.getFarmLockRelockTx(
        farmGenesisAddress,
        lpTokenAddress,
        amount,
        depositId,
        durationType,
        level,
      );

      transactionLevelUpMap.map(
        success: (success) {
          transactionLevelUp = success;
          farmLevelUpNotifier.setTransactionFarmLockLevelUp(
            transactionLevelUp!,
          );
        },
        failure: (failure) {
          farmLevelUpNotifier
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
        transactionLevelUp!,
        selectedAccount!.lastAddress!,
        selectedAccount.name,
      );

      farmLevelUpNotifier.setTransactionFarmLockLevelUp(transationSignedRaw);

      await transactionRepository.sendSignedRaw(
        transactionSignedRaw: transationSignedRaw,
        onConfirmation: (sender, confirmation) async {
          if (archethic.TransactionConfirmation.isEnoughConfirmations(
            confirmation.nbConfirmations,
            confirmation.maxConfirmations,
            TransactionValidationRatios.levelUpFarmLock,
          )) {
            sender.close();

            farmLevelUpNotifier
              ..setResumeProcess(false)
              ..setProcessInProgress(false)
              ..setFarmLockLevelUpOk(true);

            notificationService.start(
              operationId,
              DexNotification.levelUpFarmLock(
                txAddress: transationSignedRaw.address!.address,
                farmAddress: farmAddress,
                isUCO: isUCO,
              ),
            );

            await aedappfm.PeriodicFuture.periodic<bool>(
              () => isSCCallExecuted(
                farmAddress,
                transationSignedRaw.address!.address!,
              ),
              sleepDuration: const Duration(seconds: 3),
              until: (depositOk) => depositOk == true,
              timeout: const Duration(minutes: 1),
            );

            notificationService.succeed(
              operationId,
              DexNotification.levelUpFarmLock(
                txAddress: transationSignedRaw.address!.address,
                amount: amount,
                farmAddress: farmAddress,
                isUCO: isUCO,
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
      aedappfm.sl.get<aedappfm.LogManager>().log(
            'TransactionFarmLevelUp sendTx failed $e',
            level: aedappfm.LogLevel.error,
            name: 'aedappfm.TransactionMixin - sendTransactions',
          );

      farmLevelUpNotifier.setFailure(
        e is aedappfm.Timeout
            ? e
            : aedappfm.Failure.other(
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
        return AppLocalizations.of(context)!.levelUpFarmLockProcessStep1;
      case 2:
        return AppLocalizations.of(context)!.levelUpFarmLockProcessStep2;
      case 3:
        return AppLocalizations.of(context)!.levelUpFarmLockProcessStep3;
      default:
        return AppLocalizations.of(context)!.levelUpFarmLockProcessStep0;
    }
  }
}
