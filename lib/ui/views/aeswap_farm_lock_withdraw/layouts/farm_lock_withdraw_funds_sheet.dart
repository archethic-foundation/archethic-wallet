import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_withdraw/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_withdraw/layouts/components/farm_lock_withdraw_confirm_sheet_uco.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_withdraw/layouts/components/farm_lock_withdraw_form_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockWithdrawFundsSheet extends ConsumerStatefulWidget {
  const FarmLockWithdrawFundsSheet({
    super.key,
  });

  static const routerPage = '/farmLockWithdrawFunds';

  @override
  ConsumerState<FarmLockWithdrawFundsSheet> createState() =>
      _FarmLockWithdrawFundsSheetState();
}

class _FarmLockWithdrawFundsSheetState
    extends ConsumerState<FarmLockWithdrawFundsSheet> {
  @override
  void initState() {
    super.initState();
    Future(() async {
      try {
        final farmLock = ref.watch(farmLockFormFarmLockProvider).value;
        if (farmLock != null) {
          var depositedAmount = 0.0;
          var rewardAmount = 0.0;
          farmLock.userInfos.forEach((depositId, userInfos) {
            if (userInfos.level == '0') {
              depositedAmount = (Decimal.parse(depositedAmount.toString()) +
                      Decimal.parse(userInfos.amount.toString()))
                  .toDouble();
              rewardAmount = (Decimal.parse(rewardAmount.toString()) +
                      Decimal.parse(userInfos.rewardAmount.toString()))
                  .toDouble();
            }
          });

          ref.read(farmLockWithdrawFormNotifierProvider.notifier)
            ..setFarmAddress(farmLock.farmAddress)
            ..setRewardToken(
              const DexToken(address: kUCOAddress, symbol: kUCOAddress),
            )
            ..setDepositedAmount(depositedAmount)
            ..setAmount(AppLocalizations.of(context)!, depositedAmount)
            ..setRewardAmount(rewardAmount)
            ..setPoolAddress(farmLock.poolAddress)
            ..setLPTokenPair(farmLock.lpTokenPair!)
            ..setLpToken(farmLock.lpToken!);
        } else {
          if (mounted) {
            context.pop();
          }
        }
      } catch (e) {
        if (mounted) {
          context.pop();
        }
      }
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final selectedAccount = ref
        .watch(
          accountsNotifierProvider,
        )
        .valueOrNull
        ?.selectedAccount;

    if (selectedAccount == null) return const SizedBox();

    final farmLockWithdrawForm =
        ref.watch(farmLockWithdrawFormNotifierProvider);

    return farmLockWithdrawForm.processStep == aedappfm.ProcessStep.form
        ? const FarmLockWithdrawFormSheet()
        : const FarmLockWithdrawConfirmSheetUCO();
  }
}
