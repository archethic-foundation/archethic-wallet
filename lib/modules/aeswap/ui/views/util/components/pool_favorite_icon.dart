import 'package:aewallet/modules/aeswap/application/pool/dex_pool.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityFavoriteIcon extends ConsumerWidget {
  const LiquidityFavoriteIcon({
    required this.poolAddress,
    this.iconSize = 14,
    super.key,
  });

  final String poolAddress;
  final double iconSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref
            .watch(
              DexPoolProviders.poolFavorite(poolAddress),
            )
            .value ??
        false;
    if (isFavorite == false) {
      return const SizedBox(
        height: 16,
      );
    }
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: Tooltip(
            message: AppLocalizations.of(context)!.liquidityFavoriteIconTooltip,
            child: Icon(
              aedappfm.Iconsax.star,
              color: aedappfm.ArchethicThemeBase.systemWarning600,
              size: iconSize,
            ),
          ),
        ),
      ],
    );
  }
}
