import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/state.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/farm_lock_block_list_single_line_lock.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class FarmLockBlockFarmedTokensSummary extends ConsumerWidget {
  const FarmLockBlockFarmedTokensSummary({
    required this.width,
    super.key,
  });

  final double width;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return ref.watch(farmLockFormSummaryProvider).when(
          skipLoadingOnReload: true,
          skipLoadingOnRefresh: true,
          error: (error, stackTrace) {
            return const SizedBox.shrink();
          },
          loading: () {
            return const SizedBox.shrink();
          },
          data: (farmLockFormSummary) {
            if (farmLockFormSummary.farmedTokensInFiat == 0 &&
                farmLockFormSummary.farmedTokensCapital == 0 &&
                farmLockFormSummary.farmedTokensRewards == 0) {
              return const SizedBox.shrink();
            }
            return _buildContent(
              context,
              ref,
              farmLockFormSummary,
            );
          },
        );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    FarmLockFormSummary farmLockFormSummary,
  ) {
    final farmLock = ref.watch(farmLockFormFarmLockProvider).valueOrNull;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: aedappfm.BlockInfo(
        paddingEdgeInsetsInfo: const EdgeInsets.all(20),
        info: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!
                      .farmLockBlockFarmedTokensSummaryHeader,
                  style: AppTextStyles.bodyLargeSecondaryColor(context),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            _blockInfo(context, ref, farmLockFormSummary),
            const SizedBox(height: 10),
            if (farmLock != null && farmLock.userInfos.entries.isNotEmpty)
              BtnPrimary(
                buttonText:
                    AppLocalizations.of(context)!.farmLockTokensSummaryMoreInfo,
                onTap: farmLock.userInfos.entries.isEmpty
                    ? null
                    : () async {
                        await CupertinoScaffold.showCupertinoModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return FractionallySizedBox(
                              heightFactor: 1,
                              child: Scaffold(
                                backgroundColor: aedappfm
                                    .AppThemeBase.sheetBackground
                                    .withValues(alpha: 0.2),
                                body: const FarmLockBlockListSingleLineLock(),
                              ),
                            );
                          },
                        );
                      },
              ),
          ],
        ),
        width: width,
        backgroundWidget: Positioned.fill(
          top: -60,
          left: -300,
          child: Transform.rotate(
            angle: -10 * 3.14 / 180,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Opacity(
                opacity: 0.2,
                child: Image.asset(
                  'assets/themes/archethic/logo_crystal.png',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _blockInfo(
    BuildContext context,
    WidgetRef ref,
    FarmLockFormSummary? summary,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  r'$',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                if (summary == null)
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    ),
                  )
                else
                  Text(
                    summary.farmedTokensInFiat.formatNumber(precision: 2),
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontWeight: FontWeight.bold),
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
                  child: Text(
                    '${AppLocalizations.of(context)!.farmLockBlockFarmedTokensSummaryCapitalInvestedLbl}: ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                if (summary == null)
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: SizedBox(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator(
                        strokeWidth: 0.5,
                      ),
                    ),
                  )
                else
                  Text(
                    '\$${summary.farmedTokensCapitalInFiat.formatNumber(precision: 2)}',
                    style: Theme.of(context).textTheme.bodyMediumWithOpacity,
                  ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  '${AppLocalizations.of(context)!.farmLockBlockFarmedTokensSummaryCapitalRewardsEarnedLbl}: ',
                  style: AppTextStyles.bodyLarge(context),
                ),
                if (summary == null)
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: SizedBox(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator(
                        strokeWidth: 0.5,
                      ),
                    ),
                  )
                else
                  Text(
                    '\$${summary.farmedTokensRewardsInFiat.formatNumber(precision: 2)}',
                    style: AppTextStyles.bodyLargeSecondaryColor(context)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 3,
        ),
        if (summary != null)
          if (summary.farmedTokensRewards > 0)
            Text(
              '(= ${summary.farmedTokensRewards.formatNumber(precision: 4)} UCO)',
              style: AppTextStyles.bodySmallWithOpacity(context),
            )
          else
            const SizedBox.shrink()
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
