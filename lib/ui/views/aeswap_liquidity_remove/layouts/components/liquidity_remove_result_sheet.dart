import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/failure_message.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/format_address_link_copy_big_icon.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/message_box/message_box.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_remove/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_remove/layouts/components/liquidity_remove_final_amount.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LiquidityRemoveResultSheet extends ConsumerStatefulWidget {
  const LiquidityRemoveResultSheet({
    super.key,
  });

  static const String routerPage = '/liquidy_remove_result';

  @override
  ConsumerState<LiquidityRemoveResultSheet> createState() =>
      LiquidityRemoveResultSheetState();
}

class LiquidityRemoveResultSheetState
    extends ConsumerState<LiquidityRemoveResultSheet>
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
        ref.invalidate(liquidityRemoveFormNotifierProvider);
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
      title: localizations.removeLiquidity,
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final liquidityRemove = ref.watch(liquidityRemoveFormNotifierProvider);
    if (liquidityRemove.lpToken == null) {
      return const SizedBox.shrink();
    }
    final finalAmountToken1 = liquidityRemove.finalAmountToken1;
    final finalAmountToken2 = liquidityRemove.finalAmountToken2;
    final finalAmountLPToken = liquidityRemove.finalAmountLPToken;
    final timeout = ref.watch(
      liquidityRemoveFormNotifierProvider
          .select((value) => value.failure != null),
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (finalAmountToken1 == null &&
                finalAmountToken2 == null &&
                finalAmountLPToken == null)
              MessageBox(
                messageBoxType: MessageBoxType.warning,
                content: Text(
                  FailureMessage(
                    context: context,
                    failure: liquidityRemove.failure,
                  ).getMessage(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )
            else
              MessageBox(
                messageBoxType: MessageBoxType.success,
                content: Text(
                  AppLocalizations.of(context)!.liquidityRemoveSuccessInfo,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            if (liquidityRemove.transactionRemoveLiquidity != null &&
                liquidityRemove.transactionRemoveLiquidity!.address != null &&
                liquidityRemove.transactionRemoveLiquidity!.address!.address !=
                    null &&
                finalAmountToken1 != null &&
                finalAmountToken2 != null &&
                finalAmountLPToken != null)
              Column(
                children: [
                  FormatAddressLinkCopyBigIcon(
                    address: liquidityRemove
                        .transactionRemoveLiquidity!.address!.address!
                        .toUpperCase(),
                    header: AppLocalizations.of(context)!
                        .liquidityRemoveInProgressTxAddresses,
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
            if ((finalAmountToken1 != null &&
                    finalAmountToken2 != null &&
                    finalAmountLPToken != null) ||
                timeout)
              const LiquidityRemoveFinalAmount(),
          ],
        ),
      ),
    );
  }
}
