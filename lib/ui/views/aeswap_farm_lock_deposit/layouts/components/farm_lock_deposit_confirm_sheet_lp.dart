import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/failure_message.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/farm_lock_duration_type.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/complex/estimated_fees.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/figma_components/text/gradient_text.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/layouts/components/farm_lock_deposit_confirm_lock_period.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/layouts/components/farm_lock_deposit_confirm_privacy_policy.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/layouts/components/farm_lock_deposit_result_sheet.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockDepositConfirmSheetLP extends ConsumerStatefulWidget {
  const FarmLockDepositConfirmSheetLP({
    super.key,
  });

  @override
  ConsumerState<FarmLockDepositConfirmSheetLP> createState() =>
      FarmLockDepositConfirmSheetLPState();
}

class FarmLockDepositConfirmSheetLPState
    extends ConsumerState<FarmLockDepositConfirmSheetLP>
    implements SheetSkeletonInterface {
  bool consentChecked = false;
  bool warningChecked = false;

  @override
  void initState() {
    final farmLockDeposit = ref.read(farmLockDepositFormNotifierProvider);
    if (farmLockDeposit.farmLockDepositDuration ==
        FarmLockDepositDurationType.flexible) {
      warningChecked = true;
    }
    super.initState();
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
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final farmLockDeposit = ref.watch(farmLockDepositFormNotifierProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        EstimatedFees(farmLockDeposit.feeEstimation),
        BtnFooterPrimary(
          buttonText: AppLocalizations.of(context)!.btn_confirm_farm_add_lock,
          key: const Key('farmLockDeposit'),
          onTap: () async {
            final farmLockDepositNotifier = ref.read(
              farmLockDepositFormNotifierProvider.notifier,
            )..setProcessInProgress(true);

            final resultOk = await farmLockDepositNotifier
                .lock(AppLocalizations.of(context)!);

            farmLockDepositNotifier.setProcessInProgress(false);
            if (resultOk) {
              await context.push(FarmLockDepositResultSheet.routerPage);
            } else {
              UIUtil.showSnackbar(
                FailureMessage(
                  context: context,
                  failure:
                      ref.read(farmLockDepositFormNotifierProvider).failure,
                ).getMessage(),
                context,
                ref,
                ArchethicTheme.text,
                ArchethicTheme.snackBarShadow,
                duration: const Duration(seconds: 5),
              );
            }
          },
          isLocked: (!farmLockDeposit.confirmLockPeriod ||
                  !farmLockDeposit.confirmPrivacyPolicy) ||
              farmLockDeposit.isProcessInProgress,
          showProgressIndicator: farmLockDeposit.isProcessInProgress,
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final farmLockDepositNotifier =
        ref.read(farmLockDepositFormNotifierProvider.notifier);

    return SheetAppBar(
      title: localizations.farmLockDepositFormTitle,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          farmLockDepositNotifier
            ..setFarmLockDepositProcessStep(
              aedappfm.ProcessStep.form,
            )
            ..setConfirmLockPeriod(false)
            ..setConfirmPrivacyPolicy(false)
            ..setFailure(null);
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final farmLockDeposit = ref.read(farmLockDepositFormNotifierProvider);
    if (farmLockDeposit.pool == null) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        aedappfm.BlockInfo(
          blockInfoColor: aedappfm.BlockInfoColor.purple,
          borderWidth: 0,
          paddingEdgeInsetsInfo: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          info: Column(
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
                          '${farmLockDeposit.amount.formatNumber(precision: 8)} ${farmLockDeposit.amount > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
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
                        farmLockDeposit.farmLockDepositDuration,
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
                        '${((farmLockDeposit.farmLock!.stats[farmLockDeposit.level]?.aprEstimation ?? 0) * 100).formatNumber(precision: 2)}%',
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
        const FarmLockDepositConfirmLockPeriod(),
        const SizedBox(height: 20),
        const FarmLockDepositConfirmPrivacyPolicy(),
      ],
    );
  }
}
