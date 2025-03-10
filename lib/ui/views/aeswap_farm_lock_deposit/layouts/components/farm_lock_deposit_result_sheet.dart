import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/failure_message.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/format_address_link_copy_big_icon.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/message_box/message_box.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/layouts/components/farm_lock_deposit_final_amount.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockDepositResultSheet extends ConsumerStatefulWidget {
  const FarmLockDepositResultSheet({
    super.key,
  });

  static const String routerPage = '/farmLockDeposit_result';

  @override
  ConsumerState<FarmLockDepositResultSheet> createState() =>
      FarmLockDepositResultSheetState();
}

class FarmLockDepositResultSheetState
    extends ConsumerState<FarmLockDepositResultSheet>
    implements SheetSkeletonInterface {
  @override
  Widget build(BuildContext context) {
    final accountSelected = ref.watch(
      accountsNotifierProvider.select(
        (accounts) => accounts.valueOrNull?.selectedAccount,
      ),
    );

    if (accountSelected == null) return const SizedBox();

    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    return BtnFooterPrimary(
      buttonText: AppLocalizations.of(context)!.close,
      key: const Key('close'),
      onTap: () async {
        ref.invalidate(farmLockDepositFormNotifierProvider);
        context
          ..pop()
          ..pop();
      },
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return SheetAppBar(
      title: localizations.farmLockDepositFormTitle,
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final farmLockDeposit = ref.watch(farmLockDepositFormNotifierProvider);
    if (farmLockDeposit.amount == 0) {
      return const SizedBox.shrink();
    }
    final finalAmount = farmLockDeposit.finalAmount;
    final timeout = ref.watch(
      farmLockDepositFormNotifierProvider
          .select((value) => value.failure != null),
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (finalAmount == null)
              MessageBox(
                messageBoxType: MessageBoxType.warning,
                content: Text(
                  FailureMessage(
                    context: context,
                    failure: farmLockDeposit.failure,
                  ).getMessage(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )
            else
              MessageBox(
                messageBoxType: MessageBoxType.success,
                content: Text(
                  AppLocalizations.of(context)!.farmLockDepositSuccessInfo,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            if (farmLockDeposit.transactionFarmLockDeposit != null &&
                farmLockDeposit.transactionFarmLockDeposit!.address != null &&
                farmLockDeposit.transactionFarmLockDeposit!.address!.address !=
                    null &&
                finalAmount != null)
              Column(
                children: [
                  FormatAddressLinkCopyBigIcon(
                    address: farmLockDeposit
                        .transactionFarmLockDeposit!.address!.address!
                        .toUpperCase(),
                    header:
                        AppLocalizations.of(context)!.farmLockDepositTxAddress,
                    typeAddress: TypeAddressLinkCopyBigIcon.transaction,
                    reduceAddress: true,
                    fontSize: 16,
                    iconSize: 26,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            if (finalAmount != null || timeout)
              const FarmLockDepositFinalAmount(),
          ],
        ),
      ),
    );
  }
}
