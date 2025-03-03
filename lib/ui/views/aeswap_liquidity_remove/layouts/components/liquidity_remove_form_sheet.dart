import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/failure_message.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/message_box/message_box.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_remove/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_remove/layouts/components/liquidity_remove_lp_tokens_get_back.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_remove/layouts/components/liquidity_remove_textfield_lp_token_amount.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LiquidityRemoveFormSheet extends ConsumerWidget
    implements SheetSkeletonInterface {
  const LiquidityRemoveFormSheet({
    required this.pool,
    super.key,
  });

  final DexPool pool;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    final localizations = AppLocalizations.of(context)!;
    final liquidityRemove = ref.watch(liquidityRemoveFormNotifierProvider);
    return BtnFooterPrimary(
      buttonText: localizations.btn_liquidity_remove,
      key: const Key('removeLiquidity'),
      onTap: () async {
        await ref
            .read(
              liquidityRemoveFormNotifierProvider.notifier,
            )
            .validateForm(AppLocalizations.of(context)!);
      },
      isLocked: !liquidityRemove.isControlsOk,
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
    final liquidityRemove = ref.watch(liquidityRemoveFormNotifierProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.liquidityRemoveTextFieldLPLabel,
              style: AppTextStyles.bodyMedium(context).copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const LiquidityRemoveLPTokenAmount(),
            const SizedBox(
              height: 30,
            ),
            const LiquidityRemoveTokensGetBack(),
            MessageBox(
              messageBoxType: MessageBoxType.warning,
              text: FailureMessage(
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
