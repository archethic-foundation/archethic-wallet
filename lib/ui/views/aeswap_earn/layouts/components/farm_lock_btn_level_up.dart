import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/btn_validate_mobile.dart';
import 'package:aewallet/router/router.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_level_up/layouts/farm_lock_level_up_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    required this.farmLock,
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
  final DexFarmLock farmLock;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return ButtonValidateMobile(
      controlOk: enabled,
      labelBtn: AppLocalizations.of(context)!.farmLockBtnLevelUp,
      onPressed: () async {
        if (context.mounted) {
          await context.push(
            Uri(
              path: FarmLockLevelUpSheet.routerPage,
              queryParameters: {
                'pool': pool.toJson().encodeParam(),
                'farmLock': farmLock.toJson().encodeParam(),
                'depositId': depositId.encodeParam(),
                'currentLevel': currentLevel.encodeParam(),
                'lpAmount': lpTokenAmount.encodeParam(),
                'rewardAmount': rewardAmount.encodeParam(),
              },
            ).toString(),
          );
        }
      },
      displayWalletConnect: true,
      isConnected: true,
      displayWalletConnectOnPressed: () {},
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 300))
        .scale(duration: const Duration(milliseconds: 300));
  }
}
