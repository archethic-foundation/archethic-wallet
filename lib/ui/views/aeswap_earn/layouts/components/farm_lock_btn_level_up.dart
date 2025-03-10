import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/router/router.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_primary.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_level_up/layouts/farm_lock_level_up_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockBtnLevelUp extends ConsumerWidget {
  const FarmLockBtnLevelUp({
    required this.farmAddress,
    required this.rewardToken,
    required this.lpTokenAddress,
    required this.lpTokenAmount,
    required this.depositId,
    required this.currentLevel,
    required this.rewardAmount,
    required this.pool,
    this.enabled = true,
    super.key,
  });

  final String farmAddress;
  final DexToken rewardToken;
  final String lpTokenAddress;
  final double lpTokenAmount;
  final String depositId;
  final String currentLevel;
  final bool enabled;
  final double rewardAmount;
  final DexPool pool;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmLock = ref.watch(farmLockFormFarmLockProvider).value;
    if (farmLock == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: BtnPrimary(
        buttonText: AppLocalizations.of(context)!.farmLockBtnLevelUp,
        isLocked: !enabled,
        widthExpanded: true,
        onTap: () async {
          if (context.mounted) {
            await context.push(
              Uri(
                path: FarmLockLevelUpSheet.routerPage,
                queryParameters: {
                  'pool': pool.toJson().encodeParam(),
                  'depositId': depositId.encodeParam(),
                  'currentLevel': currentLevel.encodeParam(),
                  'lpAmount': lpTokenAmount.encodeParam(),
                  'rewardAmount': rewardAmount.encodeParam(),
                },
              ).toString(),
            );
          }
        },
      ),
    );
  }
}
