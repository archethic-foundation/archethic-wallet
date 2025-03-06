import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/failure_message.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/format_address_link_copy_big_icon.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/message_box/message_box.dart';
import 'package:aewallet/ui/views/aeswap_swap/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_swap/layouts/components/swap_final_amount.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SwapResultSheet extends ConsumerStatefulWidget {
  const SwapResultSheet({
    super.key,
  });

  static const String routerPage = '/swap_result';

  @override
  ConsumerState<SwapResultSheet> createState() => SwapResultSheetState();
}

class SwapResultSheetState extends ConsumerState<SwapResultSheet>
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
      title: localizations.menu_swap,
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(swapFormNotifierProvider);
    if (swap.tokenToSwap == null || swap.tokenSwapped == null) {
      return const SizedBox.shrink();
    }
    final finalAmount = swap.finalAmount;
    final timeout = ref.watch(
      swapFormNotifierProvider.select((value) => value.failure != null),
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
                text: FailureMessage(
                  context: context,
                  failure: swap.failure,
                ).getMessage(),
              )
            else
              MessageBox(
                messageBoxType: MessageBoxType.success,
                text: AppLocalizations.of(context)!.swapSuccessInfo,
              ),
            const SizedBox(
              height: 20,
            ),
            if (swap.recoveryTransactionSwap != null &&
                swap.recoveryTransactionSwap!.address != null &&
                swap.recoveryTransactionSwap!.address!.address != null &&
                finalAmount != null)
              Column(
                children: [
                  FormatAddressLinkCopyBigIcon(
                    address: swap.recoveryTransactionSwap!.address!.address!
                        .toUpperCase(),
                    header:
                        AppLocalizations.of(context)!.swapInProgressTxAddresses,
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
            if (finalAmount != null || timeout) const SwapFinalAmount(),
          ],
        ),
      ),
    );
  }
}
