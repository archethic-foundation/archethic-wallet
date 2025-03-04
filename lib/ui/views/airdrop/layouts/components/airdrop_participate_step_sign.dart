import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/bloc/state.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_stepper.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class AirdropParticipateStepSignSheet extends ConsumerStatefulWidget {
  const AirdropParticipateStepSignSheet({
    super.key,
  });

  @override
  ConsumerState<AirdropParticipateStepSignSheet> createState() =>
      _AirdropParticipateStepSignSheetState();
}

class _AirdropParticipateStepSignSheetState
    extends ConsumerState<AirdropParticipateStepSignSheet> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final airdropForm = ref.watch(airdropFormNotifierProvider);
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
                      localizations.airdropParticipateStepSignTitle,
                      style: Theme.of(context).textTheme.titleSmallSemiBold,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      localizations.airdropParticipateStepSignDesc1,
                      style: Theme.of(context).textTheme.bodySmallWithOpacity,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      localizations.airdropParticipateStepSignDesc2,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmallWithOpacity
                          .copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                    const SizedBox(height: 20),
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Container(
                              height: 16,
                              width: 16,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: aedappfm.AppThemeBase.gradientBtn,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Symbols.verified_user,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                          TextSpan(
                            text:
                                '  ${localizations.airdropParticipateStepSignWarn}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        ref
                            .read(airdropFormNotifierProvider.notifier)
                            .setAirdropProcessStep(
                              AirdropProcessStep.joinWaitlist,
                            );
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 14,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            localizations.back,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmallWithOpacity,
                          ),
                        ],
                      ),
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
                  localizations.airdropParticipateStepSignBtn,
                  Dimens.buttonBottomDimens,
                  onPressed: () async {
                    await ref
                        .read(airdropFormNotifierProvider.notifier)
                        .joinWaitlist(
                          localizations,
                        );
                  },
                  disabled: airdropForm.joinWaitlistInProgress,
                  showProgressIndicator: airdropForm.joinWaitlistInProgress,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
