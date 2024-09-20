import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_pair_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockDetailsInfoHeader extends ConsumerWidget {
  const FarmLockDetailsInfoHeader({
    super.key,
    required this.farmLock,
  });

  final DexFarmLock farmLock;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SelectableText(
                  '${farmLock.lpTokenPair!.token1.symbol}/${farmLock.lpTokenPair!.token2.symbol}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: DexPairIcons(
                    token1Address: farmLock.lpTokenPair!.token1.address == null
                        ? 'UCO'
                        : farmLock.lpTokenPair!.token1.address!,
                    token2Address: farmLock.lpTokenPair!.token2.address == null
                        ? 'UCO'
                        : farmLock.lpTokenPair!.token2.address!,
                    iconSize: 22,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
