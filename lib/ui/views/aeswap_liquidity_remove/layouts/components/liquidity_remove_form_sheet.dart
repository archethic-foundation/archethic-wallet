import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/failure_message.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/pool_info_card.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_remove/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_remove/layouts/components/liquidity_remove_lp_tokens_get_back.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_remove/layouts/components/liquidity_remove_textfield_lp_token_amount.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LiquidityRemoveFormSheet extends ConsumerWidget
    implements SheetSkeletonInterface {
  const LiquidityRemoveFormSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    final localizations = AppLocalizations.of(context)!;
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);
    return Row(
      children: <Widget>[
        AppButtonTinyConnectivity(
          localizations.btn_liquidity_remove,
          Dimens.buttonBottomDimens,
          key: const Key('removeLiquidity'),
          onPressed: () async {
            await ref
                .read(
                  LiquidityRemoveFormProvider.liquidityRemoveForm.notifier,
                )
                .validateForm(context);
          },
          disabled: !liquidityRemove.isControlsOk,
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return SheetAppBar(
      title: localizations.removeLiquidity,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.pop();
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (liquidityRemove.token1 != null)
              PoolInfoCard(
                poolGenesisAddress: liquidityRemove.pool!.poolAddress,
                tokenAddressRatioPrimary:
                    liquidityRemove.token1!.address == null
                        ? 'UCO'
                        : liquidityRemove.token1!.address!,
              ),
            const SizedBox(
              height: 20,
            ),
            const LiquidityRemoveLPTokenAmount(),
            const SizedBox(
              height: 10,
            ),
            const LiquidityRemoveTokensGetBack(),
            aedappfm.ErrorMessage(
              failure: liquidityRemove.failure,
              failureMessage: FailureMessage(
                context: context,
                failure: liquidityRemove.failure,
              ).getMessage(),
            ),
          ],
        ),
      ),
    );
  }
}
