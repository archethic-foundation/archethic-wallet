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
import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/farm_lock_duration_type.dart';
import 'package:aewallet/modules/aeswap/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aewallet/modules/aeswap/util/browser_util_web.dart';
import 'package:aewallet/modules/aeswap/util/riverpod.dart';
import 'package:aewallet/ui/util/delayed_task.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:collection/collection.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
class FarmLockDepositFormNotifier extends _$FarmLockDepositFormNotifier {
  FarmLockDepositFormNotifier();

  CancelableTask<double?>? _calculateFeesTask;

  @override
  FarmLockDepositFormState build() {
    final earnUserLevel = ref.read(
      SettingsProviders.settings.select((settings) => settings.earnUserLevel),
    );

    final userBalance = earnUserLevel == EarnUserLevelType.beginner
        ? _watchUCOBalance()
        : _watchLPTokenBalance();

    // Reuse previous state values.
    // If this is a first build, uses a default state.
    return (stateOrNull ?? const FarmLockDepositFormState()).copyWith(
      userBalance: userBalance,
      farmLockDepositMode: earnUserLevel == EarnUserLevelType.beginner
          ? FarmLockDepositMode.uco
          : FarmLockDepositMode.lp,
    );
  }

  double _watchLPTokenBalance() {
    /// Rebuilds this provider when lpTokenAddress changes
    /// That way, it will watch the appropriate lpBalanceProvider.
    ref.invalidateSelfOnPropertyChange(
      (state) => state?.lpTokenAddress,
    );

    final lpTokenAddress = stateOrNull?.lpTokenAddress;
    if (lpTokenAddress == null) return 0;
    return ref.watch(getBalanceProvider(lpTokenAddress)).valueOrNull ?? 0.0;
  }

  double _watchUCOBalance() {
    /// Rebuilds this provider when lpTokenAddress changes
    /// That way, it will watch the appropriate lpBalanceProvider.
    ref.invalidateSelfOnPropertyChange(
      (state) => kUCOAddress,
    );

    return ref.watch(getBalanceProvider(kUCOAddress)).valueOrNull ?? 0.0;
  }

  void setTransactionFarmLockDeposit(
    archethic.Transaction transactionFarmLockDeposit,
  ) {
    state =
        state.copyWith(transactionFarmLockDeposit: transactionFarmLockDeposit);
  }

  Future<void> setAmount(
    double amount,
  ) async {
    state = state.copyWith(
      failure: null,
      amount: amount,
    );

    // Estimate fees
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
    if (state.amount <= 0 || state.level.isEmpty) {
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
    if (state.farmLockDepositMode == FarmLockDepositMode.lp) {
      feeEstimation = await ref.read(depositFarmLockCaseProvider).estimateFees(
            state.farmLock!.farmAddress,
            state.farmLock!.lpToken!.address,
            state.amount,
            state.farmLockDepositDuration,
            state.level,
          );
    } else {
      final environment = ref.read(environmentProvider);
      try {
        final results = await Future.wait([
          ref.read(swapCaseProvider).estimateFees(
                state.pool!.poolAddress,
                const DexToken(address: kUCOAddress, symbol: kUCOAddress),
                state.amount,
                0,
              ),
          ref.read(addLiquidityCaseProvider).estimateFees(
                state.pool!.poolAddress,
                const DexToken(address: kUCOAddress, symbol: kUCOAddress),
                state.amount,
                DexToken(address: environment.aeETHAddress, symbol: 'aeETH'),
                99999, // Default Value
                0,
              ),
          ref.read(depositFarmLockCaseProvider).estimateFees(
                state.farmLock!.farmAddress,
                state.farmLock!.lpToken!.address,
                99999, // Default Value
                state.farmLockDepositDuration,
                state.level,
              ),
        ]);

        final totalFees = results[0] + results[1] + results[2];
        const slippage = 1.5;
        feeEstimation = totalFees * slippage;
      } catch (e) {
        return 0.0;
      }
    }
    return feeEstimation;
  }

  void setAmountMax() {
    // TODO(reddwarf03): Warning with fees
    setAmount(state.userBalance);
  }

  void setFilterAvailableLevels(Map<String, int> filterAvailableLevels) {
    state = state.copyWith(filterAvailableLevels: filterAvailableLevels);
  }

  void setDexPool(DexPool pool) {
    state = state.copyWith(
      pool: pool,
    );
  }

  void setDexFarmLock(DexFarmLock farmLock) {
    state = state.copyWith(
      farmLock: farmLock,
    );
  }

  void setFailure(aedappfm.Failure? failure) {
    state = state.copyWith(
      failure: failure,
    );
  }

  void setFarmLockDepositOk(bool farmLockDepositOk) {
    state = state.copyWith(
      farmLockDepositOk: farmLockDepositOk,
    );
  }

  void setFinalAmount(double? finalAmount) {
    state = state.copyWith(finalAmount: finalAmount);
  }

  void setCurrentStep(int currentStep) {
    state = state.copyWith(currentStep: currentStep);
  }

  void setFarmLockDepositDuration(
    FarmLockDepositDurationType farmLockDepositDuration,
  ) {
    state = state.copyWith(farmLockDepositDuration: farmLockDepositDuration);
  }

  void setLevel(String level) {
    state = state.copyWith(level: level);
    unawaited(_updateFees());
  }

  void setResumeProcess(bool resumeProcess) {
    state = state.copyWith(resumeProcess: resumeProcess);
  }

  void setProcessInProgress(bool isProcessInProgress) {
    state = state.copyWith(isProcessInProgress: isProcessInProgress);
  }

  void setAPREstimation(double? aprEstimation) {
    state = state.copyWith(aprEstimation: aprEstimation);
  }

  void setFarmLockDepositProcessStep(
    aedappfm.ProcessStep processStep,
  ) {
    state = state.copyWith(
      processStep: processStep,
    );
  }

  void filterAvailableLevels() {
    final availableLevelsFiltered = <String, int>{};
    var needMax = false;
    final farmEndDate = state.farmLock!.endDate!;
    for (final entry in state.farmLock!.availableLevels.entries) {
      final level = entry.key;
      final endDate = entry.value;
      if (level != '0') {
        if (DateTime.fromMillisecondsSinceEpoch(
          entry.value * 1000,
        ).isBefore(farmEndDate)) {
          availableLevelsFiltered[level] = endDate;
        } else {
          if (needMax == false) {
            availableLevelsFiltered['max'] =
                farmEndDate.millisecondsSinceEpoch ~/ 1000;
            state = state.copyWith(
              farmLockDepositDuration: FarmLockDepositDurationType.max,
            );
            needMax = true;
          }
        }
      }
    }
    state = state.copyWith(filterAvailableLevels: availableLevelsFiltered);
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

    setFarmLockDepositProcessStep(
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
          cause: appLocalizations.farmDepositControlAmountEmpty,
        ),
      );
      return false;
    }

