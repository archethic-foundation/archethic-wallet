import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/bloc/state.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_bloc_info.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropParticipateStepWelcomeSheet extends ConsumerStatefulWidget {
  const AirdropParticipateStepWelcomeSheet({super.key});

  @override
  ConsumerState<AirdropParticipateStepWelcomeSheet> createState() =>
      _AirdropParticipateStepWelcomeSheetState();
}

class _AirdropParticipateStepWelcomeSheetState
    extends ConsumerState<AirdropParticipateStepWelcomeSheet> {
  @override
  Widget build(BuildContext context) {
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
                      localizations.airdropParticipateStepWelcomeTitle,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      localizations.airdropParticipateStepWelcomeDesc1,
                      style: Theme.of(context).textTheme.bodySmallWithOpacity,
                    ),
                    const SizedBox(height: 40),
                    const AirdropBlocInfo(),
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
                        .setAirdropProcessStep(AirdropProcessStep.joinWaitlist);
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
