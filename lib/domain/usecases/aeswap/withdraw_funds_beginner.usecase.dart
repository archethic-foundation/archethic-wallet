/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/application/step.dart';
import 'package:aewallet/domain/models/step.dart';
import 'package:aewallet/domain/repositories/transaction_remote.dart';
import 'package:aewallet/model/blockchain/keychain_secured_infos.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/modules/aeswap/application/contracts/archethic_contract.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_notification.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/util/notification_service/task_notification_service.dart'
    as ns;
import 'package:aewallet/ui/views/rpc_command_receiver/rpc_failure_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter_gen/gen_l10n/localizations.dart';

class WithdrawFundsBeginnerCase with aedappfm.TransactionMixin {
  WithdrawFundsBeginnerCase({
    required this.apiService,
    required this.notificationService,
    required this.verifiedTokensRepository,
    required this.transactionRepository,
    required this.keychainSecuredInfos,
    required this.selectedAccount,
  });

  final archethic.ApiService apiService;
  final ns.TaskNotificationService<DexNotification, aedappfm.Failure>
      notificationService;
  final aedappfm.VerifiedTokensRepositoryInterface verifiedTokensRepository;
  final TransactionRemoteRepositoryInterface transactionRepository;
  final KeychainSecuredInfos keychainSecuredInfos;
  final Account selectedAccount;

