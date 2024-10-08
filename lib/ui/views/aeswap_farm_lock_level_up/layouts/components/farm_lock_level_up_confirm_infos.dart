import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/farm_lock_duration_type.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_level_up/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockLevelUpConfirmInfos extends ConsumerWidget {
  const FarmLockLevelUpConfirmInfos({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmLockLevelUp = ref.watch(farmLockLevelUpFormNotifierProvider);
    if (farmLockLevelUp.pool == null) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: aedappfm.AppThemeBase.sheetBackgroundSecondary,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: aedappfm.AppThemeBase.sheetBorderSecondary,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!
                          .farmLockLevelUpConfirmInfosText,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    TextSpan(
                      text: farmLockLevelUp.amount.formatNumber(precision: 8),
                      style: AppTextStyles.bodyLargeSecondaryColor(context),
                    ),
                    TextSpan(
                      text:
                          ' ${farmLockLevelUp.amount > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    if (farmLockLevelUp.farmLockLevelUpDuration !=
                        FarmLockDepositDurationType.flexible)
                      TextSpan(
                        text: AppLocalizations.of(context)!
                            .farmLockLevelUpConfirmInfosText2,
                        style: AppTextStyles.bodyLarge(context),
                      ),
                    if (farmLockLevelUp.farmLockLevelUpDuration !=
                        FarmLockDepositDurationType.flexible)
                      TextSpan(
                        text: getFarmLockDepositDurationTypeLabel(
                          context,
                          farmLockLevelUp.farmLockLevelUpDuration,
                        ).toLowerCase(),
                        style: AppTextStyles.bodyLargeSecondaryColor(context),
                      ),
                    TextSpan(
                      text: '. ',
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    if (farmLockLevelUp.farmLockLevelUpDuration ==
                        FarmLockDepositDurationType.flexible)
                      TextSpan(
                        text: AppLocalizations.of(context)!
                            .farmLockLevelUpConfirmInfosText3,
                        style: AppTextStyles.bodyLarge(context),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SelectableText(
                    AppLocalizations.of(context)!.farmLockLevelUpAPRLbl,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                            context,
                            Theme.of(context).textTheme.titleLarge!,
                          ),
                        ),
                  ),
                  if (farmLockLevelUp.aprEstimation == null ||
                      farmLockLevelUp.aprEstimation! == 0)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Icon(
                        Icons.all_inclusive,
                        size: 20,
                        color: Colors.white60,
                      ),
                    )
                  else
                    SelectableText(
                      '${farmLockLevelUp.aprEstimation?.formatNumber(precision: 2)}%',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: aedappfm.AppThemeBase.secondaryColor,
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.titleLarge!,
                            ),
                          ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 300))
        .scale(duration: const Duration(milliseconds: 300));
  }
}
