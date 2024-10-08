import 'dart:convert';

import 'package:aewallet/application/farm_apr.dart';
import 'package:aewallet/ui/themes/archethic_theme_base.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/earn_farm_lock_infos.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/farm_lock_block_farmed_tokens_summary.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/layouts/farm_lock_deposit_sheet.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/layouts/liquidity_add_sheet.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_remove/layouts/liquidity_remove_sheet.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EarnTab extends ConsumerStatefulWidget {
  const EarnTab({super.key});

  @override
  ConsumerState<EarnTab> createState() => EarnTabState();
}

class EarnTabState extends ConsumerState<EarnTab> {
  @override
  Widget build(BuildContext context) {
    final farmLock = ref.watch(farmLockFormFarmLockProvider).value;
    final pool = ref.watch(farmLockFormPoolProvider).value;
    final balances = ref.watch(farmLockFormBalancesProvider);

    final apr = ref.watch(FarmAPRProviders.farmAPR);
    final localizations = AppLocalizations.of(context)!;

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
        },
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  ArchethicScrollbar(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 10,
                        bottom: 80,
                      ),
                      child: Column(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                balances.lpTokenBalance == 0
                                    ? localizations.earnHeaderBalance0
                                    : localizations.earnHeaderWithBalance,
                                style: ArchethicThemeStyles
                                    .textStyleSize14W200Primary,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${balances.lpTokenBalance} ',
                                          style: ArchethicThemeStyles
                                              .textStyleSize14W400Highlighted,
                                        ),
                                        Text(
                                          balances.lpTokenBalance <= 1
                                              ? localizations
                                                  .earnHeaderLPTokenAvailable
                                              : localizations
                                                  .earnHeaderLPTokensAvailable,
                                          style: ArchethicThemeStyles
                                              .textStyleSize14W200Primary,
                                        ),
                                      ],
                                    ),
                                    if (balances.lpTokenBalance != 0)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            child: Container(
                                              height: 36,
                                              width: 36,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                gradient: aedappfm
                                                    .AppThemeBase.gradientBtn,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                aedappfm.Iconsax.import4,
                                                size: 18,
                                              ),
                                            ),
                                            onTap: () async {
                                              final poolJson = jsonEncode(
                                                pool!.toJson(),
                                              );
                                              final poolEncoded =
                                                  Uri.encodeComponent(poolJson);
                                              await context.push(
                                                Uri(
                                                  path: LiquidityAddSheet
                                                      .routerPage,
                                                  queryParameters: {
                                                    'pool': poolEncoded,
                                                  },
                                                ).toString(),
                                              );
                                            },
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            child: Container(
                                              height: 36,
                                              width: 36,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                gradient: aedappfm
                                                    .AppThemeBase.gradientBtn,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                aedappfm.Iconsax.export4,
                                                size: 18,
                                              ),
                                            ),
                                            onTap: () async {
                                              final poolJson = jsonEncode(
                                                pool!.toJson(),
                                              );
                                              final pairJson = jsonEncode(
                                                pool.pair.toJson(),
                                              );
                                              final lpTokenJson = jsonEncode(
                                                pool.lpToken.toJson(),
                                              );
                                              final poolEncoded =
                                                  Uri.encodeComponent(poolJson);
                                              final pairEncoded =
                                                  Uri.encodeComponent(pairJson);
                                              final lpTokenEncoded =
                                                  Uri.encodeComponent(
                                                lpTokenJson,
                                              );
                                              await context.push(
                                                Uri(
                                                  path: LiquidityRemoveSheet
                                                      .routerPage,
                                                  queryParameters: {
                                                    'pool': poolEncoded,
                                                    'pair': pairEncoded,
                                                    'lpToken': lpTokenEncoded,
                                                  },
                                                ).toString(),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              if (balances.lpTokenBalance == 0)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      localizations.earnHeaderAddLiquidityTxt,
                                      style: ArchethicThemeStyles
                                          .textStyleSize14W200Primary,
                                    ),
                                    Row(
                                      children: [
                                        AppButtonTinyConnectivity(
                                          localizations.addLiquidity,
                                          Dimens.buttonBottomDimens,
                                          key: const Key('addLiquidity'),
                                          onPressed: () async {
                                            final poolJson = jsonEncode(
                                              pool!.toJson(),
                                            );
                                            final poolEncoded =
                                                Uri.encodeComponent(poolJson);
                                            await context.push(
                                              Uri(
                                                path: LiquidityAddSheet
                                                    .routerPage,
                                                queryParameters: {
                                                  'pool': poolEncoded,
                                                },
                                              ).toString(),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        apr,
                                        style: ArchethicThemeStyles
                                            .textStyleSize24W700Primary
                                            .copyWith(
                                          color:
                                              ArchethicThemeBase.raspberry300,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          localizations.earnHeaderMaxAPR,
                                          style: ArchethicThemeStyles
                                              .textStyleSize14W600Primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const EarnFarmLockInfos(),
                                ],
                              ),
                              FarmLockBlockFarmedTokensSummary(
                                width: MediaQuery.of(context).size.width,
                                height: 185,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 20,
              ),
              child: Row(
                children: [
                  AppButtonTinyConnectivity(
                    localizations.earnHeaderStartEarningBtn,
                    Dimens.buttonBottomDimens,
                    key: const Key('startEarn'),
                    disabled: pool == null || farmLock == null,
                    onPressed: () async {
                      final poolJson = jsonEncode(pool!.toJson());
                      final poolEncoded = Uri.encodeComponent(poolJson);
                      final farmLockJson = jsonEncode(farmLock!.toJson());
                      final farmLockEncoded = Uri.encodeComponent(farmLockJson);
                      await context.push(
                        Uri(
                          path: FarmLockDepositSheet.routerPage,
                          queryParameters: {
                            'pool': poolEncoded,
                            'farmLock': farmLockEncoded,
                          },
                        ).toString(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
