import 'dart:async';

import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/application/aeswap/usecases.dart';
import 'package:aewallet/application/airdrop/airdrop.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/step.dart';
import 'package:aewallet/domain/models/settings.dart';
import 'package:aewallet/domain/models/step.dart';
import 'package:aewallet/modules/aeswap/application/balance.dart';
import 'package:aewallet/modules/aeswap/application/session/provider.dart';
import 'package:aewallet/modules/aeswap/application/session/state.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pair.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/util/browser_util_desktop.dart';
import 'package:aewallet/ui/util/delayed_task.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_withdraw/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
class FarmLockWithdrawFormNotifier extends _$FarmLockWithdrawFormNotifier {
  FarmLockWithdrawFormNotifier();

  CancelableTask<double?>? _calculateFeesTask;

  @override
  FarmLockWithdrawFormState build() => const FarmLockWithdrawFormState();

  void setTransactionWithdrawFarmLock(
    archethic.Transaction transactionWithdrawFarmLock,
  ) {
    state = state.copyWith(
      transactionWithdrawFarmLock: transactionWithdrawFarmLock,
    );
  }

  void setDepositId(String depositId) {
    state = state.copyWith(depositId: depositId);
  }

  void setAmount(
    AppLocalizations localizations,
    double amount,
  ) {
    state = state.copyWith(
      failure: null,
      amount: amount,
    );

    if (state.amount > state.depositedAmount!) {
      setFailure(
        aedappfm.Failure.other(
          cause:
              localizations.farmLockWithdrawControlLPTokenAmountExceedDeposited,
        ),
      );
    }
    unawaited(_updateFees());
  }

  Future<void> _updateFees({
    Duration delay = const Duration(milliseconds: 800),
  }) async {
    state = state.copyWith(
      feeEstimation: const AsyncValue.loading(),
    );

    try {
      final fees = await _calculateFeesTaskCall(delay);

      state = state.copyWith(
        feeEstimation: AsyncValue.data(fees),
      );
    } on CanceledTask {
      return;
    }
  }

  Future<double> _calculateFeesTaskCall(
    Duration delay,
  ) async {
    if (state.amount <= 0) {
      return 0;
    }

    _calculateFeesTask?.cancel();
    _calculateFeesTask = CancelableTask<double?>(
      task: _calculateFees,
    );

    final fees = await _calculateFeesTask?.schedule(delay);
    return fees ?? 0;
  }

  Future<double> _calculateFees() async {
    var feeEstimation = 0.0;
    final earnUserLevel = ref.read(
      SettingsProviders.settings.select((settings) => settings.earnUserLevel),
    );

    if (earnUserLevel == EarnUserLevelType.advanced) {
      feeEstimation = await ref.read(withdrawFarmLockCaseProvider).estimateFees(
            state.farmAddress!,
            state.lpToken!.address,
            state.amount,
            state.depositId,
          );
    } else {
      var count = 0;
      final farmLock = ref.read(farmLockFormFarmLockProvider).value;
      if (farmLock != null) {
        farmLock.userInfos.forEach((depositId, userInfos) {
          if (userInfos.level == '0') {
            count++;
          }
        });
      }

      final environment = ref.read(environmentProvider);
      try {
        final results = await Future.wait([
          ref.read(withdrawFarmLockCaseProvider).estimateFees(
                state.farmAddress!,
                state.lpToken!.address,
                99999, // Default Value
                '1', // Default Value
              ),
          ref.read(removeLiquidityCaseProvider).estimateFees(
                state.poolAddress!,
                state.lpToken!.address,
                99999, // Default Value
              ),
          ref.read(swapCaseProvider).estimateFees(
                state.poolAddress!,
                DexToken(address: environment.aeETHAddress, symbol: 'aeETH'),
                state.amount,
                0,
              ),
        ]);

        final totalFees = (Decimal.parse(count.toString()) *
                    Decimal.parse(results[0].toString()))
                .toDouble() +
            results[1] +
            results[2];
        const slippage = 1.5;
        feeEstimation = totalFees * slippage;
      } catch (e) {
        return 0.0;
      }
    }
    return feeEstimation;
  }

  void setConfirmPrivacyPolicy(bool confirmPrivacyPolicy) {
    state = state.copyWith(
      confirmPrivacyPolicy: confirmPrivacyPolicy,
      failure: null,
    );
  }

  void setDepositedAmount(double? depositedAmount) {
    state = state.copyWith(depositedAmount: depositedAmount);
  }

  void setRewardAmount(double? rewardAmount) {
    state = state.copyWith(rewardAmount: rewardAmount);
  }

  void setAmountMax(AppLocalizations appLocalizations) {
    setAmount(appLocalizations, state.depositedAmount!);
  }

  void setPoolAddress(String poolAddress) {
    state = state.copyWith(poolAddress: poolAddress);
  }

  void setEndDate(DateTime endDate) {
    state = state.copyWith(endDate: endDate);
  }

  void setFarmAddress(String farmAddress) {
    state = state.copyWith(
      farmAddress: farmAddress,
    );
  }

  void setRewardToken(DexToken rewardToken) {
    state = state.copyWith(
      rewardToken: rewardToken,
    );
  }

  void setLpToken(DexToken lpToken) {
    state = state.copyWith(
      lpToken: lpToken,
    );
  }

  void setLPTokenPair(DexPair lpTokenPair) {
    state = state.copyWith(
      lpTokenPair: lpTokenPair,
    );
  }

