import 'package:aewallet/application/airdrop/airdrop.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/bloc/state.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_info_popup.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_stepper.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropParticipateStepConfirmEmailSheet extends ConsumerStatefulWidget {
  const AirdropParticipateStepConfirmEmailSheet({
    super.key,
  });

  @override
  ConsumerState<AirdropParticipateStepConfirmEmailSheet> createState() =>
      _AirdropParticipateStepJoinWaitlistSheetState();
}

class _AirdropParticipateStepJoinWaitlistSheetState
    extends ConsumerState<AirdropParticipateStepConfirmEmailSheet> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final localizations = AppLocalizations.of(context)!;
    final airdropForm = ref.read(airdropFormNotifierProvider);
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
                      localizations.airdropParticipateStepConfirmEmailTitle,
                      style: AppTextStyles.bodyLarge(context)
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      localizations.airdropParticipateStepConfirmEmailDesc1(
                        airdropForm.mailAddress ?? '',
                      ),
                      style: AppTextStyles.bodyMediumWithOpacity(context),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Text(
                          '${localizations.airdropParticipateStepConfirmEmailDesc4} ',
                          style: AppTextStyles.bodyMediumWithOpacity(context),
                        ),
                        InkWell(
                          onTap: () => ref
                              .read(airdropFormNotifierProvider.notifier)
                              .setAirdropProcessStep(
                                AirdropProcessStep.joinWaitlist,
                              ),
                          child: Text(
                            localizations
                                .airdropParticipateStepConfirmEmailDesc5,
                            style: AppTextStyles.bodyMedium(context)
                                .copyWith(decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      localizations.airdropParticipateStepConfirmEmailDesc2,
                      style: AppTextStyles.bodyMediumWithOpacity(context),
                    ),
                    InkWell(
                      onTap: () async {
                        await ref
                            .read(airdropFormNotifierProvider.notifier)
                            .resendConfirmationMail(localizations);
                        final airdrop = ref.read(airdropFormNotifierProvider);
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AirdropInfoPopup(
                              message: airdrop.resendConfirmationEmailInfo,
                            );
                          },
                        );
                      },
                      child: Text(
                        localizations.airdropParticipateStepConfirmEmailDesc3,
                        style: AppTextStyles.bodyMedium(context)
                            .copyWith(decoration: TextDecoration.underline),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      localizations.airdropParticipateStepConfirmEmailDesc6,
                      style: AppTextStyles.bodyMedium(context)
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
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
                  localizations.airdropParticipateStepWaitlistBtn,
                  Dimens.buttonBottomDimens,
                  onPressed: () async {
                    ref
                      ..invalidate(airdropUserInfoProvider)
                      ..invalidate(airdropPersonalLPProvider);
                    final resultCheckConfirmation = await ref
                        .read(airdropFormNotifierProvider.notifier)
                        .checkConfirmation();
                    if (resultCheckConfirmation.mailConfirmed) {
                      if (resultCheckConfirmation.havePersonalLP) {
                        ref
                            .read(airdropFormNotifierProvider.notifier)
                            .setAirdropProcessStep(
                              AirdropProcessStep.congrats,
                            );
                        return;
                      }
                      ref
                          .read(airdropFormNotifierProvider.notifier)
                          .setAirdropProcessStep(
                            AirdropProcessStep.supportEcosystem,
                          );
                      return;
                    }

                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AirdropInfoPopup(
                          message:
                              localizations.airdropBackendEmailNotConfirmed,
                        );
                      },
                    );
                  },
                  disabled: !airdropForm.isItemsConfirmed,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