    if (state.amount > state.userBalance) {
      setFailure(
        aedappfm.Failure.other(
          cause: appLocalizations.farmDepositControlLPTokenAmountExceedBalance,
        ),
      );
      return false;
    }

    if (state.amount < 0.00000143) {
      setFailure(
        aedappfm.Failure.other(
          cause: appLocalizations.farmDepositControlAmountMin,
        ),
      );
      return false;
    }

    final feeEstimation = await _calculateFees();
    if (feeEstimation > 0) {
      final userBalance = await ref.read(userBalanceProvider.future);
      if (state.farmLockDepositMode == FarmLockDepositMode.lp) {
        if (feeEstimation > archethic.fromBigInt(userBalance.uco).toDouble()) {
          setFailure(const aedappfm.Failure.insufficientFunds());
          return false;
        }
      } else {
        if (feeEstimation + state.amount >
            archethic.fromBigInt(userBalance.uco).toDouble()) {
          setFailure(const aedappfm.Failure.insufficientFunds());
          return false;
        }
      }
    }

    return true;
  }

  Future<bool> lock(AppLocalizations appLocalizations) async {
    setFarmLockDepositOk(false);
    setProcessInProgress(true);

    if (await control(appLocalizations) == false) {
      setProcessInProgress(false);
      return false;
    }

    final accountSelected = ref.read(
      accountsNotifierProvider.select(
        (accounts) => accounts.valueOrNull?.selectedAccount,
      ),
    );
    await aedappfm.ConsentRepositoryImpl()
        .addAddress(accountSelected!.genesisAddress);

    if (state.farmLockDepositMode == FarmLockDepositMode.lp) {
      await ref.read(depositFarmLockCaseProvider).run(
            appLocalizations,
            this,
            state.farmLock!.farmAddress,
            state.farmLock!.lpToken!.address,
            state.amount,
            state.farmLock!.farmAddress,
            false,
            state.farmLockDepositDuration,
            state.level,
          );
    } else {
      final environment = ref.read(environmentProvider);
      final stepsState = ref.read(stepsNotifierProvider.notifier);
      final currentStep = ref
          .read(stepsNotifierProvider)
          .steps
          .firstWhereOrNull((step) => step.status == StepStatus.failed)
          ?.stepIndex;

      stepsState.updateStepStatus(currentStep ?? 0, StepStatus.inProgress);

      final lpLocked = await ref.read(addFundsBeginnerCaseProvider).run(
            appLocalizations,
            state.farmLock!.farmAddress,
            state.amount,
            state.farmLock!.poolAddress,
            environment.aeETHAddress,
            state.farmLock!.lpToken!.address,
            state.farmLockDepositDuration,
            state.level,
            currentStep ?? 0,
            stepsState,
            ref.read(stepsNotifierProvider).snapshot,
          );

      if (lpLocked != null) {
        state = state.copyWith(finalAmount: lpLocked);
      }
    }

    ref
      ..invalidate(userBalanceProvider)
      ..invalidate(farmLockFormFarmLockProvider)
      ..invalidate(airdropUserInfoProvider)
      ..invalidate(airdropPersonalLPProvider);

    return true;
  }
}
