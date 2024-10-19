import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/format_address_link_copy_big_icon.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/layouts/components/liquidity_add_final_amount.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_detail_card.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LiquidityAddResultSheet extends ConsumerStatefulWidget {
  const LiquidityAddResultSheet({
    super.key,
  });

  static const String routerPage = '/liquidy_add_result';

  @override
  ConsumerState<LiquidityAddResultSheet> createState() =>
      LiquidityAddResultSheetState();
}

class LiquidityAddResultSheetState
    extends ConsumerState<LiquidityAddResultSheet>
    implements SheetSkeletonInterface {
  @override
  Widget build(BuildContext context) {
    final accountSelected = ref.watch(
      AccountProviders.accounts.select(
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
    return Row(
      children: <Widget>[
        AppButtonTinyConnectivity(
          AppLocalizations.of(context)!.close,
          Dimens.buttonBottomDimens,
          key: const Key('close'),
          onPressed: () async {
            ref.invalidate(liquidityAddFormNotifierProvider);
            context
              ..pop()
              ..pop();
          },
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return SheetAppBar(
      title: localizations.addLiquidity,
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final liquidityAdd = ref.watch(liquidityAddFormNotifierProvider);
    if (liquidityAdd.token1 == null || liquidityAdd.token2 == null) {
      return const SizedBox.shrink();
    }
    final finalAmount = liquidityAdd.finalAmount;
    final timeout = ref.watch(
      liquidityAddFormNotifierProvider.select((value) => value.failure != null),
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SheetDetailCard(
              children: [
                if (finalAmount == null)
                  if (timeout == false)
                    Row(
                      children: [
                        AutoSizeText(
                          AppLocalizations.of(context)!.processingInProgress,
                          style: AppTextStyles.bodyLarge(context),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const SizedBox(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator(strokeWidth: 1),
                        ),
                      ],
                    )
                  else
                    const SizedBox.shrink()
                else
                  Text(
                    AppLocalizations.of(context)!.liquidityAddSuccessInfo,
                    style: AppTextStyles.bodyLarge(context).copyWith(
                      color: aedappfm.ArchethicThemeBase.systemPositive600,
                    ),
                  ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            if (liquidityAdd.transactionAddLiquidity != null &&
                liquidityAdd.transactionAddLiquidity!.address != null &&
                liquidityAdd.transactionAddLiquidity!.address!.address != null)
              FormatAddressLinkCopyBigIcon(
                address: liquidityAdd.transactionAddLiquidity!.address!.address!
                    .toUpperCase(),
                header: AppLocalizations.of(context)!
                    .liquidityAddInProgresstxAddresses,
                typeAddress: TypeAddressLinkCopyBigIcon.transaction,
                reduceAddress: true,
                fontSize: 16,
                iconSize: 26,
              ),
            const SizedBox(
              height: 20,
            ),
            if (finalAmount != null || timeout)
              const SheetDetailCard(
                children: [
                  LiquidityAddFinalAmount(),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
