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
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class DepositFarmLockCase with aedappfm.TransactionMixin {
  Future<void> run(
    TransactionRemoteRepositoryInterface transactionRepository,
    WidgetRef ref,
    AppLocalizations localizations,
    ns.TaskNotificationService<DexNotification, aedappfm.Failure>
        notificationService,
    String farmGenesisAddress,
    String lpTokenAddress,
    double amount,
    String farmAddress,
    bool isUCO,
    FarmLockDepositDurationType durationType,
    String level,
  ) async {
    final operationId = const Uuid().v4();
    final archethicContract = ArchethicContract();
    final farmDepositNotifier =
        ref.read(FarmLockDepositFormProvider.farmLockDepositForm.notifier);

    archethic.Transaction? transactionDeposit;
    farmDepositNotifier.setFinalAmount(null);

    try {
      final transactionDepositMap =
          await archethicContract.getFarmLockDepositTx(
        farmGenesisAddress,
        lpTokenAddress,
        amount,
        durationType,
        level,
      );

      transactionDepositMap.map(
        success: (success) {
          transactionDeposit = success;
          farmDepositNotifier.setTransactionFarmLockDeposit(
            transactionDeposit!,
          );
        },
        failure: (failure) {
          farmDepositNotifier
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
        transactionDeposit!,
        selectedAccount!.lastAddress!,
        selectedAccount.name,
      );

      farmDepositNotifier.setTransactionFarmLockDeposit(transationSignedRaw);

      await transactionRepository.sendSignedRaw(
        transactionSignedRaw: transationSignedRaw,
        onConfirmation: (sender, confirmation) async {
          if (archethic.TransactionConfirmation.isEnoughConfirmations(
            confirmation.nbConfirmations,
            confirmation.maxConfirmations,
            TransactionValidationRatios.depositFarmLock,
          )) {
            sender.close();

            farmDepositNotifier
              ..setResumeProcess(false)
              ..setProcessInProgress(false)
              ..setFarmLockDepositOk(true);

            notificationService.start(
              operationId,
              DexNotification.depositFarmLock(
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

            farmDepositNotifier.setFinalAmount(amount);

            notificationService.succeed(
              operationId,
              DexNotification.depositFarmLock(
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
      if (e is aedappfm.Failure) {
        farmDepositNotifier.setFailure(e);
        throw aedappfm.Failure.fromError(e);
      }
      farmDepositNotifier.setFailure(
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

  Future<double> estimateFees(
    String farmGenesisAddress,
    String lpTokenAddress,
    double amount,
    FarmLockDepositDurationType durationType,
    String level,
  ) async {
    final archethicContract = ArchethicContract();
    archethic.Transaction? transactionDeposit;

    try {
      final transactionDepositMap =
          await archethicContract.getFarmLockDepositTx(
        farmGenesisAddress,
        lpTokenAddress,
        amount,
        durationType,
        level,
      );

      transactionDepositMap.map(
        success: (success) {
          transactionDeposit = success;
          // Add fake signature and address to allow estimation by node
          transactionDeposit = transactionDeposit!.copyWith(
            address: const archethic.Address(
              address:
                  '00000000000000000000000000000000000000000000000000000000000000000000',
            ),
            previousPublicKey:
                '00000000000000000000000000000000000000000000000000000000000000000000',
          );
        },
        failure: (failure) {
          return 0.0;
        },
      );
    } catch (e) {
      return 0.0;
    }

    final fees = await calculateFees(
      transactionDeposit!,
      aedappfm.sl.get<archethic.ApiService>(),
    );
    return fees;
  }

  String getAEStepLabel(
    AppLocalizations localizations,
    int step,
  ) {
    switch (step) {
      case 1:
        return localizations.depositFarmLockProcessStep1;
      case 2:
        return localizations.depositFarmLockProcessStep2;
      case 3:
        return localizations.depositFarmLockProcessStep3;
      default:
        return localizations.depositFarmLockProcessStep0;
    }
  }
}
