import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_pair_icons.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/liquidity_positions_icon.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/pool_farm_available.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/pool_favorite_icon.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/verified_pool_icon.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsInfoHeader extends ConsumerWidget {
  const PoolDetailsInfoHeader({
    super.key,
    required this.pool,
    this.displayPoolFarmAvailable = false,
  });

  final DexPool? pool;
  final bool displayPoolFarmAvailable;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final env = ref.read(SettingsProviders.settings).network.getNetworkLabel();
    final contextAddresses = PoolFarmAvailableState().getContextAddresses(env);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Tooltip(
                  message: pool!.pair.token1.symbol,
                  child: SelectableText(
                    pool!.pair.token1.symbol.reduceSymbol(lengthMax: 6),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SelectableText('/'),
                Tooltip(
                  message: pool!.pair.token2.symbol,
                  child: SelectableText(
                    pool!.pair.token2.symbol.reduceSymbol(lengthMax: 6),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: DexPairIcons(
                    token1Address: pool!.pair.token1.address == null
                        ? 'UCO'
                        : pool!.pair.token1.address!,
                    token2Address: pool!.pair.token2.address == null
                        ? 'UCO'
                        : pool!.pair.token2.address!,
                    iconSize: 22,
                  ),
                ),
              ],
            ),
            if (displayPoolFarmAvailable &&
                contextAddresses.aeETHUCOPoolAddress.toUpperCase() ==
                    pool!.poolAddress.toUpperCase())
              const PoolFarmAvailable(),
          ],
        ),
        Row(
          children: [
            VerifiedPoolIcon(
              isVerified: pool!.isVerified,
            ),
            LiquidityPositionsIcon(
              lpTokenInUserBalance: pool!.lpTokenInUserBalance,
            ),
            LiquidityFavoriteIcon(
              isFavorite: pool!.isFavorite,
            ),
          ],
        ),
      ],
    );
  }
}
