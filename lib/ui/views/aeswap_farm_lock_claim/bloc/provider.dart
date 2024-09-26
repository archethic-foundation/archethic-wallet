import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/repositories/transaction_remote.dart';
import 'package:aewallet/infrastructure/repositories/transaction/archethic_transaction.dart';
import 'package:aewallet/modules/aeswap/application/notification.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/domain/usecases/claim_farm_lock.usecase.dart';
import 'package:aewallet/modules/aeswap/util/browser_util_desktop.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_claim/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _farmLockClaimFormProvider = NotifierProvider.autoDispose<
    FarmLockClaimFormNotifier, FarmLockClaimFormState>(
  () {
    return FarmLockClaimFormNotifier();
  },
);

class FarmLockClaimFormNotifier
    extends AutoDisposeNotifier<FarmLockClaimFormState> {
  FarmLockClaimFormNotifier();

  @override
  FarmLockClaimFormState build() => const FarmLockClaimFormState();

  void setTransactionClaimFarmLock(
      archethic.Transaction transactionClaimFarmLock) {
    state = state.copyWith(transactionClaimFarmLock: transactionClaimFarmLock);
  }

  void setRewardAmount(double? rewardAmount) {
    state = state.copyWith(rewardAmount: rewardAmount);
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

  void setLpTokenAddress(String lpTokenAddress) {
    state = state.copyWith(
      lpTokenAddress: lpTokenAddress,
    );
  }

  void setDepositId(String depositId) {
    state = state.copyWith(depositId: depositId);
  }

  void setFailure(aedappfm.Failure? failure) {
    state = state.copyWith(
      failure: failure,
    );
  }

  void setFarmLockClaimOk(bool farmLockClaimOk) {
    state = state.copyWith(
      farmLockClaimOk: farmLockClaimOk,
    );
  }

  void setFinalAmount(double? finalAmount) {
    state = state.copyWith(finalAmount: finalAmount);
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

  void setFarmLockClaimProcessStep(
    aedappfm.ProcessStep farmLockClaimProcessStep,
  ) {
    state = state.copyWith(
      processStep: farmLockClaimProcessStep,
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

    setFarmLockClaimProcessStep(
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

    return true;
  }

  Future<void> claim(BuildContext context, WidgetRef ref) async {
    setFarmLockClaimOk(false);
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
        ref.read(FarmLockClaimFormProvider._repository);

    if (context.mounted) {
      await ClaimFarmLockCase().run(
        transactionRepository,
        ref,
        context,
        ref.watch(NotificationProviders.notificationService),
        state.farmAddress!,
        state.depositId!,
        state.rewardToken!,
      );
    }
  }
}

abstract class FarmLockClaimFormProvider {
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
  static final farmLockClaimForm = _farmLockClaimFormProvider;
}
