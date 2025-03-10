import 'dart:async';

import 'package:aewallet/application/step.dart';
import 'package:aewallet/domain/models/step.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/failure_message.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/figma_components/message_box/message_box.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_withdraw/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockWithdrawStepPopup extends ConsumerWidget {
  const FarmLockWithdrawStepPopup({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final stepsState = ref.watch(stepsNotifierProvider);
    final localizations = AppLocalizations.of(context)!;
    final farmLockWithdraw = ref.watch(farmLockWithdrawFormNotifierProvider);

    return aedappfm.PopupTemplate(
      popupContent: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...stepsState.steps.asMap().entries.map((entry) {
            final step = entry.value;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.10,
                            child: _getStepIcon(step.stepIndex),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.85,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _getStepLabel(
                                    context,
                                    step.stepIndex,
                                  ),
                                  if (step.failure != null)
                                    Text(
                                      FailureMessage(
                                        context: context,
                                        failure: step.failure,
                                      ).getMessage(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: const Color(0xFFFF4800),
                                          ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.05,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: _getStepStatusIcon(step.status),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          }),
          if (farmLockWithdraw.failure == null &&
              farmLockWithdraw.finalAmountWithdraw != null)
            MessageBox(
              messageBoxType: MessageBoxType.success,
              content: Text.rich(
                TextSpan(
                  text: '',
                  children: <InlineSpan>[
                    TextSpan(
                      text: localizations
                          .withdrawFundsStepPopupFinalAmountWithRewardDesc1,
                      style: Theme.of(context).textTheme.bodySmallWithOpacity,
                    ),
                    TextSpan(
                      text:
                          '${farmLockWithdraw.finalAmountWithdraw!.formatNumber(
                        precision:
                            farmLockWithdraw.finalAmountWithdraw! < 1 ? 8 : 2,
                      )} ${aedappfm.ucoToken.symbol}',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeightTelegraf.fontWeightBold,
                          ),
                    ),
                    TextSpan(
                      text: localizations
                          .withdrawFundsStepPopupFinalAmountWithRewardDesc2,
                      style: Theme.of(context).textTheme.bodySmallWithOpacity,
                    ),
                    TextSpan(
                      text: '${farmLockWithdraw.finalAmountReward!.formatNumber(
                        precision:
                            farmLockWithdraw.finalAmountReward! < 1 ? 8 : 2,
                      )} ${aedappfm.ucoToken.symbol}',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeightTelegraf.fontWeightBold,
                          ),
                    ),
                    TextSpan(
                      text: localizations
                          .withdrawFundsStepPopupFinalAmountWithRewardDesc3,
                      style: Theme.of(context).textTheme.bodySmallWithOpacity,
                    ),
                  ],
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (stepsState.steps
                      .any((step) => step.status == StepStatus.failed) ||
                  (stepsState.steps.length == 3 &&
                      stepsState.steps[2].status == StepStatus.completed))
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: BtnPrimary(
                      buttonText: localizations.close,
                      onTap: () {
                        context
                          ..pop()
                          ..pop();
                      },
                      btnPrimaryType: stepsState.steps
                              .any((step) => step.status == StepStatus.failed)
                          ? BtnPrimaryType.outlinePrimary
                          : BtnPrimaryType.primary,
                      widthExpanded: true,
                    ),
                  ),
                )
              else
                const SizedBox.shrink(),
              if (stepsState.steps
                  .any((step) => step.status == StepStatus.failed))
                const SizedBox(
                  width: 20,
                ),
              if (stepsState.steps
                  .any((step) => step.status == StepStatus.failed))
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: BtnPrimary(
                      buttonText: localizations.resumeBtn,
                      onTap: () {
                        unawaited(
                          ref
                              .read(
                                farmLockWithdrawFormNotifierProvider.notifier,
                              )
                              .withdraw(AppLocalizations.of(context)!),
                        );
                      },
                      widthExpanded: true,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      popupTitle: localizations.withdrawFundsStepPopupTitle,
      displayCloseButton: false,
    );
  }

  Widget _getStepLabel(BuildContext context, int stepIndex) {
    final localizations = AppLocalizations.of(context)!;

    switch (stepIndex) {
      case 0:
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: localizations.withdrawFundsStep11,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeightTelegraf.fontWeightBold),
              ),
              TextSpan(
                text: localizations.withdrawFundsStep12,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );

      case 1:
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: localizations.withdrawFundsStep21,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeightTelegraf.fontWeightBold),
              ),
              TextSpan(
                text: localizations.withdrawFundsStep22,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      case 2:
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: localizations.withdrawFundsStep31,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeightTelegraf.fontWeightBold),
              ),
              TextSpan(
                text: localizations.withdrawFundsStep32,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _getStepIcon(int stepIndex) {
    switch (stepIndex) {
      case 0:
        return const Icon(
          Icons.looks_one_outlined,
          size: 20,
        );
      case 1:
        return const Icon(
          Icons.looks_two_outlined,
          size: 20,
        );
      case 2:
        return const Icon(
          Icons.looks_3_outlined,
          size: 20,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _getStepStatusIcon(StepStatus status) {
    switch (status) {
      case StepStatus.pending:
        return const Icon(
          Icons.pending_outlined,
          color: Colors.white30,
          size: 20,
        );
      case StepStatus.inProgress:
        return const Padding(
          padding: EdgeInsets.only(
            top: 5,
          ),
          child: SizedBox(
            width: 10,
            height: 10,
            child: CircularProgressIndicator(
              strokeWidth: 0.5,
            ),
          ),
        );
      case StepStatus.completed:
        return const Icon(
          Icons.done_all,
          color: Color(0xFF00B67A),
          size: 20,
        );
      case StepStatus.failed:
        return const Icon(
          Icons.error_outline,
          color: Color(0xFFFF4800),
          size: 20,
        );
    }
  }
}
