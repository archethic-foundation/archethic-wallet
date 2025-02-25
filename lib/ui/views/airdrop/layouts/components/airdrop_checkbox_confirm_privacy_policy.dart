import 'package:aewallet/ui/figma_components/checkbox/checkbox_confirm.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
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

    return CheckboxConfirm(
      text: Row(
        children: [
          Text(
            localizations.airdropParticipateStepWelcomeConfirmItem3,
            style: Theme.of(context).textTheme.bodySmallWithOpacity,
          ),
          InkWell(
            onTap: () async {
              await launchUrl(
                Uri.parse(
                  'https://www.archethic.net/privacy-policy-wallet.html',
                ),
                mode: LaunchMode.externalApplication,
              );
            },
            child: Text(
              localizations.airdropParticipateStepWelcomeConfirmItem3link,
              style: Theme.of(context).textTheme.bodySmallLink,
            ),
          ),
        ],
      ),
      value: airdropForm.confirmPrivacyPolicy,
      onChanged: (value) {
        ref
            .read(airdropFormNotifierProvider.notifier)
            .setConfirmPrivacyPolicy(value);
      },
    );
  }
}
