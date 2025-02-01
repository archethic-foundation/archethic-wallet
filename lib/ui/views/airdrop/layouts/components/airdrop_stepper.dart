import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme_base.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/bloc/state.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropStepper extends ConsumerWidget {
  const AirdropStepper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final airdropForm = ref.watch(airdropFormNotifierProvider);
    final activeStep = airdropForm.airdropProcessStep ==
            AirdropProcessStep.joinWaitlist
        ? 1
        : airdropForm.airdropProcessStep == AirdropProcessStep.confirmEmail ||
                airdropForm.airdropProcessStep == AirdropProcessStep.sign
            ? 2
            : 3;
    return SizedBox(
      height: 90,
      child: EasyStepper(
        activeStep: activeStep,
        internalPadding: 0,
        borderThickness: 0,
        lineStyle: LineStyle(
          lineLength: 50,
          lineType: LineType.normal,
          lineSpace: 0,
          lineWidth: 20,
          activeLineColor: ArchethicThemeBase.neutral800,
          defaultLineColor: ArchethicThemeBase.neutral800,
          unreachedLineColor: ArchethicThemeBase.neutral800,
          finishedLineColor: ArchethicThemeBase.blue400,
        ),
        stepRadius: 28,
        finishedStepBackgroundColor: Colors.transparent,
        showLoadingAnimation: false,
        steps: [
          EasyStep(
            customStep: CircleAvatar(
              radius: 20,
              backgroundColor: activeStep >= 1
                  ? ArchethicThemeBase.blue400
                  : ArchethicThemeBase.neutral800,
              child: Text('1', style: AppTextStyles.bodyLarge(context)),
            ),
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 20,
              backgroundColor: activeStep >= 2
                  ? ArchethicThemeBase.blue400
                  : ArchethicThemeBase.neutral800,
              child: Text('2', style: AppTextStyles.bodyLarge(context)),
            ),
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 20,
              backgroundColor: activeStep >= 3
                  ? ArchethicThemeBase.blue400
                  : ArchethicThemeBase.neutral800,
              child: Text('3', style: AppTextStyles.bodyLarge(context)),
            ),
          ),
        ],
      ),
    );
  }
}
