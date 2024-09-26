import 'dart:ui';

import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_pair_icons.dart';
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
    required this.farmLock,
    super.key,
  });

  final DexFarmLock farmLock;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.trackpad,
            },
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                            token1Address:
                                farmLock.lpTokenPair!.token1.address == null
                                    ? 'UCO'
                                    : farmLock.lpTokenPair!.token1.address!,
                            token2Address:
                                farmLock.lpTokenPair!.token2.address == null
                                    ? 'UCO'
                                    : farmLock.lpTokenPair!.token2.address!,
                            iconSize: 22,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                  FarmLockDetailsInfoTokenReward(farmLock: farmLock),
                  FarmLockDetailsInfoAddressFarm(farmLock: farmLock),
                  FarmLockDetailsInfoAddressLP(farmLock: farmLock),
                  FarmLockDetailsInfoPeriod(farmLock: farmLock),
                  FarmLockDetailsInfoRemainingReward(farmLock: farmLock),
                  FarmLockDetailsInfoDistributedRewards(farmLock: farmLock),
                  FarmLockDetailsInfoLPDeposited(
                    farmLock: farmLock,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: SelectableText(
                      AppLocalizations.of(context)!.levelsInfo,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                  ),
                  ...farmLock.stats.entries.map(
                    (entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: FarmLockDetailsLevelSingle(
                          farmLock: farmLock,
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
      ),
    );
  }
}
