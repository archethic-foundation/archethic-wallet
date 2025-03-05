import 'package:aewallet/modules/aeswap/ui/views/util/consent_uri.dart';
import 'package:aewallet/ui/figma_components/checkbox/checkbox_confirm.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_withdraw/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class FarmLockWithdrawConfirmPrivacyPolicy extends ConsumerWidget {
  const FarmLockWithdrawConfirmPrivacyPolicy({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmLockWithdraw = ref.watch(farmLockWithdrawFormNotifierProvider);
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
      value: farmLockWithdraw.confirmPrivacyPolicy,
      onChanged: (value) {
        ref
            .read(farmLockWithdrawFormNotifierProvider.notifier)
            .setConfirmPrivacyPolicy(value);
      },
    );
  }
}
