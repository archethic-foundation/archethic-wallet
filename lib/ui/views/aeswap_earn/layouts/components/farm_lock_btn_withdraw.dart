import 'package:aewallet/modules/aeswap/domain/models/dex_pair.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/btn_validate_mobile.dart';
import 'package:aewallet/router/router.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_withdraw/layouts/farm_lock_withdraw_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockBtnWithdraw extends ConsumerWidget {
  const FarmLockBtnWithdraw({
    required this.farmAddress,
    required this.poolAddress,
    required this.rewardToken,
    required this.lpToken,
    required this.lpTokenPair,
    required this.rewardAmount,
    required this.depositedAmount,
    required this.depositId,
    required this.endDate,
    this.enabled = true,
    super.key,
  });

  final String farmAddress;
  final String poolAddress;
  final DexToken rewardToken;
  final DexToken lpToken;
  final DexPair lpTokenPair;
  final double rewardAmount;
  final double depositedAmount;
  final String depositId;
  final bool enabled;
  final DateTime endDate;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return ButtonValidateMobile(
      controlOk: enabled,
      labelBtn: AppLocalizations.of(context)!.farmLockBtnWithdraw,
      onPressed: () async {
        if (context.mounted) {
          await context.push(
            Uri(
              path: FarmLockWithdrawSheet.routerPage,
              queryParameters: {
                'farmAddress': farmAddress.encodeParam(),
                'poolAddress': poolAddress.encodeParam(),
                'rewardToken': rewardToken.encodeParam(),
                'lpToken': lpToken.encodeParam(),
                'lpTokenPair': lpTokenPair.encodeParam(),
                'rewardAmount': rewardAmount.encodeParam(),
                'depositedAmount': depositedAmount.encodeParam(),
                'depositId': depositId.encodeParam(),
                'endDate':
                    (endDate.millisecondsSinceEpoch ~/ 1000).encodeParam(),
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
        .fade(duration: const Duration(milliseconds: 350))
        .scale(duration: const Duration(milliseconds: 350));
  }
}
