import 'dart:async';

import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/application/step.dart';
import 'package:aewallet/domain/models/step.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/failure_message.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/farm_lock_duration_type.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/complex/estimated_fees.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/figma_components/text/gradient_text.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/bloc/state.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/layouts/components/farm_lock_deposit_confirm_lock_period.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/layouts/components/farm_lock_deposit_confirm_privacy_policy.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/layouts/components/farm_lock_deposit_result_sheet.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/layouts/components/farm_lock_deposit_step_popup.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockDepositConfirmSheetUCO extends ConsumerWidget
    implements SheetSkeletonInterface {
  const FarmLockDepositConfirmSheetUCO({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
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

            if (farmLockDeposit.farmLockDepositMode ==
                FarmLockDepositMode.uco) {
              ref.read(stepsNotifierProvider.notifier)
                ..initializeSteps(3)
                ..updateStepStatus(0, StepStatus.inProgress);

              unawaited(
                farmLockDepositNotifier.lock(AppLocalizations.of(context)!),
              );

              await showDialog<bool>(
                barrierDismissible: false,
                useRootNavigator: false,
                context: context,
                builder: (context) {
                  return const FarmLockDepositStepPopup();
                },
              );
            } else {
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
    final localizations = AppLocalizations.of(context)!;
    final farmLock = ref.watch(farmLockFormFarmLockProvider).valueOrNull;
    final farmLockDeposit = ref.read(farmLockDepositFormNotifierProvider);
    if (farmLockDeposit.pool == null) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.farmLockDepositConfirmUcoDesc1,
          style: Theme.of(context).textTheme.bodySmallWithOpacity,
        ),
        const SizedBox(
          height: 20,
        ),
        aedappfm.BlockInfo(
          blockInfoColor: aedappfm.BlockInfoColor.purple,
          borderWidth: 0,
          paddingEdgeInsetsInfo: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          info: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.07,
                        child: const Icon(
                          Icons.looks_one_outlined,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.93,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: localizations
                                      .farmLockDepositConfirmUcoItem1Desc1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight:
                                            FontWeightTelegraf.fontWeightBold,
                                      ),
                                ),
                                TextSpan(
                                  text: localizations
                                      .farmLockDepositConfirmUcoItem1Desc2,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.07,
                        child: const Icon(
                          Icons.looks_two_outlined,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.93,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: localizations
                                      .farmLockDepositConfirmUcoItem2Desc1,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: localizations
                                      .farmLockDepositConfirmUcoItem2Desc2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight:
                                            FontWeightTelegraf.fontWeightBold,
                                      ),
                                ),
                                TextSpan(
                                  text: localizations
                                      .farmLockDepositConfirmUcoItem2Desc3,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.07,
                        child: const Icon(
                          Icons.looks_3_outlined,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.93,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: localizations
                                      .farmLockDepositConfirmUcoItem3Desc1,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: getFarmLockDepositDurationTypeLabel(
                                    context,
                                    farmLockDeposit.farmLockDepositDuration,
                                  ).toLowerCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight:
                                            FontWeightTelegraf.fontWeightBold,
                                      ),
                                ),
                                TextSpan(
                                  text: localizations
                                      .farmLockDepositConfirmUcoItem3Desc2,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: localizations.farmLockDepositConfirmUcoDesc2,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeightTelegraf.fontWeightBold,
                          ),
                    ),
                    if (farmLock != null)
                      WidgetSpan(
                        child: GradientText(
                          '${(farmLock.apr3years * 100).formatNumber(precision: 0).replaceAll('.', '')}% ${localizations.farmLockDepositAPRLbl.replaceAll(':', '')}',
                          gradient: ArchethicGradients.gradientArchethic,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
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
        const SizedBox(
          height: 30,
        ),
        const FarmLockDepositConfirmLockPeriod(),
        const SizedBox(
          height: 20,
        ),
        const FarmLockDepositConfirmPrivacyPolicy(),
      ],
    );
  }
}
