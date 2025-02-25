import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_stepper.dart';
import 'package:aewallet/ui/views/main/bloc/providers.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
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
                    const AirdropStepper(),
                    Text(
                      localizations.airdropParticipateStepSupportEcosystemTitle,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      localizations.airdropParticipateStepSupportEcosystemDesc1,
                      style: Theme.of(context).textTheme.bodySmallWithOpacity,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      localizations.airdropParticipateStepSupportEcosystemDesc2,
                      style: Theme.of(context).textTheme.bodySmallWithOpacity,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      localizations.airdropParticipateStepSupportEcosystemDesc3,
                      style: Theme.of(context).textTheme.bodySmallWithOpacity,
                    ),
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
                  localizations.airdropParticipateStepSupportEcosystemBtn,
                  Dimens.buttonBottomDimens,
                  onPressed: () async {
                    await ref
                        .read(SettingsProviders.settings.notifier)
                        .setMainScreenCurrentPage(3);
                    ref.read(mainTabControllerProvider)!.animateTo(
                          3,
                          duration: Duration.zero,
                        );
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
