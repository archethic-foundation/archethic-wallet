import 'package:aewallet/modules/aeswap/application/pool/dex_pool.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/ui/views/aeswap_pool_list/layouts/components/pool_details_info_header.dart';
import 'package:aewallet/modules/aeswap/ui/views/aeswap_pool_list/layouts/components/pool_details_info_protocol_fees.dart';
import 'package:aewallet/modules/aeswap/ui/views/aeswap_pool_list/layouts/components/pool_details_info_swap_fees.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_token_icon.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/format_address_link_copy.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/verified_token_icon.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoolInfoCard extends ConsumerStatefulWidget {
  const PoolInfoCard({
    required this.poolGenesisAddress,
    required this.tokenAddressRatioPrimary,
    super.key,
  });

  final String poolGenesisAddress;
  final String tokenAddressRatioPrimary;

  @override
  ConsumerState<PoolInfoCard> createState() => _PoolInfoCardState();
}

class _PoolInfoCardState extends ConsumerState<PoolInfoCard> {
  bool _isExpanded = false;
  DexPool? pool;
  double? tvl;

  @override
  void initState() {
    Future(() async {
      await loadInfo();
    });
    super.initState();
  }

  Future<void> loadInfo({bool forceLoadFromBC = false}) async {
    pool = await ref
        .read(DexPoolProviders.getPool(widget.poolGenesisAddress).future);
    pool = await ref.read(DexPoolProviders.loadPoolCard(pool!).future);
    tvl = await ref.read(
      DexPoolProviders.estimatePoolTVLInFiat(pool).future,
    );
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    if (widget.poolGenesisAddress.isEmpty ||
        pool == null ||
        pool!.infos == null ||
        tvl == null) {
      return const SizedBox.shrink();
    }

    return aedappfm.Responsive.isDesktop(context) ||
            aedappfm.Responsive.isTablet(context)
        ? DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: aedappfm.AppThemeBase.sheetBackgroundSecondary,
              border: Border.all(
                color: aedappfm.AppThemeBase.sheetBorderSecondary,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 20,
                right: 20,
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PoolDetailsInfoHeader(
                        pool: pool,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              PoolDetailsInfoSwapFees(
                                poolInfos: pool?.infos,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              PoolDetailsInfoProtocolFees(
                                poolInfos: pool?.infos,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          if (pool!.pair.token1.isUCO == false)
                            Opacity(
                              opacity: AppTextStyles.kOpacityText,
                              child: Row(
                                children: [
                                  Tooltip(
                                    message: pool!.pair.token1.symbol,
                                    child: FormatAddressLinkCopy(
                                      header: pool!.pair.token1.symbol,
                                      address: pool!.pair.token1.address
                                          .toUpperCase(),
                                      typeAddress:
                                          TypeAddressLinkCopy.transaction,
                                      reduceAddress: true,
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .fontSize!,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  VerifiedTokenIcon(
                                    address: pool!.pair.token1.address,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          if (pool!.pair.token2.isUCO == false)
                            Opacity(
                              opacity: AppTextStyles.kOpacityText,
                              child: Row(
                                children: [
                                  Tooltip(
                                    message: pool!.pair.token2.symbol,
                                    child: FormatAddressLinkCopy(
                                      header: pool!.pair.token2.symbol,
                                      address: pool!.pair.token2.address
                                          .toUpperCase(),
                                      typeAddress:
                                          TypeAddressLinkCopy.transaction,
                                      reduceAddress: true,
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .fontSize!,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  VerifiedTokenIcon(
                                    address: pool!.pair.token2.address,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: aedappfm.AppThemeBase.sheetBackgroundSecondary,
                    border: Border.all(
                      color: aedappfm.AppThemeBase.sheetBorderSecondary,
                    ),
                  ),
                  child: ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _isExpanded = isExpanded;
                      });
                    },
                    children: [
                      ExpansionPanel(
                        canTapOnHeader: true,
                        backgroundColor: Colors.transparent,
                        headerBuilder: (
                          BuildContext context,
                          bool isExpanded,
                        ) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                            ),
                            child: _getPairName(context, pool!),
                          );
                        },
                        body: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            bottom: 5,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  PoolDetailsInfoSwapFees(
                                    poolInfos: pool?.infos,
                                    style: AppTextStyles.bodyLarge(context),
                                  ),
                                  PoolDetailsInfoProtocolFees(
                                    poolInfos: pool?.infos,
                                    style: AppTextStyles.bodyLarge(context),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              if (pool!.pair.token1.isUCO == false)
                                Opacity(
                                  opacity: AppTextStyles.kOpacityText,
                                  child: Row(
                                    children: [
                                      Tooltip(
                                        message: pool!.pair.token1.symbol,
                                        child: FormatAddressLinkCopy(
                                          header: pool!.pair.token1.symbol,
                                          address: pool!.pair.token1.address
                                              .toUpperCase(),
                                          typeAddress:
                                              TypeAddressLinkCopy.transaction,
                                          reduceAddress: true,
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .fontSize!,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      VerifiedTokenIcon(
                                        address: pool!.pair.token1.address,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              if (pool!.pair.token2.isUCO == false)
                                Opacity(
                                  opacity: AppTextStyles.kOpacityText,
                                  child: Row(
                                    children: [
                                      Tooltip(
                                        message: pool!.pair.token2.symbol,
                                        child: FormatAddressLinkCopy(
                                          header: pool!.pair.token2.symbol,
                                          address: pool!.pair.token2.address
                                              .toUpperCase(),
                                          typeAddress:
                                              TypeAddressLinkCopy.transaction,
                                          reduceAddress: true,
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .fontSize!,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      VerifiedTokenIcon(
                                        address: pool!.pair.token2.address,
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        isExpanded: _isExpanded,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
            .animate()
            .fade(duration: const Duration(milliseconds: 200))
            .scale(duration: const Duration(milliseconds: 200));
  }

  Widget _getPairName(
    BuildContext context,
    DexPool pool,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DexTokenIcon(
          tokenAddress: pool.pair.token1.address,
        ),
        const SizedBox(
          width: 10,
        ),
        Tooltip(
          message: pool.pair.token1.symbol,
          child: SelectableText(
            pool.pair.token1.symbol.reduceSymbol(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: SelectableText('/'),
        ),
        DexTokenIcon(
          tokenAddress: pool.pair.token2.address,
        ),
        const SizedBox(
          width: 10,
        ),
        Tooltip(
          message: pool.pair.token2.symbol,
          child: SelectableText(
            pool.pair.token2.symbol.reduceSymbol(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ],
    );
  }
}
