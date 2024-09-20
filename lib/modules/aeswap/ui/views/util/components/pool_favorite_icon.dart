import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class LiquidityFavoriteIcon extends StatelessWidget {
  const LiquidityFavoriteIcon({
    required this.isFavorite,
    this.iconSize = 14,
    super.key,
  });

  final bool isFavorite;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
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
