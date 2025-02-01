import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/util/custom_checkbox.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropCheckboxConfirmNotMultipleRegistrations extends ConsumerWidget {
  const AirdropCheckboxConfirmNotMultipleRegistrations({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final airdropForm = ref.watch(airdropFormNotifierProvider);
    final localizations = AppLocalizations.of(context)!;

    return Row(
      children: [
        CustomCheckbox(
          value: airdropForm.confirmNotMultipleRegistrations,
          onChanged: (value) {
            if (value != null) {
              ref
                  .read(airdropFormNotifierProvider.notifier)
                  .setConfirmNotMultipleRegistrations(value);
            }
          },
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            localizations.airdropParticipateStepWelcomeConfirmItem2,
            style: AppTextStyles.bodyMediumWithOpacity(context),
          ),
        ),
      ],
    );
  }
}
