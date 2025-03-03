import 'package:aewallet/modules/aeswap/ui/views/util/consent_uri.dart';
import 'package:aewallet/ui/figma_components/checkbox/checkbox_confirm.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class FarmLockDepositConfirmPrivacyPolicy extends ConsumerWidget {
  const FarmLockDepositConfirmPrivacyPolicy({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmLockDeposit = ref.watch(farmLockDepositFormNotifierProvider);
    final localizations = AppLocalizations.of(context)!;

    return CheckboxConfirm(
      text: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: localizations.farmLockDepositConfirmPrivacyPolicyDesc1,
              style: Theme.of(context).textTheme.bodySmallWithOpacity,
            ),
            WidgetSpan(
              child: InkWell(
                onTap: () async {
                  await launchUrl(
                    Uri.parse(
                      kURITermsOfUse,
                    ),
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Text(
                  localizations
                      .farmLockDepositConfirmPrivacyPolicyDescTermsLink,
                  style: Theme.of(context).textTheme.bodySmallLink,
                ),
              ),
            ),
            TextSpan(
              text: localizations.farmLockDepositConfirmPrivacyPolicyDesc2,
              style: Theme.of(context).textTheme.bodySmallWithOpacity,
            ),
            WidgetSpan(
              child: InkWell(
                onTap: () async {
                  await launchUrl(
                    Uri.parse(kURIPrivacyPolicy),
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Text(
                  localizations
                      .farmLockDepositConfirmPrivacyPolicyDescPrivacyLink,
                  style: Theme.of(context).textTheme.bodySmallLink,
                ),
              ),
            ),
          ],
        ),
      ),
      value: farmLockDeposit.confirmPrivacyPolicy,
      onChanged: (value) {
        ref
            .read(farmLockDepositFormNotifierProvider.notifier)
            .setConfirmPrivacyPolicy(value);
      },
    );
  }
}
