import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_token_icon.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/failure_message.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/fiat_value.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/figma_components/message_box/message_box.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/layouts/components/liquidity_add_icon_settings.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/layouts/components/liquidity_add_infos.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/layouts/components/liquidity_add_textfield_token_1_amount.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/layouts/components/liquidity_add_textfield_token_2_amount.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LiquidityAddFormSheet extends ConsumerWidget
    implements SheetSkeletonInterface {
  const LiquidityAddFormSheet({
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
    final liquidityAdd = ref.watch(liquidityAddFormNotifierProvider);
    return BtnFooterPrimary(
      buttonText: localizations.btn_liquidity_add,
      onTap: () async {
        await ref
            .read(
              liquidityAddFormNotifierProvider.notifier,
            )
            .validateForm(AppLocalizations.of(context)!);
      },
      isLocked: !liquidityAdd.isControlsOk,
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return SheetAppBar(
      title: localizations.addLiquidity,
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
    final liquidityAdd = ref.watch(liquidityAddFormNotifierProvider);

    if (liquidityAdd.token1 == null || liquidityAdd.token2 == null) {
      return const SizedBox.shrink();
    }
    final localizations = AppLocalizations.of(context)!;
    final boldBodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontWeight: FontWeightTelegraf.fontWeightBold);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.liquidityAddTitle,
            style: boldBodyLarge,
          ),
          const SizedBox(height: 10),
          Text(
            localizations.liquidityAddDesc,
            style: Theme.of(context).textTheme.bodyMediumWithOpacity,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SelectableText(
                          '${localizations.slippage_tolerance} ${liquidityAdd.slippageTolerance}%',
                          style:
                              Theme.of(context).textTheme.bodyMediumWithOpacity,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: LiquidityAddTokenIconSettings(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              DexTokenIcon(
                                tokenAddress: liquidityAdd.token2!.address.isUCO
                                    ? kUCOAddress
                                    : liquidityAdd.token2!.address,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  localizations.liquidityAddTextFieldUCOLabel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontWeight:
                                            FontWeightTelegraf.fontWeightBold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          if (liquidityAdd.token2 != null &&
                              liquidityAdd.token2Amount > 0)
                            FutureBuilder<String>(
                              future: FiatValue().display(
                                ref,
                                liquidityAdd.token2!,
                                liquidityAdd.token2Amount,
                                withParenthesis: false,
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return SelectableText(
                                    snapshot.data!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMediumWithOpacity,
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                        ],
                      ),
                    ),
                    const LiquidityAddToken2Amount(),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              DexTokenIcon(
                                tokenAddress: liquidityAdd.token1!.address.isUCO
                                    ? kUCOAddress
                                    : liquidityAdd.token1!.address,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  localizations.liquidityAddTextFieldETHLabel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontWeight:
                                            FontWeightTelegraf.fontWeightBold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          if (liquidityAdd.token1 != null &&
                              liquidityAdd.token1Amount > 0)
                            FutureBuilder<String>(
                              future: FiatValue().display(
                                ref,
                                liquidityAdd.token1!,
                                liquidityAdd.token1Amount,
                                withParenthesis: false,
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return SelectableText(
                                    snapshot.data!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMediumWithOpacity,
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                        ],
                      ),
                    ),
                    const LiquidityAddToken1Amount(),
                    const SizedBox(
                      height: 10,
                    ),
                    const LiquidityAddInfos(),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (liquidityAdd.messageMaxHalfUCO)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          height: 40,
                          child: aedappfm.InfoBanner(
                            localizations.liquidityAddMessageMaxHalfUCO
                                .replaceFirst(
                              '%1',
                              liquidityAdd.feesEstimatedUCO
                                  .formatNumber(precision: 8),
                            ),
                            aedappfm.InfoBannerType.request,
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    MessageBox(
                      messageBoxType: MessageBoxType.warning,
                      text: FailureMessage(
                        context: context,
                        failure: liquidityAdd.failure,
                      ).getMessage(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
