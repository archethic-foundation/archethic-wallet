import 'dart:async';

import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/application/step.dart';
import 'package:aewallet/domain/models/step.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_withdraw/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_withdraw/layouts/components/farm_lock_withdraw_confirm_privacy_policy.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_withdraw/layouts/components/farm_lock_withdraw_step_popup.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockWithdrawConfirmSheetUCO extends ConsumerWidget
    implements SheetSkeletonInterface {
  const FarmLockWithdrawConfirmSheetUCO({
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
    final farmLockWithdraw = ref.watch(farmLockWithdrawFormNotifierProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BtnFooterPrimary(
          buttonText: AppLocalizations.of(context)!.btn_confirm_farm_withdraw,
          key: const Key('farmLockWithdraw'),
          onTap: () async {
            final farmLockWithdrawNotifier = ref.read(
              farmLockWithdrawFormNotifierProvider.notifier,
            )..setProcessInProgress(true);

            ref.read(stepsNotifierProvider.notifier)
              ..initializeSteps(3)
              ..updateStepStatus(0, StepStatus.inProgress);

            unawaited(
              farmLockWithdrawNotifier.withdraw(AppLocalizations.of(context)!),
            );

            await showDialog<bool>(
              barrierDismissible: false,
              useRootNavigator: false,
              context: context,
              builder: (context) {
                return const FarmLockWithdrawStepPopup();
              },
            );
          },
          isLocked: (!farmLockWithdraw.confirmPrivacyPolicy) ||
              farmLockWithdraw.isProcessInProgress,
          showProgressIndicator: farmLockWithdraw.isProcessInProgress,
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final farmLockWithdrawNotifier =
        ref.watch(farmLockWithdrawFormNotifierProvider.notifier);

    return SheetAppBar(
      title: localizations.farmLockWithdrawFormTitleBeginner,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          farmLockWithdrawNotifier
            ..setFarmLockWithdrawProcessStep(
              aedappfm.ProcessStep.form,
            )
            ..setConfirmPrivacyPolicy(false)
            ..setFailure(null);
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

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
                                      .farmLockWithdrawLPItem1Desc1,
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
                                      .farmLockWithdrawLPItem1Desc2,
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
                                      .farmLockWithdrawLPItem2Desc1,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: localizations
                                      .farmLockWithdrawLPItem2Desc2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight:
                                            FontWeightTelegraf.fontWeightBold,
                                      ),
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
                                      .farmLockWithdrawLPItem3Desc1,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: localizations
                                      .farmLockWithdrawLPItem3Desc2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight:
                                            FontWeightTelegraf.fontWeightBold,
                                      ),
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
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const FarmLockWithdrawConfirmPrivacyPolicy(),
      ],
    );
  }
}
