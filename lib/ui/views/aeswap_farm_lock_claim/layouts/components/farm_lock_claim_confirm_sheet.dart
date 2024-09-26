/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/consent_uri.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/amount_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_claim/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_claim/layouts/components/farm_lock_claim_confirm_infos.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_detail_card.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockClaimConfirmSheet extends ConsumerStatefulWidget {
  const FarmLockClaimConfirmSheet({super.key});

  @override
  ConsumerState<FarmLockClaimConfirmSheet> createState() =>
      FarmLockClaimConfirmSheetState();
}

class FarmLockClaimConfirmSheetState
    extends ConsumerState<FarmLockClaimConfirmSheet>
    implements SheetSkeletonInterface {
  bool consentChecked = false;

  @override
  Widget build(BuildContext context) {
    final accountSelected = ref.watch(
      AccountProviders.accounts.select(
        (accounts) => accounts.valueOrNull?.selectedAccount,
      ),
    );

    if (accountSelected == null) return const SizedBox();

    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final farmLockClaim =
        ref.watch(FarmLockClaimFormProvider.farmLockClaimForm);
    return Row(
      children: <Widget>[
        AppButtonTinyConnectivity(
          AppLocalizations.of(context)!.btn_confirm_farm_lock_claim,
          Dimens.buttonBottomDimens,
          key: const Key('farmLockClaim'),
          onPressed: () async {
            await ref
                .read(FarmLockClaimFormProvider.farmLockClaimForm.notifier)
                .claim(context, ref);
          },
          disabled:
              (!consentChecked && farmLockClaim.consentDateTime == null) ||
                  farmLockClaim.isProcessInProgress,
          showProgressIndicator: farmLockClaim.isProcessInProgress,
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final farmLockClaimNotifier =
        ref.watch(FarmLockClaimFormProvider.farmLockClaimForm.notifier);

    return SheetAppBar(
      title: localizations.farmLockClaimConfirmTitle,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          farmLockClaimNotifier.setFarmLockClaimProcessStep(
            aedappfm.ProcessStep.form,
          );
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final farmLockClaim =
        ref.watch(FarmLockClaimFormProvider.farmLockClaimForm);
    if (farmLockClaim.rewardAmount == null) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const FarmLockClaimConfirmInfos(),
        const SizedBox(
          height: 20,
        ),
        if (farmLockClaim.consentDateTime == null)
          aedappfm.ConsentToCheck(
            consentChecked: consentChecked,
            onToggleConsent: (newValue) {
              setState(() {
                consentChecked = newValue!;
              });
            },
            uriPrivacyPolicy: kURIPrivacyPolicy,
            uriTermsOfUse: kURITermsOfUse,
          )
        else
          aedappfm.ConsentAlready(
            consentDateTime: farmLockClaim.consentDateTime!,
            uriPrivacyPolicy: kURIPrivacyPolicy,
            uriTermsOfUse: kURITermsOfUse,
          ),
        SheetDetailCard(
          children: [
            Text(
              localizations.estimatedTxFees,
              style: AppTextStyles.bodyMedium(context),
            ),
            Text(
              AmountFormatters.standardSmallValue(
                farmLockClaim.feesEstimatedUCO,
                'UCO',
              ),
              style: AppTextStyles.bodyMedium(context),
            ),
          ],
        ),
      ],
    );
  }
}
