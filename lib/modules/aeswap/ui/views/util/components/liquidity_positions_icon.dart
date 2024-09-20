/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityPositionsIcon extends ConsumerWidget {
  const LiquidityPositionsIcon({
    required this.lpTokenInUserBalance,
    this.iconSize = 14,
    this.withLabel = false,
    super.key,
  });

  final bool lpTokenInUserBalance;
  final double iconSize;
  final bool withLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (lpTokenInUserBalance == false) {
      return const SizedBox(
        height: 16,
      );
    }
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 3,
            right: 3,
          ),
          child: Tooltip(
            message:
                AppLocalizations.of(context)!.liquidityPositionsIconTooltip,
            child: Icon(
              aedappfm.Iconsax.receipt,
              color: aedappfm.ArchethicThemeBase.systemInfo500,
              size: iconSize,
            ),
          ),
        ),
      ],
    );
  }
}
