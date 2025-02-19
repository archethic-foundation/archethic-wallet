import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/bloc/state.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_checkbox_confirm_not_multiple_registrations.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_checkbox_confirm_only_one_airdrop.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_checkbox_confirm_privacy_policy.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_stepper.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_textfield_mail.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropParticipateStepJoinWaitlistSheet extends ConsumerStatefulWidget {
  const AirdropParticipateStepJoinWaitlistSheet({
    super.key,
  });

  @override
  ConsumerState<AirdropParticipateStepJoinWaitlistSheet> createState() =>
      _AirdropParticipateStepJoinWaitlistSheetState();
}

class _AirdropParticipateStepJoinWaitlistSheetState
    extends ConsumerState<AirdropParticipateStepJoinWaitlistSheet> {
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
                      localizations.airdropParticipateStepWaitlistTitle,
                      style: AppTextStyles.bodyLarge(context)
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      localizations.airdropParticipateStepWaitlistDesc2,
                      style: AppTextStyles.bodyMediumWithOpacity(context),
                    ),
                    const SizedBox(height: 20),
                    const AirdropTextFieldMail(),
                    const SizedBox(height: 20),
                    const AirdropCheckboxConfirmOnlyOneAirdrop(),
                    const SizedBox(height: 20),
                    const AirdropCheckboxConfirmNotMultipleRegistrations(),
                    const SizedBox(height: 20),
                    const AirdropCheckboxConfirmPrivacyPolicy(),
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
                  localizations.airdropParticipateStepWaitlistBtn,
                  Dimens.buttonBottomDimens,
                  onPressed: () {
                    ref
                        .read(airdropFormNotifierProvider.notifier)
                        .setAirdropProcessStep(AirdropProcessStep.sign);
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
