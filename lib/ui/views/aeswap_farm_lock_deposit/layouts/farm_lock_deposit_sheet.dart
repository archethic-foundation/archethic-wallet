/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/layouts/components/farm_lock_deposit_confirm_sheet.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/layouts/components/farm_lock_deposit_form_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockDepositSheet extends ConsumerStatefulWidget {
  const FarmLockDepositSheet({
    required this.pool,
    required this.farmLock,
    super.key,
  });

  final DexPool pool;
  final DexFarmLock farmLock;

  static const String routerPage = '/farmLockDeposit';

  @override
  ConsumerState<FarmLockDepositSheet> createState() =>
      _FarmLockDepositSheetState();
}

class _FarmLockDepositSheetState extends ConsumerState<FarmLockDepositSheet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      try {
        ref.read(FarmLockDepositFormProvider.farmLockDepositForm.notifier)
          ..setDexPool(widget.pool)
          ..setDexFarmLock(widget.farmLock)
          ..setLevel(widget.farmLock.availableLevels.entries.last.key)
          ..setAPREstimation(widget.farmLock.apr3years * 100);

        await ref
            .read(FarmLockDepositFormProvider.farmLockDepositForm.notifier)
            .initBalances();

        ref
            .read(FarmLockDepositFormProvider.farmLockDepositForm.notifier)
            .filterAvailableLevels();
      } catch (e) {
        if (mounted) {
          context.pop();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedAccount = ref
        .watch(
          AccountProviders.accounts,
        )
        .valueOrNull
        ?.selectedAccount;

    if (selectedAccount == null) return const SizedBox();

    final farmLockDepositForm =
        ref.watch(FarmLockDepositFormProvider.farmLockDepositForm);

    return farmLockDepositForm.processStep == ProcessStep.form
        ? const FarmLockDepositFormSheet()
        : const FarmLockDepositConfirmSheet();
  }
}
