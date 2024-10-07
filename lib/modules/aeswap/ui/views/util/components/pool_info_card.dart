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
    required this.pool,
    required this.tokenAddressRatioPrimary,
    super.key,
  });

  final DexPool pool;
  final String tokenAddressRatioPrimary;

  @override
  ConsumerState<PoolInfoCard> createState() => _PoolInfoCardState();
}

class _PoolInfoCardState extends ConsumerState<PoolInfoCard> {
  bool _isExpanded = false;

  @override
  Widget build(
    BuildContext context,
  ) {
    final poolInfos = ref.watch(
      DexPoolProviders.poolInfos(widget.pool.poolAddress),
    );

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
                        pool: widget.pool,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          poolInfos.when(
                            data: (data) {
                              return Row(
                                children: [
                                  PoolDetailsInfoSwapFees(
                                    poolInfos: data,
                                    style: AppTextStyles.bodyLarge(context),
                                  ),
                                  PoolDetailsInfoProtocolFees(
                                    poolInfos: data,
                                    style: AppTextStyles.bodyLarge(context),
                                  ),
                                ],
                              );
                            },
                            error: (error, st) => const SizedBox.shrink(),
                            loading: () => const SizedBox(
                              width: 10,
                              height: 10,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          if (widget.pool.pair.token1.isUCO == false)
                            Opacity(
                              opacity: AppTextStyles.kOpacityText,
                              child: Row(
                                children: [
                                  Tooltip(
                                    message: widget.pool.pair.token1.symbol,
                                    child: FormatAddressLinkCopy(
                                      header: widget.pool.pair.token1.symbol,
                                      address: widget.pool.pair.token1.address
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
                                    address: widget.pool.pair.token1.address,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          if (widget.pool.pair.token2.isUCO == false)
                            Opacity(
                              opacity: AppTextStyles.kOpacityText,
                              child: Row(
                                children: [
                                  Tooltip(
                                    message: widget.pool.pair.token2.symbol,
                                    child: FormatAddressLinkCopy(
                                      header: widget.pool.pair.token2.symbol,
                                      address: widget.pool.pair.token2.address
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
                                    address: widget.pool.pair.token2.address,
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
                            child: _getPairName(context, widget.pool),
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
                              poolInfos.when(
                                data: (data) {
                                  return Row(
                                    children: [
                                      PoolDetailsInfoSwapFees(
                                        poolInfos: data,
                                        style: AppTextStyles.bodyLarge(context),
                                      ),
                                      PoolDetailsInfoProtocolFees(
                                        poolInfos: data,
                                        style: AppTextStyles.bodyLarge(context),
                                      ),
                                    ],
                                  );
                                },
                                error: (error, st) => const SizedBox.shrink(),
                                loading: () => const SizedBox.shrink(),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              if (widget.pool.pair.token1.isUCO == false)
                                Opacity(
                                  opacity: AppTextStyles.kOpacityText,
                                  child: Row(
                                    children: [
                                      Tooltip(
                                        message: widget.pool.pair.token1.symbol,
                                        child: FormatAddressLinkCopy(
                                          header:
                                              widget.pool.pair.token1.symbol,
                                          address: widget
                                              .pool.pair.token1.address
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
                                        address:
                                            widget.pool.pair.token1.address,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              if (widget.pool.pair.token2.isUCO == false)
                                Opacity(
                                  opacity: AppTextStyles.kOpacityText,
                                  child: Row(
                                    children: [
                                      Tooltip(
                                        message: widget.pool.pair.token2.symbol,
                                        child: FormatAddressLinkCopy(
                                          header:
                                              widget.pool.pair.token2.symbol,
                                          address: widget
                                              .pool.pair.token2.address
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
                                        address:
                                            widget.pool.pair.token2.address,
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
