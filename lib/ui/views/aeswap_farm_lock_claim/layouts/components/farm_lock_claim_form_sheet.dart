import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/failure_message.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/fiat_value.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_claim/bloc/provider.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockClaimFormSheet extends ConsumerWidget
    implements SheetSkeletonInterface {
  const FarmLockClaimFormSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSelected = ref.watch(
      accountsNotifierProvider.select(
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
    final localizations = AppLocalizations.of(context)!;
    final farmLockClaim = ref.watch(farmLockClaimFormNotifierProvider);
    return BtnFooterPrimary(
      buttonText: localizations.btn_farm_lock_claim,
      key: const Key('farmLockClaim'),
      onTap: () async {
        await ref
            .read(
              farmLockClaimFormNotifierProvider.notifier,
            )
            .validateForm();
      },
      isLocked: !farmLockClaim.isControlsOk,
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return SheetAppBar(
      title: localizations.farmLockClaimFormTitle,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.pop();
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final farmLockClaim = ref.watch(farmLockClaimFormNotifierProvider);
    if (farmLockClaim.rewardAmount == null) {
      return const Padding(
        padding: EdgeInsets.only(top: 60, bottom: 60),
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 0.5),
        ),
      );
    }

    final localizations = AppLocalizations.of(context)!;
    final boldBodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontWeight: FontWeightTelegraf.fontWeightBold);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.farmLockClaimTitle,
                style: boldBodyLarge,
              ),
              const SizedBox(height: 10),
              Text(
                localizations.farmLockClaimDesc,
                style: Theme.of(context).textTheme.bodyMediumWithOpacity,
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<String>(
                    future: FiatValue().display(
                      ref,
                      farmLockClaim.rewardToken!,
                      farmLockClaim.rewardAmount!,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    '${farmLockClaim.rewardAmount!.formatNumber(precision: 8)} ${farmLockClaim.rewardToken!.symbol}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMediumWithOpacity
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              TextSpan(
                                text: ' ${snapshot.data} ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMediumWithOpacity,
                              ),
                              TextSpan(
                                text: AppLocalizations.of(context)!
                                    .farmLockClaimFormText,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMediumWithOpacity,
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  aedappfm.ErrorMessage(
                    failure: farmLockClaim.failure,
                    failureMessage: FailureMessage(
                      context: context,
                      failure: farmLockClaim.failure,
                    ).getMessage(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
