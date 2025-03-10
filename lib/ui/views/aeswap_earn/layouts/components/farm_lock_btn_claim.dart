import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/router/router.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_primary.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_claim/layouts/farm_lock_claim_sheet.dart';
import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: BtnPrimary(
        buttonText: AppLocalizations.of(context)!.farmLockBtnClaim,
        isLocked: !enabled,
        onTap: () async {
          await _validate(context);
        },
        widthExpanded: true,
      ),
    );
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
