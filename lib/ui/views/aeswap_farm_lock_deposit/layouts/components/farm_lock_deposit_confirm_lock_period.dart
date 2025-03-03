import 'package:aewallet/ui/figma_components/checkbox/checkbox_confirm.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockDepositConfirmLockPeriod extends ConsumerWidget {
  const FarmLockDepositConfirmLockPeriod({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmLockDeposit = ref.watch(farmLockDepositFormNotifierProvider);
    final localizations = AppLocalizations.of(context)!;

    return CheckboxConfirm(
      text: Text(
        localizations.farmLockDepositConfirmLockPeriod,
        style: Theme.of(context).textTheme.bodySmallWithOpacity,
      ),
      value: farmLockDeposit.confirmLockPeriod,
      onChanged: (value) {
        ref
            .read(farmLockDepositFormNotifierProvider.notifier)
            .setConfirmLockPeriod(value);
      },
    );
  }
}
