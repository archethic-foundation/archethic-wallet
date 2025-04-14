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
import 'package:aewallet/modules/aeswap/infrastructure/pool_factory.repository.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/farm_lock_duration_type.dart';
import 'package:aewallet/modules/aeswap/util/notification_service/task_notification_service.dart'
    as ns;
import 'package:aewallet/ui/views/rpc_command_receiver/rpc_failure_message.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:decimal/decimal.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:logging/logging.dart';

class AddFundsBeginnerCase with aedappfm.TransactionMixin {
  AddFundsBeginnerCase({
    required this.apiService,
    required this.notificationService,
    required this.verifiedTokensRepository,
    required this.transactionRepository,
    required this.keychainSecuredInfos,
    required this.selectedAccount,
    required this.blockchainTxVersion,
  });

  final archethic.ApiService apiService;
  final ns.TaskNotificationService<DexNotification, aedappfm.Failure>
      notificationService;
  final aedappfm.VerifiedTokensRepositoryInterface verifiedTokensRepository;
  final TransactionRemoteRepositoryInterface transactionRepository;
  final KeychainSecuredInfos keychainSecuredInfos;
  final Account selectedAccount;
  final int blockchainTxVersion;

  Future<double?> run(
    AppLocalizations localizations,
    String farmGenesisAddress,
    double ucoAmount,
    String poolGenesisAddress,
    String aeETHAddress,
    String lpTokenAddress,
    FarmLockDepositDurationType durationType,
    String level,
    int currentStepIndex,
    StepsNotifier stepsNotifier,
    Map<String, dynamic>? snapshot,
  ) async {
    double? lpLocked;

    var currentStep = currentStepIndex;

    final _logger = Logger('AddFundsBeginnerCase');

    final archethicContract = ArchethicContract(
      apiService: apiService,
      verifiedTokensRepository: verifiedTokensRepository,
      blockchainTxVersion: blockchainTxVersion,
    );

    const ucoToken = DexToken(address: kUCOAddress, symbol: kUCOAddress);
    final aeETHToken = DexToken(address: aeETHAddress, symbol: 'aeETH');
    final ucoAmountHalf =
        (Decimal.parse(ucoAmount.toString()) / Decimal.fromInt(2)).toDouble();

    double aeETHAmount = snapshot?['aeETHAmount'] ?? 0.0;

    try {
      if (currentStep == 0) {
        // SWAP
        final outputAmount = await _getOutputAmount(
          archethicContract,
          ucoToken,
          ucoAmountHalf,
          poolGenesisAddress,
        );

        final transactionSwap = await _getTransaction(
          () => archethicContract.getSwapTx(
            ucoToken,
            ucoAmountHalf,
            poolGenesisAddress,
            0.5,
            outputAmount,
          ),
        );

        aeETHAmount = await _sendTransactionAndGetAmount(
          transactionSwap,
          aeETHAddress,
        );

        final swapSnapshot = {
          'aeETHAmount': aeETHAmount,
        };

        stepsNotifier.updateStepStatus(
          currentStep,
          StepStatus.completed,
          snapshot: swapSnapshot,
        );
        currentStep++;
      }

      var lpTokenAmount = snapshot?['lpTokenAmount'] ?? 0.0;
      var addLiquidityUCOAmount = ucoAmountHalf;
      var addLiquidityETHAmount = aeETHAmount;

      if (currentStep == 1) {
        stepsNotifier.updateStepStatus(currentStep, StepStatus.inProgress);
        // Pool ratio's updated - Get new value
        var equivalentAmountETH = 0.0;
        var equivalentAmountUCO = 0.0;

        final equivalentAmountETHResult = await PoolFactoryRepositoryImpl(
          poolGenesisAddress,
          apiService,
        ).getEquivalentAmount(kUCOAddress, ucoAmountHalf);
        equivalentAmountETHResult.map(
          success: (success) {
            if (success != null) {
              equivalentAmountETH = success;
            }
          },
          failure: (_) {},
        );

        if (equivalentAmountETH > aeETHAmount) {
          final equivalentAmountUCOResult = await PoolFactoryRepositoryImpl(
            poolGenesisAddress,
            apiService,
          ).getEquivalentAmount(aeETHToken.address, aeETHAmount);
          equivalentAmountUCOResult.map(
            success: (success) {
              if (success != null) {
                equivalentAmountUCO = success;

                addLiquidityUCOAmount = equivalentAmountUCO;
                addLiquidityETHAmount = aeETHAmount;
              }
            },
            failure: (_) {},
          );
        } else {
          addLiquidityUCOAmount = ucoAmountHalf;
          addLiquidityETHAmount = equivalentAmountETH;
        }

        _logger
          ..fine(
            'equivalentAmountETH $equivalentAmountETH (swapped amount: $aeETHAmount) -> finalAmountETH : $addLiquidityETHAmount',
          )
          ..fine(
            'equivalentAmountUCO $equivalentAmountUCO (swapped amount: $ucoAmountHalf) -> finalAmountETH : $addLiquidityUCOAmount',
          );

        // ADD LIQUIDITY
        final transactionAddLiquidity = await _getTransaction(
          () => archethicContract.getAddLiquidityTx(
            ucoToken,
            addLiquidityUCOAmount,
            aeETHToken,
            addLiquidityETHAmount,
            poolGenesisAddress,
            0.5,
          ),
        );

        lpTokenAmount = await _sendTransactionAndGetAmount(
          transactionAddLiquidity,
          lpTokenAddress,
        );

        final addLiquiditySnapshot = {
          'lpTokenAmount': lpTokenAmount,
        };

        stepsNotifier.updateStepStatus(
          currentStep,
          StepStatus.completed,
          snapshot: addLiquiditySnapshot,
        );
        currentStep++;
      }

      if (currentStep == 2) {
        // DEPOSIT LP
        stepsNotifier.updateStepStatus(currentStep, StepStatus.inProgress);
        final transactionDeposit = await _getTransaction(
          () => archethicContract.getFarmLockDepositTx(
            farmGenesisAddress,
            lpTokenAddress,
            lpTokenAmount,
            durationType,
            level,
          ),
        );

        await _sendTransactionAndVerifyExecution(
          transactionDeposit,
          farmGenesisAddress,
        );
        stepsNotifier.updateStepStatus(currentStep, StepStatus.completed);

        lpLocked = lpTokenAmount;
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
    return lpLocked;
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
      timeout: const Duration(seconds: 70),
    );
  }

  Future<void> _sendTransactionAndVerifyExecution(
    archethic.Transaction transaction,
    String farmAddress,
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

    if (confirmation == null) return;

    await aedappfm.PeriodicFuture.periodic<bool>(
      () => isSCCallExecuted(
        apiService,
        farmAddress,
        transationSignedRaw.address!.address!,
      ),
      sleepDuration: const Duration(seconds: 3),
      until: (depositOk) => depositOk == true,
      timeout: const Duration(seconds: 70),
    );
  }
}
