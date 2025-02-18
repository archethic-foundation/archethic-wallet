import 'dart:ui';

import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/application/aeswap/dex_token.dart';
import 'package:aewallet/application/airdrop/airdrop.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/modules/aeswap/application/session/provider.dart';
import 'package:aewallet/modules/aeswap/application/session/state.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/layouts/airdrop_participate_sheet.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_banner.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_info_no_lp.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_lp_available.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_lp_current_value.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_note_farm_level.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_personal_multiplier.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_personal_rewards.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_step_tab.dart';
import 'package:aewallet/ui/views/main/bloc/providers.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
      ref.read(airdropFormNotifierProvider.notifier).setLoading(true);
      airdropState = (await ref.read(airdropBannerStatusProvider.future)).state;

      final airdropUserInfo = await ref.read(airdropUserInfoProvider.future);
      final airdropPersonalLP =
          await ref.read(airdropPersonalLPProvider.future);

      var actualLPFiatValue = 0.0;
      final environment = ref.read(environmentProvider);
      final farmLock = await ref.read(farmLockFormFarmLockProvider.future);
      if (farmLock != null && farmLock.lpTokenPair != null) {
        actualLPFiatValue = await ref.read(
          DexTokensProviders.estimateLPTokenInFiat(
            farmLock.lpTokenPair!.token1.address,
            farmLock.lpTokenPair!.token2.address,
            1,
            environment.aeETHUCOPoolAddress,
          ).future,
        );
      }

      ref.read(airdropFormNotifierProvider.notifier)
        ..setMailAddress(airdropUserInfo.email ?? '')
        ..setPersonalLP(airdropPersonalLP.personalLP)
        ..setPersonalLPFlexible(airdropPersonalLP.personalLPFlexible)
        ..setActualLPFiatValue(actualLPFiatValue)
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

    if (airdropState == AirdropState.newParticipation) {
      return const AirdropParticipateSheet();
    }

    final localizations = AppLocalizations.of(context)!;
    final airdropForm = ref.watch(airdropFormNotifierProvider);

    if (airdropForm.loading) {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 0.5,
              )),
        ],
      );
    }

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
        },
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ArchethicScrollbar(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 10,
                    bottom: 120,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        airdropState != null && airdropState == AirdropState.ok
                            ? localizations.airdropDashboardCongratsTitle
                            : localizations
                                .airdropDashboardCompleteParticipationTitle,
                        style: AppTextStyles.bodyLarge(context)
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          Flexible(
                            flex: 45,
                            child: AirdropPersonalMultiplier(),
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            flex: 45,
                            child: AirdropPersonalRewards(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const AirdropInfoNoLP(),
                      const SizedBox(height: 10),
                      const AirdropLPCurrentValue(),
                      const SizedBox(height: 10),
                      const AirdropLPAvailable(),
                      const SizedBox(height: 10),
                      const AirdropStepTab(),
                      const SizedBox(height: 20),
                      const AirdropNoteFarmLevel(),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 20,
              ),
              child: Row(
                children: [
                  AppButtonTinyConnectivity(
                    airdropForm.personalMultiplier > 0
                        ? localizations.airdropDashboardIncreaseAirdropBtn
                        : localizations.airdropDashboardNoLPBtn,
                    Dimens.buttonBottomDimens,
                    onPressed: () async {
                      await ref
                          .read(SettingsProviders.settings.notifier)
                          .setMainScreenCurrentPage(3);
                      ref.read(mainTabControllerProvider)!.animateTo(
                            3,
                            duration: Duration.zero,
                          );
                      context.pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
