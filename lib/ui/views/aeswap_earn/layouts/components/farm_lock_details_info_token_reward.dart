import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_token_icon.dart';
import 'package:aewallet/ui/widgets/components/sheet_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockDetailsInfoTokenReward extends ConsumerWidget {
  const FarmLockDetailsInfoTokenReward({
    super.key,
    required this.farmLock,
  });

  final DexFarmLock farmLock;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return SheetDetailCard(
      children: [
        SelectableText(
          '${AppLocalizations.of(context)!.farmDetailsInfoTokenRewardEarn} ${farmLock.rewardToken!.symbol}',
          style: AppTextStyles.bodyMedium(context),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: DexTokenIcon(
            tokenAddress: farmLock.rewardToken!.address,
            iconSize: 22,
          ),
        ),
      ],
    );
  }
}
