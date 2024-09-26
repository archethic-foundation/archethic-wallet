import 'package:aewallet/modules/aeswap/domain/models/dex_pool_infos.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolDetailsInfoSwapFees extends ConsumerWidget {
  const PoolDetailsInfoSwapFees({
    super.key,
    required this.poolInfos,
    this.style,
  });

  final DexPoolInfos? poolInfos;
  final TextStyle? style;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    if (poolInfos?.fees == 0) {
      return const SizedBox.shrink();
    }

    return Opacity(
      opacity: AppTextStyles.kOpacityText,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SelectableText(
            AppLocalizations.of(context)!.poolDetailsInfoSwapFees,
            style: style ?? AppTextStyles.bodyLarge(context),
          ),
          SelectableText(
            '${poolInfos?.fees ?? '-- '}%',
            style: style ?? AppTextStyles.bodyLarge(context),
          ),
        ],
      ),
    );
  }
}
