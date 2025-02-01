import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/util/custom_checkbox.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class AirdropCheckboxConfirmPrivacyPolicy extends ConsumerWidget {
  const AirdropCheckboxConfirmPrivacyPolicy({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final airdropForm = ref.watch(airdropFormNotifierProvider);
    final localizations = AppLocalizations.of(context)!;
    return Row(
      children: [
        CustomCheckbox(
          value: airdropForm.confirmPrivacyPolicy,
          onChanged: (value) {
            if (value != null) {
              ref
                  .read(airdropFormNotifierProvider.notifier)
                  .setConfirmPrivacyPolicy(value);
            }
          },
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () async {
            await launchUrl(
              Uri.parse(
                'https://www.archethic.net/privacy-policy-wallet.html',
              ),
              mode: LaunchMode.externalApplication,
            );
          },
          child: Row(
            children: [
              Text(
                localizations.airdropParticipateStepWelcomeConfirmItem3,
                style: AppTextStyles.bodyMediumWithOpacity(context),
              ),
              Text(
                localizations.airdropParticipateStepWelcomeConfirmItem3link,
                style: AppTextStyles.bodyMediumWithOpacity(context).copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
