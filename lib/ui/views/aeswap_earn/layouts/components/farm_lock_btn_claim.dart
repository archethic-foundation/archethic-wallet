import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/btn_validate_mobile.dart';
import 'package:aewallet/router/router.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_claim/layouts/farm_lock_claim_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockBtnClaim extends ConsumerWidget {
  const FarmLockBtnClaim({
    required this.farmAddress,
    required this.rewardToken,
    required this.lpTokenAddress,
    required this.rewardAmount,
    required this.depositId,
    this.enabled = true,
    super.key,
  });

  final String farmAddress;
  final DexToken rewardToken;
  final String lpTokenAddress;
  final double rewardAmount;
  final String depositId;
  final bool enabled;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return ButtonValidateMobile(
      controlOk: enabled,
      labelBtn: AppLocalizations.of(context)!.farmLockBtnClaim,
      onPressed: () async {
        await _validate(context);
      },
      displayWalletConnect: true,
      isConnected: true,
      displayWalletConnectOnPressed: () {},
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 400))
        .scale(duration: const Duration(milliseconds: 400));
  }

  Future<void> _validate(BuildContext context) async {
    if (context.mounted) {
      await context.push(
        Uri(
          path: FarmLockClaimSheet.routerPage,
          queryParameters: {
            'farmAddress': farmAddress.encodeParam(),
            'rewardToken': rewardToken.encodeParam(),
            'lpTokenAddress': lpTokenAddress.encodeParam(),
            'rewardAmount': rewardAmount.encodeParam(),
            'depositId': depositId.encodeParam(),
          },
        ).toString(),
      );
    }
  }
}