  Future<({double? amountReward, double? amountTokenUCOSwapped})> run(
    AppLocalizations localizations,
    String farmGenesisAddress,
    double lpAmount,
    String poolGenesisAddress,
    String aeETHAddress,
    String lpTokenAddress,
    String depositId,
    int currentStepIndex,
    StepsNotifier stepsNotifier,
    Map<String, dynamic>? snapshot,
  ) async {
    double? amountTokenUCOSwapped;

    var currentStep = currentStepIndex;

    final archethicContract = ArchethicContract(
      apiService: apiService,
      verifiedTokensRepository: verifiedTokensRepository,
    );

    const ucoToken = DexToken(address: kUCOAddress, symbol: kUCOAddress);
    final aeETHToken = DexToken(address: aeETHAddress, symbol: 'aeETH');

    double amountReward = snapshot?['amountReward'] ?? 0.0;
    double amountWithdrawLocked = snapshot?['amountWithdrawLocked'] ?? 0.0;

    double amountTokenUCO = snapshot?['amountTokenUCO'] ?? 0.0;
    double amountTokenETH = snapshot?['amountTokenETH'] ?? 0.0;
    double amountLPTokenBurnt = snapshot?['amountLPTokenBurnt'] ?? 0.0;

    try {
      if (currentStep == 0) {
        archethic.Transaction? transactionWithdraw;
        // WITHDRAW LOCKED LP
        final transactionWithdrawMap =
            await archethicContract.getFarmLockWithdrawTx(
          farmGenesisAddress,
          lpAmount,
          depositId,
        );

        transactionWithdrawMap.map(
          success: (success) {
            transactionWithdraw = success;
          },
          failure: (failure) {
            throw failure;
          },
        );

        final transationSignedRaw =
            await transactionRepository.buildTransactionRaw(
          keychainSecuredInfos,
          transactionWithdraw!,
          selectedAccount.genesisAddress,
          selectedAccount.name,
        );

        await transactionRepository.sendSignedRaw(
          transaction: transationSignedRaw,
        );

        await aedappfm.PeriodicFuture.periodic<bool>(
          () => isSCCallExecuted(
            apiService,
            farmGenesisAddress,
            transationSignedRaw.address!.address!,
          ),
          sleepDuration: const Duration(seconds: 3),
          until: (depositOk) => depositOk == true,
          timeout: const Duration(minutes: 1),
        );

        final amounts = await aedappfm.PeriodicFuture.periodic<List<double>>(
          () => Future.wait([
            getAmountFromTxInput(
              transationSignedRaw.address!.address!,
              kUCOAddress,
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
            return amounts[1] > 0;
          },
          timeout: const Duration(minutes: 1),
        );

        amountReward = amounts[0];
        amountWithdrawLocked = amounts[1];
        final withdrawLockedSnapshot = {
          'amountReward': amountReward,
          'amountWithdrawLocked': amountWithdrawLocked,
        };

        stepsNotifier.updateStepStatus(
          currentStep,
          StepStatus.completed,
          snapshot: withdrawLockedSnapshot,
        );
        currentStep++;
      }

      // WITHDRAW LP FROM POOL
      if (currentStep == 1) {
        archethic.Transaction? transactionRemoveLiquidity;

        stepsNotifier.updateStepStatus(currentStep, StepStatus.inProgress);

        final transactionRemoveLiquiditylMap =
            await archethicContract.getRemoveLiquidityTx(
          lpTokenAddress,
          lpAmount,
          poolGenesisAddress,
        );

        transactionRemoveLiquiditylMap.map(
          success: (success) {
            transactionRemoveLiquidity = success;
          },
          failure: (failure) {
            throw failure;
          },
        );

        final transationSignedRaw =
            await transactionRepository.buildTransactionRaw(
          keychainSecuredInfos,
          transactionRemoveLiquidity!,
          selectedAccount.genesisAddress,
          selectedAccount.name,
        );

        await transactionRepository.sendSignedRaw(
          transaction: transationSignedRaw,
        );

        final amounts = await aedappfm.PeriodicFuture.periodic<List<double>>(
          () => Future.wait([
            getAmountFromTxInput(
              transationSignedRaw.address!.address!,
              ucoToken.address,
              apiService,
            ),
            getAmountFromTxInput(
              transationSignedRaw.address!.address!,
              aeETHToken.address,
              apiService,
            ),
            getAmountFromTx(
              apiService,
              transationSignedRaw.address!.address!,
              false,
              '00000000000000000000000000000000000000000000000000000000000000000000',
            ),
          ]),
          sleepDuration: const Duration(seconds: 3),
          until: (amounts) {
            amountTokenUCO = amounts[0];
            amountTokenETH = amounts[1];
            amountLPTokenBurnt = amounts[2];
            return amountTokenUCO > 0 &&
                amountTokenETH > 0 &&
                amountLPTokenBurnt > 0;
          },
          timeout: const Duration(minutes: 1),
        );

        amountTokenUCO = amounts[0];
        amountTokenETH = amounts[1];
        amountLPTokenBurnt = amounts[2];

        final withdrawLiquiditySnapshot = {
          'amountTokenUCO': amountTokenUCO,
          'amountTokenETH': amountTokenETH,
          'amountLPTokenBurnt': amountLPTokenBurnt,
        };

        stepsNotifier.updateStepStatus(
          currentStep,
          StepStatus.completed,
          snapshot: withdrawLiquiditySnapshot,
        );
        currentStep++;
      }

      // SWAP ETH TO UCO
      if (currentStep == 2) {
        stepsNotifier.updateStepStatus(currentStep, StepStatus.inProgress);
        final outputAmount = await _getOutputAmount(
          archethicContract,
          aeETHToken,
          amountTokenETH,
          poolGenesisAddress,
        );

        final transactionSwap = await _getTransaction(
          () => archethicContract.getSwapTx(
            aeETHToken,
            amountTokenETH,
            poolGenesisAddress,
            0.5,
            outputAmount,
          ),
        );

        amountTokenUCOSwapped = await _sendTransactionAndGetAmount(
          transactionSwap,
          ucoToken.address,
        );

        stepsNotifier.updateStepStatus(
          currentStep,
          StepStatus.completed,
        );
      }
    } on archethic.TransactionError catch (error) {
      stepsNotifier.updateStepStatus(
        currentStep,
        StepStatus.failed,
        failure: aedappfm.Failure.other(
          cause: error.localizedMessage(localizations),
        ),
      );

      throw aedappfm.Failure.other(
        cause: error.localizedMessage(localizations),
      );
    } catch (e) {
      stepsNotifier.updateStepStatus(
        currentStep,
        StepStatus.failed,
        failure: aedappfm.Failure.fromError(e),
      );
      throw aedappfm.Failure.fromError(e);
    }
    return (
      amountReward: amountReward,
      amountTokenUCOSwapped: amountTokenUCOSwapped
    );
  }

  Future<double> _getOutputAmount(
    ArchethicContract archethicContract,
    DexToken ucoToken,
    double amount,
    String poolGenesisAddress,
  ) async {
    final outputAmountMap = await archethicContract.getOutputAmount(
      ucoToken,
      amount,
      poolGenesisAddress,
    );

    return outputAmountMap.map(
      success: (success) {
        if (success <= 0) {
          throw const aedappfm.Failure.other(cause: 'Error outputAmount');
        }
        return success;
      },
      failure: (failure) => throw failure,
    );
  }

  Future<archethic.Transaction> _getTransaction(
    Future<aedappfm.Result<archethic.Transaction, aedappfm.Failure>> Function()
        transactionFunction,
  ) async {
    final transactionMap = await transactionFunction();
    return transactionMap.map(
      success: (success) => success,
      failure: (failure) => throw failure,
    );
  }

  Future<double> _sendTransactionAndGetAmount(
    archethic.Transaction transaction,
    String tokenAddress,
  ) async {
    final transationSignedRaw = await transactionRepository.buildTransactionRaw(
      keychainSecuredInfos,
      transaction,
      selectedAccount.genesisAddress,
      selectedAccount.name,
    );

    final confirmation = await transactionRepository.sendSignedRaw(
      transaction: transationSignedRaw,
    );

    if (confirmation == null) return 0.0;

    return aedappfm.PeriodicFuture.periodic<double>(
      () => getAmountFromTxInput(
        transationSignedRaw.address!.address!,
        tokenAddress,
        apiService,
      ),
      sleepDuration: const Duration(seconds: 3),
      until: (amount) => amount > 0,
      timeout: const Duration(minutes: 1),
    );
  }
}
