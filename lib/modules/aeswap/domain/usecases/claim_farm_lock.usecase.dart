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
import 'package:aewallet/ui/views/aeswap_farm_lock_claim/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const logName = 'ClaimFarmLockCase';

class ClaimFarmLockCase with aedappfm.TransactionMixin {
  Future<void> run(
    TransactionRemoteRepositoryInterface transactionRepository,
    WidgetRef ref,
    BuildContext context,
    ns.TaskNotificationService<DexNotification, aedappfm.Failure>
        notificationService,
    String farmGenesisAddress,
    String depositId,
    DexToken rewardToken,
  ) async {
    final operationId = const Uuid().v4();
    final archethicContract = ArchethicContract();
    final farmClaimLockNotifier =
        ref.read(FarmLockClaimFormProvider.farmLockClaimForm.notifier);

    archethic.Transaction? transactionClaim;
    farmClaimLockNotifier.setFinalAmount(null);

    try {
      final transactionClaimMap = await archethicContract.getFarmLockClaimTx(
        farmGenesisAddress,
        depositId,
      );

      transactionClaimMap.map(
        success: (success) {
          transactionClaim = success;
          farmClaimLockNotifier.setTransactionClaimFarmLock(
            transactionClaim!,
          );
        },
        failure: (failure) {
          farmClaimLockNotifier
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
        transactionClaim!,
        selectedAccount!.lastAddress!,
        selectedAccount.name,
      );

      farmClaimLockNotifier.setTransactionClaimFarmLock(
        transationSignedRaw,
      );

      await transactionRepository.sendSignedRaw(
        transactionSignedRaw: transationSignedRaw,
        onConfirmation: (sender, confirmation) async {
          if (archethic.TransactionConfirmation.isEnoughConfirmations(
            confirmation.nbConfirmations,
            confirmation.maxConfirmations,
            TransactionValidationRatios.claimFarmLock,
          )) {
            sender.close();

            farmClaimLockNotifier
              ..setResumeProcess(false)
              ..setProcessInProgress(false)
              ..setFarmLockClaimOk(true);

            notificationService.start(
              operationId,
              DexNotification.addLiquidity(
                txAddress: transationSignedRaw.address!.address,
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

            final amount = await aedappfm.PeriodicFuture.periodic<double>(
              () => getAmountFromTxInput(
                transationSignedRaw.address!.address!,
                rewardToken.address,
                aedappfm.sl.get<archethic.ApiService>(),
              ),
              sleepDuration: const Duration(seconds: 3),
              until: (amount) => amount > 0,
              timeout: const Duration(minutes: 1),
            );

            farmClaimLockNotifier.setFinalAmount(amount);

            notificationService.succeed(
              operationId,
              DexNotification.claimFarmLock(
                txAddress: transationSignedRaw.address!.address,
                amount: amount,
                rewardToken: rewardToken,
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
        farmClaimLockNotifier.setFailure(e);
        throw aedappfm.Failure.fromError(e);
      }
      farmClaimLockNotifier.setFailure(
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
        return AppLocalizations.of(context)!.claimLockProcessStep1;
      case 2:
        return AppLocalizations.of(context)!.claimLockProcessStep2;
      case 3:
        return AppLocalizations.of(context)!.claimLockProcessStep3;
      default:
        return AppLocalizations.of(context)!.claimLockProcessStep0;
    }
  }
}
