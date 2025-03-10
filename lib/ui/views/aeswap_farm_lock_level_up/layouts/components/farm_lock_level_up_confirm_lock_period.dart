import 'package:aewallet/ui/figma_components/checkbox/checkbox_confirm.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_level_up/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockLevelUpConfirmLockPeriod extends ConsumerWidget {
  const FarmLockLevelUpConfirmLockPeriod({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmLockLevelUp = ref.watch(farmLockLevelUpFormNotifierProvider);
    final localizations = AppLocalizations.of(context)!;

    return CheckboxConfirm(
      text: Text(
        localizations.farmLockDepositConfirmLockPeriod,
        style: Theme.of(context).textTheme.bodySmallWithOpacity,
      ),
      value: farmLockLevelUp.confirmLockPeriod,
      onChanged: (value) {
        ref
            .read(farmLockLevelUpFormNotifierProvider.notifier)
            .setConfirmLockPeriod(value);
      },
    );
  }
}
