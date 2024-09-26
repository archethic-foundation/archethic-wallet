import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/repositories/transaction_remote.dart';
import 'package:aewallet/infrastructure/repositories/transaction/archethic_transaction.dart';
import 'package:aewallet/modules/aeswap/application/notification.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pair.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/domain/usecases/withdraw_farm_lock.usecase.dart';
import 'package:aewallet/modules/aeswap/util/browser_util_desktop.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_withdraw/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _farmLockWithdrawFormProvider = NotifierProvider.autoDispose<
    FarmLockWithdrawFormNotifier, FarmLockWithdrawFormState>(
  () {
    return FarmLockWithdrawFormNotifier();
  },
);

class FarmLockWithdrawFormNotifier
    extends AutoDisposeNotifier<FarmLockWithdrawFormState> {
  FarmLockWithdrawFormNotifier();

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
    BuildContext context,
    double amount,
  ) {
    state = state.copyWith(
      failure: null,
      amount: amount,
    );

    if (state.amount > state.depositedAmount!) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!
              .farmLockWithdrawControlLPTokenAmountExceedDeposited,
        ),
      );
    }
  }

  void setDepositedAmount(double? depositedAmount) {
    state = state.copyWith(depositedAmount: depositedAmount);
  }

  void setRewardAmount(double? rewardAmount) {
    state = state.copyWith(rewardAmount: rewardAmount);
  }

  void setAmountMax(BuildContext context) {
    setAmount(context, state.depositedAmount!);
  }

  void setPoolAddress(String poolAddress) {
    state = state.copyWith(poolAddress: poolAddress);
  }

  void setEndDate(DateTime endDate) {
    state = state.copyWith(endDate: endDate);
  }

  void setAmountHalf(
    BuildContext context,
  ) {
    setAmount(
      context,
      (Decimal.parse(state.depositedAmount.toString()) / Decimal.fromInt(2))
          .toDouble(),
    );
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

  Future<void> validateForm(BuildContext context) async {
    if (control(context) == false) {
      return;
    }

    final accountSelected = ref.watch(
      AccountProviders.accounts.select(
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

  bool control(BuildContext context) {
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
          cause:
              AppLocalizations.of(context)!.farmLockWithdrawControlAmountEmpty,
        ),
      );
      return false;
    }

    if (state.amount > state.depositedAmount!) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!
              .farmLockWithdrawControlLPTokenAmountExceedDeposited,
        ),
      );
      return false;
    }

    return true;
  }

  Future<void> withdraw(BuildContext context, WidgetRef ref) async {
    setFarmLockWithdrawOk(false);
    setProcessInProgress(true);

    if (control(context) == false) {
      setProcessInProgress(false);
      return;
    }

    final accountSelected = ref.watch(
      AccountProviders.accounts.select(
        (accounts) => accounts.valueOrNull?.selectedAccount,
      ),
    );
    await aedappfm.ConsentRepositoryImpl()
        .addAddress(accountSelected!.genesisAddress);

    final transactionRepository =
        ref.read(FarmLockWithdrawFormProvider._repository);

    if (context.mounted) {
      await WithdrawFarmLockCase().run(
        transactionRepository,
        ref,
        context,
        ref.watch(NotificationProviders.notificationService),
        state.farmAddress!,
        state.lpToken!.address!,
        state.amount,
        state.depositId,
        state.rewardToken!,
      );
    }
  }
}

abstract class FarmLockWithdrawFormProvider {
  static final _repository = Provider<TransactionRemoteRepositoryInterface>(
    (ref) {
      final networkSettings = ref.watch(
        SettingsProviders.settings.select((settings) => settings.network),
      );
      return ArchethicTransactionRepository(
        phoenixHttpEndpoint: networkSettings.getPhoenixHttpLink(),
        websocketEndpoint: networkSettings.getWebsocketUri(),
      );
    },
  );
  static final farmLockWithdrawForm = _farmLockWithdrawFormProvider;
}
