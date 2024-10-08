import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_token_icon.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/failure_message.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/fiat_value.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/pool_info_card.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/layouts/components/liquidity_add_icon_settings.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/layouts/components/liquidity_add_infos.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/layouts/components/liquidity_add_textfield_token_1_amount.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/layouts/components/liquidity_add_textfield_token_2_amount.dart';
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
import 'package:url_launcher/url_launcher.dart';

class LiquidityAddFormSheet extends ConsumerWidget
    implements SheetSkeletonInterface {
  const LiquidityAddFormSheet({
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
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);
    return Row(
      children: <Widget>[
        AppButtonTinyConnectivity(
          localizations.btn_liquidity_add,
          Dimens.buttonBottomDimens,
          key: const Key('addLiquidity'),
          onPressed: () async {
            await ref
                .read(
                  LiquidityAddFormProvider.liquidityAddForm.notifier,
                )
                .validateForm(context);
          },
          disabled: !liquidityAdd.isControlsOk,
        ),
      ],
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
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);

    if (liquidityAdd.token1 == null || liquidityAdd.token2 == null) {
      return const SizedBox.shrink();
    }
    final localizations = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              launchUrl(
                Uri.parse(
                  'https://wiki.archethic.net/participate/dex/Guide_Usage/liquidity_pool#add-liquidity',
                ),
              );
            },
            child: Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: ArchethicThemeStyles.textStyleSize12W100Primary,
                      children: [
                        TextSpan(
                          text: localizations.liquidityAddDesc,
                        ),
                        const WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.only(top: 5, left: 7),
                            child: Icon(
                              Icons.help,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (liquidityAdd.token1 != null)
                      PoolInfoCard(
                        poolGenesisAddress: liquidityAdd.pool!.poolAddress,
                        tokenAddressRatioPrimary:
                            liquidityAdd.token1!.address == null
                                ? 'UCO'
                                : liquidityAdd.token1!.address!,
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SelectableText(
                          '${AppLocalizations.of(context)!.slippage_tolerance} ${liquidityAdd.slippageTolerance}%',
                          style: AppTextStyles.bodyMedium(context),
                        ),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: LiquidityAddTokenIconSettings(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          DexTokenIcon(
                            tokenAddress: liquidityAdd.token1!.address == null
                                ? 'UCO'
                                : liquidityAdd.token1!.address!,
                          ),
                          Tooltip(
                            message: liquidityAdd.token1!.symbol,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                liquidityAdd.token1!.symbol.reduceSymbol(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        const LiquidityAddToken1Amount(),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (liquidityAdd.token1 != null &&
                                  liquidityAdd.token1Amount > 0)
                                Padding(
                                  padding: const EdgeInsets.only(top: 13),
                                  child: FutureBuilder<String>(
                                    future: FiatValue().display(
                                      ref,
                                      liquidityAdd.token1!,
                                      liquidityAdd.token1Amount,
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return SelectableText(
                                          snapshot.data!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          DexTokenIcon(
                            tokenAddress: liquidityAdd.token2!.address == null
                                ? 'UCO'
                                : liquidityAdd.token2!.address!,
                          ),
                          Tooltip(
                            message: liquidityAdd.token2!.symbol,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                liquidityAdd.token2!.symbol.reduceSymbol(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        const LiquidityAddToken2Amount(),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (liquidityAdd.token2 != null &&
                                  liquidityAdd.token2Amount > 0)
                                Padding(
                                  padding: const EdgeInsets.only(top: 13),
                                  child: FutureBuilder<String>(
                                    future: FiatValue().display(
                                      ref,
                                      liquidityAdd.token2!,
                                      liquidityAdd.token2Amount,
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return SelectableText(
                                          snapshot.data!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                            AppLocalizations.of(context)!
                                .liquidityAddMessageMaxHalfUCO
                                .replaceFirst(
                                  '%1',
                                  liquidityAdd.feesEstimatedUCO
                                      .formatNumber(precision: 8),
                                ),
                            aedappfm.InfoBannerType.request,
                          ),
                        ),
                      ),
                    aedappfm.ErrorMessage(
                      failure: liquidityAdd.failure,
                      failureMessage: FailureMessage(
                        context: context,
                        failure: liquidityAdd.failure,
                      ).getMessage(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
