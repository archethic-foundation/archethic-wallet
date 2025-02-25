import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/util/dimens.dart';
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

class AirdropParticipateStepCongratsSheet extends ConsumerStatefulWidget {
  const AirdropParticipateStepCongratsSheet({
    required this.airdropState,
    required this.personalMultiplier,
    super.key,
  });

  final AirdropState? airdropState;
  final int personalMultiplier;

  @override
  ConsumerState<AirdropParticipateStepCongratsSheet> createState() =>
      _AirdropParticipateStepCongratsSheetState();
}

class _AirdropParticipateStepCongratsSheetState
    extends ConsumerState<AirdropParticipateStepCongratsSheet> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final localizations = AppLocalizations.of(context)!;
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
                    Text(
                      widget.airdropState != null &&
                              widget.airdropState == AirdropState.ok
                          ? localizations.airdropDashboardCongratsTitle
                          : localizations
                              .airdropDashboardCompleteParticipationTitle,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: AirdropPersonalMultiplier(),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: AirdropPersonalRewards(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const AirdropInfoNoLP(),
                    const SizedBox(height: 10),
                    const AirdropLPCurrentValue(),
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
              children: <Widget>[
                AppButtonTinyConnectivity(
                  widget.personalMultiplier > 0
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
    );
  }
}
