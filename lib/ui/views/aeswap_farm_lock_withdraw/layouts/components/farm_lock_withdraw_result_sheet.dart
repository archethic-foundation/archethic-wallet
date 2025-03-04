import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/failure_message.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/format_address_link_copy_big_icon.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/message_box/message_box.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_withdraw/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_withdraw/layouts/components/farm_lock_withdraw_final_amount.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockWithdrawResultSheet extends ConsumerStatefulWidget {
  const FarmLockWithdrawResultSheet({
    super.key,
  });

  static const String routerPage = '/farmLockWithdraw_result';

  @override
  ConsumerState<FarmLockWithdrawResultSheet> createState() =>
      FarmLockWithdrawResultSheetState();
}

class FarmLockWithdrawResultSheetState
    extends ConsumerState<FarmLockWithdrawResultSheet>
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
        ref.invalidate(farmLockWithdrawFormNotifierProvider);
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
      title: localizations.farmLockWithdrawFormTitle,
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final farmLockWithdraw = ref.watch(farmLockWithdrawFormNotifierProvider);
    if (farmLockWithdraw.lpToken == null) {
      return const SizedBox.shrink();
    }

    final finalAmountReward = farmLockWithdraw.finalAmountReward;
    final finalAmountWithdraw = farmLockWithdraw.finalAmountWithdraw;
    final timeout = ref.watch(
      farmLockWithdrawFormNotifierProvider
          .select((value) => value.failure != null),
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (finalAmountReward == null && finalAmountWithdraw == null)
              MessageBox(
                messageBoxType: MessageBoxType.warning,
                text: FailureMessage(
                  context: context,
                  failure: farmLockWithdraw.failure,
                ).getMessage(),
              )
            else
              MessageBox(
                messageBoxType: MessageBoxType.success,
                text: AppLocalizations.of(context)!.farmLockWithdrawSuccessInfo,
              ),
            const SizedBox(
              height: 20,
            ),
            if (farmLockWithdraw.transactionWithdrawFarmLock != null &&
                farmLockWithdraw.transactionWithdrawFarmLock!.address != null &&
                farmLockWithdraw
                        .transactionWithdrawFarmLock!.address!.address !=
                    null &&
                finalAmountReward != null &&
                finalAmountWithdraw != null)
              Column(
                children: [
                  FormatAddressLinkCopyBigIcon(
                    address: farmLockWithdraw
                        .transactionWithdrawFarmLock!.address!.address!
                        .toUpperCase(),
                    header:
                        AppLocalizations.of(context)!.farmLockWithdrawTxAddress,
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
            if ((finalAmountReward != null && finalAmountWithdraw != null) ||
                timeout)
              const FarmLockWithdrawFinalAmount(),
          ],
        ),
      ),
    );
  }
}