  void setFailure(aedappfm.Failure? failure) {
    state = state.copyWith(
      failure: failure,
    );
  }

  void setFarmLockWithdrawOk(bool farmLockWithdrawOk) {
    state = state.copyWith(
      farmLockWithdrawOk: farmLockWithdrawOk,
    );
  }

  void setCurrentStep(int currentStep) {
    state = state.copyWith(currentStep: currentStep);
  }

  void setResumeProcess(bool resumeProcess) {
    state = state.copyWith(resumeProcess: resumeProcess);
  }

  void setProcessInProgress(bool isProcessInProgress) {
    state = state.copyWith(isProcessInProgress: isProcessInProgress);
  }

  void setFinalAmountReward(double? finalAmountReward) {
    state = state.copyWith(finalAmountReward: finalAmountReward);
  }

  void setFinalAmountWithdraw(double? finalAmountWithdraw) {
    state = state.copyWith(finalAmountWithdraw: finalAmountWithdraw);
  }

  void setFarmLockWithdrawProcessStep(
    aedappfm.ProcessStep farmLockWithdrawProcessStep,
  ) {
    state = state.copyWith(
      processStep: farmLockWithdrawProcessStep,
    );
  }

  Future<void> validateForm(AppLocalizations appLocalizations) async {
    if (await control(appLocalizations) == false) {
      return;
    }

    final accountSelected = ref.read(
      accountsNotifierProvider.select(
        (accounts) => accounts.valueOrNull?.selectedAccount,
      ),
    );
    DateTime? consentDateTime;
    consentDateTime = await aedappfm.ConsentRepositoryImpl()
        .getConsentTime(accountSelected!.genesisAddress);
    state = state.copyWith(consentDateTime: consentDateTime);

    setFarmLockWithdrawProcessStep(
      aedappfm.ProcessStep.confirmation,
    );
  }

  Future<bool> control(AppLocalizations appLocalizations) async {
    setFailure(null);

    if (BrowserUtil().isEdgeBrowser() ||
        BrowserUtil().isInternetExplorerBrowser()) {
      setFailure(
        const aedappfm.Failure.incompatibleBrowser(),
      );
      return false;
    }

    if (state.amount <= 0) {
      setFailure(
        aedappfm.Failure.other(
          cause: appLocalizations.farmLockWithdrawControlAmountEmpty,
        ),
      );
      return false;
    }

    if (state.amount > state.depositedAmount!) {
      setFailure(
        aedappfm.Failure.other(
          cause: appLocalizations
              .farmLockWithdrawControlLPTokenAmountExceedDeposited,
        ),
      );
      return false;
    }

    final feeEstimation = await _calculateFees();
    if (feeEstimation > 0) {
      final userBalance = await ref.read(userBalanceProvider.future);
      if (feeEstimation > archethic.fromBigInt(userBalance.uco).toDouble()) {
        setFailure(const aedappfm.Failure.insufficientFunds());
        return false;
      }
    }

    return true;
  }

  Future<bool> withdraw(AppLocalizations localizations) async {
    setFarmLockWithdrawOk(false);
    setProcessInProgress(true);

    if (await control(localizations) == false) {
      setProcessInProgress(false);
      return false;
    }

    final accountSelected = ref.read(
      accountsNotifierProvider.select(
        (accounts) => accounts.valueOrNull?.selectedAccount,
      ),
    );

    final earnUserLevel = ref.read(
      SettingsProviders.settings.select((settings) => settings.earnUserLevel),
    );

    await aedappfm.ConsentRepositoryImpl()
        .addAddress(accountSelected!.genesisAddress);

    if (earnUserLevel == EarnUserLevelType.advanced) {
      await ref.read(withdrawFarmLockCaseProvider).run(
            localizations,
            this,
            state.isFarmClose,
            state.farmAddress!,
            state.lpToken!.address,
            state.amount,
            state.depositId,
            state.rewardToken!,
          );
    } else {
      final environment = ref.read(environmentProvider);
      final farmLock = ref.read(farmLockFormFarmLockProvider).value;
      final stepsState = ref.read(stepsNotifierProvider.notifier);
      final currentStep = ref
          .read(stepsNotifierProvider)
          .steps
          .firstWhereOrNull((step) => step.status == StepStatus.failed)
          ?.stepIndex;

      stepsState.updateStepStatus(currentStep ?? 0, StepStatus.inProgress);

      final result = await ref.read(withdrawFundsBeginnerCaseProvider).run(
            localizations,
            farmLock!.farmAddress,
            farmLock.poolAddress,
            environment.aeETHAddress,
            farmLock.lpToken!.address,
            farmLock.userInfos,
            currentStep ?? 0,
            stepsState,
            ref.read(stepsNotifierProvider).snapshot,
          );

      if (result.amountTokenUCOSwapped != null) {
        state =
            state.copyWith(finalAmountWithdraw: result.amountTokenUCOSwapped);
      }
      if (result.amountReward != null) {
        state = state.copyWith(finalAmountReward: result.amountReward);
      }
    }

    ref
      ..invalidate(userBalanceProvider)
      ..invalidate(farmLockFormFarmLockProvider)
      ..invalidate(airdropUserInfoProvider)
      ..invalidate(airdropPersonalLPProvider)
      ..invalidate(farmLockFormSummaryProvider);

    return true;
  }
}
