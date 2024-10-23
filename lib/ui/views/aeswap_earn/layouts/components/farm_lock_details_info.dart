import 'dart:ui';

import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_pair_icons.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/farm_lock_details_info_address_farm.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/farm_lock_details_info_address_lp.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/farm_lock_details_info_distributed_rewards.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/farm_lock_details_info_lp_deposited.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/farm_lock_details_info_period.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/farm_lock_details_info_remaining_reward.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/farm_lock_details_info_token_reward.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/farm_lock_details_level_single.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockDetailsInfo extends ConsumerWidget {
  const FarmLockDetailsInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmLock = ref.watch(farmLockFormFarmLockProvider).value;
    if (farmLock == null) return const SizedBox.shrink();

    return ClipRRect(
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
          },
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 40),
          child: aedappfm.ArchethicScrollbar(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SelectableText(
                            '${farmLock.lpTokenPair!.token1.symbol}/${farmLock.lpTokenPair!.token2.symbol}',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        DexPairIcons(
                          token1Address: farmLock.lpTokenPair!.token1.address,
                          token2Address: farmLock.lpTokenPair!.token2.address,
                          iconSize: 22,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ],
                ),
                const FarmLockDetailsInfoTokenReward(),
                const FarmLockDetailsInfoAddressFarm(),
                const FarmLockDetailsInfoAddressLP(),
                const FarmLockDetailsInfoPeriod(),
                const FarmLockDetailsInfoRemainingReward(),
                const FarmLockDetailsInfoDistributedRewards(),
                const FarmLockDetailsInfoLPDeposited(),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: SelectableText(
                    AppLocalizations.of(context)!.levelsInfo,
                    style: AppTextStyles.bodyMedium(context)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                ...farmLock.stats.entries.map(
                  (entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: FarmLockDetailsLevelSingle(
                        level: entry.key,
                        farmLockStats: entry.value,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
