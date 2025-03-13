/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/ui/views/util/farm_lock_duration_type.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockDepositDurationButton extends ConsumerWidget {
  const FarmLockDepositDurationButton({
    super.key,
    required this.farmLockDepositDuration,
    required this.level,
    required this.aprEstimation,
  });

  final FarmLockDepositDurationType farmLockDepositDuration;
  final String level;
  final double aprEstimation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmLockDeposit = ref.watch(farmLockDepositFormNotifierProvider);

    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color:
            farmLockDeposit.farmLockDepositDuration == farmLockDepositDuration
                ? aedappfm.AppThemeBase.sheetBackgroundTertiary
                    .withValues(alpha: 0.9)
                : aedappfm.AppThemeBase.sheetBackgroundTertiary
                    .withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.primaryContainer,
          width: 0.5,
        ),
      ),
      child: InkWell(
        onTap: () {
          ref.read(
            farmLockDepositFormNotifierProvider.notifier,
          )
            ..setFarmLockDepositDuration(farmLockDepositDuration)
            ..setLevel(level)
            ..setAPREstimation(
              aprEstimation,
            );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.level} $level',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  getFarmLockDepositDurationTypeLabel(
                    context,
                    farmLockDepositDuration,
                  ),
                  style:
                      Theme.of(context).textTheme.bodySmallWithOpacity.copyWith(
                            fontWeight: FontWeightTelegraf.fontWeightBold,
                          ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.farmLockDepositAPRLbl} ',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 8,
                      ),
                ),
                if (aprEstimation > 0)
                  Text(
                    '${aprEstimation.formatNumber(precision: 2)}%',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: const Color(0xFF00B67A),
                        ),
                  )
                else
                  const Padding(
                    padding: EdgeInsets.only(bottom: 2),
                    child: Icon(
                      Icons.all_inclusive,
                      size: 16,
                      color: Color(0xFF00B67A),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
