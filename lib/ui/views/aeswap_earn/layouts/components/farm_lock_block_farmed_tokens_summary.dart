import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/block_info.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/state.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/earn_farm_lock_list_locks.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockBlockFarmedTokensSummary extends ConsumerWidget {
  const FarmLockBlockFarmedTokensSummary({
    required this.width,
    required this.height,
    super.key,
  });

  final double width;
  final double height;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    const opacity = AppTextStyles.kOpacityText;
    final earnForm =
        ref.watch(earnFormNotifierProvider).value ?? const EarnFormState();
    return BlockInfo(
      info: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Column(
            children: [
              Row(
                children: [
                  SelectableText(
                    AppLocalizations.of(context)!
                        .farmLockBlockFarmedTokensSummaryHeader,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: aedappfm.AppThemeBase.secondaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Opacity(
                    opacity: opacity,
                    child: SelectableText(
                      '\$${earnForm.farmedTokensInFiat.formatNumber(precision: 2)}',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Opacity(
                        opacity: AppTextStyles.kOpacityText,
                        child: SelectableText(
                          '${AppLocalizations.of(context)!.farmLockBlockFarmedTokensSummaryCapitalInvestedLbl}: ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Opacity(
                        opacity: opacity,
                        child: SelectableText(
                          '\$${earnForm.farmedTokensCapitalInFiat.formatNumber(precision: 2)}',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: aedappfm.AppThemeBase.secondaryColor,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Opacity(
                        opacity: AppTextStyles.kOpacityText,
                        child: SelectableText(
                          '${AppLocalizations.of(context)!.farmLockBlockFarmedTokensSummaryCapitalRewardsEarnedLbl}: ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Opacity(
                        opacity: opacity,
                        child: Row(
                          children: [
                            SelectableText(
                              '\$${earnForm.farmedTokensRewardsInFiat.formatNumber(precision: 2)} ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: aedappfm.AppThemeBase.secondaryColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Opacity(
                opacity: opacity,
                child: SelectableText(
                  '(= ${earnForm.farmedTokensRewards.formatNumber(precision: 4)} UCO)',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
          if (earnForm.farmLock != null && earnForm.pool != null)
            EarnFarmLockListLocks(
              farmLock: earnForm.farmLock,
              pool: earnForm.pool!,
            ),
        ],
      ),
      width: width,
      height: height,
      backgroundWidget: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: AssetImage(
              'assets/themes/archethic/coin-img.png',
            ),
            fit: BoxFit.fitHeight,
            alignment: Alignment.centerRight,
            opacity: 0.2,
          ),
        ),
      ),
    );
  }
}
