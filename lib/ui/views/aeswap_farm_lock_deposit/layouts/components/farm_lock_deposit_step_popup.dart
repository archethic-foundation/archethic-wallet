import 'package:aewallet/application/step.dart';
import 'package:aewallet/domain/models/step.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/widgets/components/icon_widget.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockDepositStepPopup extends ConsumerStatefulWidget {
  const FarmLockDepositStepPopup({super.key});

  @override
  ConsumerState<FarmLockDepositStepPopup> createState() =>
      _FarmLockDepositStepPopupState();
}

class _FarmLockDepositStepPopupState
    extends ConsumerState<FarmLockDepositStepPopup> {
  @override
  Widget build(BuildContext context) {
    final stepsState = ref.watch(stepsNotifierProvider);
    final localizations = AppLocalizations.of(context)!;

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _getStepIcon(step.stepIndex),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: _getStepLabel(
                              step.stepIndex,
                            ),
                          ),
                        ],
                      ),
                      _getStepStatusIcon(step.status),
                    ],
                  ),
                  if (step.reason != null)
                    Text(
                      step.reason!,
                      style: Theme.of(context).textTheme.bodySmallWithOpacity,
                    ),
                ],
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (stepsState.steps
                        .any((step) => step.status == StepStatus.failed) ||
                    stepsState.steps[2].status == StepStatus.completed)
                  BtnPrimary(
                    buttonText: localizations.close,
                    onTap: () {
                      context.pop();
                    },
                    btnPrimaryType: stepsState.steps
                            .any((step) => step.status == StepStatus.failed)
                        ? BtnPrimaryType.outlinePrimary
                        : BtnPrimaryType.primary,
                  )
                else
                  const SizedBox.shrink(),
                if (stepsState.steps
                    .any((step) => step.status == StepStatus.failed))
                  BtnPrimary(
                    buttonText: localizations.retryBtn,
                    onTap: () {},
                  ),
              ],
            ),
          ),
        ],
      ),
      popupTitle: localizations.addFundsStepPopupTitle,
      displayCloseButton: false,
    );
  }

  Widget _getStepLabel(int stepIndex) {
    final localizations = AppLocalizations.of(context)!;

    switch (stepIndex) {
      case 0:
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: localizations.addFundsStep11,
                style: Theme.of(context)
                    .textTheme
                    .bodySmallWithOpacity
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: localizations.addFundsStep12,
                style: Theme.of(context).textTheme.bodySmallWithOpacity,
              ),
            ],
          ),
        );

      case 1:
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: localizations.addFundsStep21,
                style: Theme.of(context)
                    .textTheme
                    .bodySmallWithOpacity
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: localizations.addFundsStep22,
                style: Theme.of(context).textTheme.bodySmallWithOpacity,
              ),
            ],
          ),
        );
      case 2:
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: localizations.addFundsStep31,
                style: Theme.of(context)
                    .textTheme
                    .bodySmallWithOpacity
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: localizations.addFundsStep32,
                style: Theme.of(context).textTheme.bodySmallWithOpacity,
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
        return const GradientIcon(
          icon: Icon(
            Icons.looks_one_outlined,
            size: 14,
          ),
        );
      case 1:
        return const GradientIcon(
          icon: Icon(
            Icons.looks_two_outlined,
            size: 14,
          ),
        );
      case 2:
        return const GradientIcon(
          icon: Icon(
            Icons.looks_3_outlined,
            size: 14,
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _getStepStatusIcon(StepStatus status) {
    switch (status) {
      case StepStatus.pending:
      case StepStatus.inProgress:
        return const SizedBox(
          width: 10,
          height: 10,
          child: CircularProgressIndicator(
            strokeWidth: 0.5,
          ),
        );
      case StepStatus.completed:
        return const Padding(
          padding: EdgeInsets.only(left: 4),
          child: Icon(
            Icons.done_all,
            color: Color(0xFF00B67A),
            size: 14,
          ),
        );
      case StepStatus.failed:
        return const Padding(
          padding: EdgeInsets.only(left: 4),
          child: Icon(
            Icons.error_outline,
            color: Color(0xFFFF4800),
            size: 14,
          ),
        );
    }
  }
}
