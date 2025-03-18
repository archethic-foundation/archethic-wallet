import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/application/aeswap/dex_token.dart';
import 'package:aewallet/application/airdrop/airdrop.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/feature_flags.dart';
import 'package:aewallet/main.dart';
import 'package:aewallet/modules/aeswap/application/session/provider.dart';
import 'package:aewallet/modules/aeswap/application/session/state.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/airdrop/bloc/airdrop_banner_status.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/bloc/state.dart';
import 'package:aewallet/ui/views/airdrop/layouts/airdrop_participate_sheet.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_banner.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_participate_step_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropTab extends ConsumerStatefulWidget {
  const AirdropTab({
    super.key,
  });

  @override
  ConsumerState<AirdropTab> createState() => _AirdropTabState();
}

class _AirdropTabState extends ConsumerState<AirdropTab> {
  AirdropState? airdropState;

  @override
  void initState() {
    Future(() async {
      final airdropStateFuture = ref.read(airdropBannerStatusProvider.future);
      final airdropUserInfoFuture = ref.read(airdropUserInfoProvider.future);
      final airdropPersonalLPFuture =
          ref.read(airdropPersonalLPProvider.future);

      final results = await Future.wait([
        airdropStateFuture,
        airdropUserInfoFuture,
        airdropPersonalLPFuture,
      ]);

      airdropState = (results[0] as AirdropBannerStatus).airdropState;
      final airdropUserInfo = results[1] as ({
        bool? isMailConfirmed,
        String? email,
        String? referralCode,
        int? referralsRegistered,
        int? referralsParticipant,
        int? referralMultiplier,
      });
      final airdropPersonalLP = results[2] as ({
        int personalMultiplier,
        double personalLP,
        double personalLPFlexible
      });

      var actualLPFiatValue = 0.0;
      final environment = ref.read(environmentProvider);

      actualLPFiatValue = await ref.read(
        DexTokensProviders.estimateLPTokenInFiat(
          environment.aeETHAddress,
          kUCOAddress,
          1,
          environment.aeETHUCOPoolAddress,
        ).future,
      );

      if (airdropState != null) {
        switch (airdropState) {
          case AirdropState.shouldAddMail:
          case AirdropState.shouldConfirmMailAndFarm:
          case AirdropState.shouldConfirmMail:
            ref.read(airdropFormNotifierProvider.notifier)
              ..setConfirmNotMultipleRegistrations(true)
              ..setConfirmOnlyOneAirdrop(true)
              ..setConfirmPrivacyPolicy(true)
              ..setAirdropProcessStep(AirdropProcessStep.confirmEmail);

            break;
          case AirdropState.newParticipation:
            ref
                .read(airdropFormNotifierProvider.notifier)
                .setAirdropProcessStep(AirdropProcessStep.welcome);
            break;
          case AirdropState.shouldFarm:
          case AirdropState.ok:
            ref
                .read(airdropFormNotifierProvider.notifier)
                .setAirdropProcessStep(AirdropProcessStep.congrats);
            break;
          case null:
            break;
        }
      }

      ref.read(airdropFormNotifierProvider.notifier)
        ..setMailAddress(airdropUserInfo.email ?? '')
        ..setPersonalLP(airdropPersonalLP.personalLP)
        ..setPersonalLPFlexible(airdropPersonalLP.personalLPFlexible)
        ..setActualLPFiatValue(actualLPFiatValue)
        ..setReferralCode(airdropUserInfo.referralCode ?? '?')
        ..setReferralsParticipant(airdropUserInfo.referralsParticipant ?? 0)
        ..setReferralsRegistered(airdropUserInfo.referralsRegistered ?? 0)
        ..setReferralMultiplier(airdropUserInfo.referralMultiplier ?? 0)
        ..setLoading(false);
    });
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final accountSelected = ref.watch(
      accountsNotifierProvider.select(
        (accounts) => accounts.valueOrNull?.selectedAccount,
      ),
    );

    if (accountSelected == null) return const SizedBox();

    final airdropFeatureFlag = ref
        .watch(getFeatureFlagProvider(kApplicationCode, 'airdrop'))
        .valueOrNull;

    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    if (connectivityStatusProvider == ConnectivityStatus.isDisconnected ||
        airdropFeatureFlag == false) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'The airdrop feature is currently unavailable.',
                    style: AppTextStyles.bodyLargeSecondaryColor(context),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Please check back later or stay tuned for updates.\nThank you for your understanding!',
                    style: AppTextStyles.bodyMedium(context),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    final airdropForm = ref.watch(airdropFormNotifierProvider);

    if (airdropForm.loading || airdropState == null) {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 0.5,
            ),
          ),
        ],
      );
    }

    switch (airdropState) {
      case null:
      case AirdropState.newParticipation:
        return const AirdropParticipateSheet();
      case AirdropState.shouldAddMail:
        return const AirdropParticipateSheet();
      case AirdropState.shouldConfirmMailAndFarm:
      case AirdropState.shouldConfirmMail:
        return const AirdropParticipateSheet();
      case AirdropState.shouldFarm:
      case AirdropState.ok:
        return AirdropParticipateStepDashboardSheet(
          airdropState: airdropState,
          personalMultiplier: airdropForm.personalMultiplier,
        );
    }
  }
}
