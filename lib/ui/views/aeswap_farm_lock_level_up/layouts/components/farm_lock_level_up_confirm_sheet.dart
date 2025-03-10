/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/failure_message.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/farm_lock_duration_type.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/complex/estimated_fees.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/figma_components/text/gradient_text.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_level_up/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_level_up/layouts/components/farm_lock_level_up_confirm_lock_period.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_level_up/layouts/components/farm_lock_level_up_confirm_privacy_policy.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_level_up/layouts/components/farm_lock_level_up_result_sheet.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockLevelUpConfirmSheet extends ConsumerStatefulWidget {
  const FarmLockLevelUpConfirmSheet({super.key});

  @override
  ConsumerState<FarmLockLevelUpConfirmSheet> createState() =>
      FarmLockLevelUpConfirmSheetState();
}

class FarmLockLevelUpConfirmSheetState
    extends ConsumerState<FarmLockLevelUpConfirmSheet>
    implements SheetSkeletonInterface {
  bool consentChecked = false;
  bool warningChecked = false;

  @override
  void initState() {
    final farmLockLevelUp = ref.read(farmLockLevelUpFormNotifierProvider);
    if (farmLockLevelUp.farmLockLevelUpDuration ==
        FarmLockDepositDurationType.flexible) {
      warningChecked = true;
    }
    super.initState();
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final farmLockLevelUp = ref.watch(farmLockLevelUpFormNotifierProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        EstimatedFees(
          AsyncData(farmLockLevelUp.feesEstimatedUCO),
        ),
        BtnFooterPrimary(
          buttonText: AppLocalizations.of(context)!.btn_confirm_farm_add_lock,
          key: const Key('farmLockLevelUp'),
          onTap: () async {
            final farmLockLevelUpNotifier = ref.read(
              farmLockLevelUpFormNotifierProvider.notifier,
            )..setProcessInProgress(true);
            final resultOk = await farmLockLevelUpNotifier
                .lock(AppLocalizations.of(context)!);
            farmLockLevelUpNotifier.setProcessInProgress(false);
            if (resultOk) {
              await context.push(FarmLockLevelUpResultSheet.routerPage);
            } else {
              UIUtil.showSnackbar(
                FailureMessage(
                  context: context,
                  failure:
                      ref.read(farmLockLevelUpFormNotifierProvider).failure,
                ).getMessage(),
                context,
                ref,
                ArchethicTheme.text,
                ArchethicTheme.snackBarShadow,
                duration: const Duration(seconds: 5),
              );
            }
          },
          isLocked: (!farmLockLevelUp.confirmLockPeriod ||
                  !farmLockLevelUp.confirmPrivacyPolicy) ||
              farmLockLevelUp.isProcessInProgress,
          showProgressIndicator: farmLockLevelUp.isProcessInProgress,
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final farmLockLevelUpNotifier =
        ref.read(farmLockLevelUpFormNotifierProvider.notifier);

    return SheetAppBar(
      title: localizations.farmLockLevelUpConfirmTitle,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          farmLockLevelUpNotifier
            ..setFarmLockLevelUpProcessStep(
              aedappfm.ProcessStep.form,
            )
            ..setFailure(null);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountSelected = ref.read(
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
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final farmLockLevelUp = ref.read(farmLockLevelUpFormNotifierProvider);
    if (farmLockLevelUp.pool == null) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        aedappfm.BlockInfo(
          blockInfoColor: aedappfm.BlockInfoColor.purple,
          borderWidth: 0,
          paddingEdgeInsetsInfo: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          info: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!
                          .farmLockDepositConfirmInfosText,
                      style: Theme.of(context).textTheme.bodyMediumWithOpacity,
                    ),
                    TextSpan(
                      text:
                          '${farmLockLevelUp.amount.formatNumber(precision: 8)} ${farmLockLevelUp.amount > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeightTelegraf.fontWeightBold,
                          ),
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!
                          .farmLockDepositConfirmInfosText2,
                      style: Theme.of(context).textTheme.bodyMediumWithOpacity,
                    ),
                    TextSpan(
                      text: getFarmLockDepositDurationTypeLabel(
                        context,
                        farmLockLevelUp.farmLockLevelUpDuration,
                      ).toLowerCase(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeightTelegraf.fontWeightBold,
                          ),
                    ),
                    TextSpan(
                      text: '.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      child: Text(
                        AppLocalizations.of(context)!
                            .farmLockDepositConfirmInfosText3,
                        style:
                            Theme.of(context).textTheme.bodyMediumWithOpacity,
                      ),
                    ),
                    WidgetSpan(
                      child: GradientText(
                        '${((farmLockLevelUp.farmLock!.stats[farmLockLevelUp.level]?.aprEstimation ?? 0) * 100).formatNumber(precision: 2)}%',
                        gradient: ArchethicGradients.gradientArchethic,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeightTelegraf.fontWeightBold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const FarmLockLevelUpConfirmLockPeriod(),
        const SizedBox(height: 20),
        const FarmLockLevelUpConfirmPrivacyPolicy(),
      ],
    );
  }
}
