import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/bloc/state.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_lp_available.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_lp_current_value.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_step_tab.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_stepper.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropParticipateStepSupportEcosystemSheet
    extends ConsumerStatefulWidget {
  const AirdropParticipateStepSupportEcosystemSheet({
    super.key,
  });

  @override
  ConsumerState<AirdropParticipateStepSupportEcosystemSheet> createState() =>
      _AirdropParticipateStepSupportEcosystemSheetState();
}

class _AirdropParticipateStepSupportEcosystemSheetState
    extends ConsumerState<AirdropParticipateStepSupportEcosystemSheet> {
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

    final localizations = AppLocalizations.of(context)!;
    final farmLock = ref.watch(farmLockFormFarmLockProvider).valueOrNull;

    return Stack(
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
                    const AirdropStepper(),
                    Text(
                      localizations.airdropParticipateStepSupportEcosystemTitle,
                      style: AppTextStyles.bodyLarge(context)
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: localizations
                                .airdropParticipateStepSupportEcosystemDesc1,
                            style: AppTextStyles.bodyMediumWithOpacity(context),
                          ),
                          TextSpan(
                            text: farmLock != null && farmLock.apr3years > 0
                                ? '${(farmLock.apr3years * 100).formatNumber(precision: 2)}% return'
                                : '___% return',
                            style:
                                AppTextStyles.bodyMediumSecondaryColor(context),
                          ),
                          TextSpan(
                            text: localizations
                                .airdropParticipateStepSupportEcosystemDesc2,
                            style: AppTextStyles.bodyMediumWithOpacity(context),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const AirdropLPCurrentValue(),
                    const SizedBox(height: 10),
                    const AirdropLPAvailable(),
                    const SizedBox(height: 10),
                    const AirdropStepTab(displayNoteMultiplier: false),
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
              children: <Widget>[
                AppButtonTinyConnectivity(
                  localizations.airdropParticipateStepWelcomeBtn,
                  Dimens.buttonBottomDimens,
                  onPressed: () {
                    ref
                        .read(airdropFormNotifierProvider.notifier)
                        .setAirdropProcessStep(AirdropProcessStep.congrats);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
