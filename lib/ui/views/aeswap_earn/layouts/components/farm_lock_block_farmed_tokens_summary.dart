import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/block_info.dart';
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
    final farmLock = ref.watch(farmLockFormFarmLockProvider).value;
    final pool = ref.watch(farmLockFormPoolProvider).value;

    return InkWell(
      onTap:
          farmLock == null || farmLock.userInfos.entries.isEmpty || pool == null
              ? null
              : () async {
                  await CupertinoScaffold.showCupertinoModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return FractionallySizedBox(
                        heightFactor: 0.90,
                        child: Scaffold(
                          backgroundColor: aedappfm.AppThemeBase.sheetBackground
                              .withOpacity(0.2),
                          body: const FarmLockBlockListSingleLineLock(),
                        ),
                      );
                    },
                  );
                },
      child: BlockInfo(
        info: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
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
                FutureBuilder<FarmLockFormSummary>(
                  future: ref.watch(farmLockFormSummaryProvider.future),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _blockInfo(context, ref, snapshot.data);
                    } else if (snapshot.hasError) {
                      return Text('Error : ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return _blockInfo(context, ref, snapshot.data);
                    }

                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
            if (farmLock != null &&
                farmLock.userInfos.entries.isNotEmpty &&
                pool != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      AppLocalizations.of(
                        context,
                      )!
                          .farmLockTokensSummaryMoreInfo,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
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
      ),
    );
  }

  Widget _blockInfo(
    BuildContext context,
    WidgetRef ref,
    FarmLockFormSummary? summary,
  ) {
    const opacity = AppTextStyles.kOpacityText;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Opacity(
              opacity: opacity,
              child: Row(
                children: [
                  Text(
                    r'$',
                    style: Theme.of(context).textTheme.headlineLarge,
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
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                ],
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
                  child: Text(
                    '${AppLocalizations.of(context)!.farmLockBlockFarmedTokensSummaryCapitalInvestedLbl}: ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Opacity(
                  opacity: opacity,
                  child: summary == null
                      ? const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: SizedBox(
                            width: 10,
                            height: 10,
                            child: CircularProgressIndicator(
                              strokeWidth: 0.5,
                            ),
                          ),
                        )
                      : Text(
                          '\$${summary.farmedTokensCapitalInFiat.formatNumber(precision: 2)}',
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
                Text(
                  '${AppLocalizations.of(context)!.farmLockBlockFarmedTokensSummaryCapitalRewardsEarnedLbl}: ',
                  style: Theme.of(context).textTheme.bodyMedium,
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
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: aedappfm.AppThemeBase.secondaryColor,
                        ),
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
              style: Theme.of(context).textTheme.bodySmall,
            )
          else
            const SizedBox.shrink()
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
