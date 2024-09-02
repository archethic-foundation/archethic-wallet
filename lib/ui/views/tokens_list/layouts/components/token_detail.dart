import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/farm_apr.dart';
import 'package:aewallet/application/price_history/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/address_formatters.dart';
import 'package:aewallet/ui/views/tokens_detail/layouts/token_detail_sheet.dart';
import 'package:aewallet/ui/widgets/balance/balance_infos.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class TokenDetail extends ConsumerStatefulWidget {
  const TokenDetail({
    super.key,
    required this.aeToken,
  });

  final aedappfm.AEToken aeToken;

  @override
  ConsumerState<TokenDetail> createState() => _TokenDetailState();
}

class _TokenDetailState extends ConsumerState<TokenDetail> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(SettingsProviders.settings);
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    final apr = ref.watch(FarmAPRProviders.farmAPR);
    final price = widget.aeToken.isVerified
        ? ref
            .watch(
              aedappfm.AETokensProviders.estimateTokenInFiat(
                widget.aeToken,
              ),
            )
            .valueOrNull
        : 0.0;

    final priceHistory = ref
        .watch(PriceHistoryProviders.priceHistory(ucid: widget.aeToken.ucid))
        .valueOrNull;
    return InkWell(
      onTap: () async {
        if (priceHistory == null) return;

        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              settings.activeVibrations,
            );

        await context.push(
          TokenDetailSheet.routerPage,
          extra: {
            'aeToken': widget.aeToken.toJson(),
          },
        );
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          aedappfm.BlockInfo(
            width: MediaQuery.of(context).size.width,
            height: widget.aeToken.isUCO ? 110 : 80,
            borderWith: widget.aeToken.isUCO ? 2 : 1,
            info: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      if (widget.aeToken.icon != null &&
                          widget.aeToken.icon!.isNotEmpty)
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/bc-logos/${widget.aeToken.icon}',
                              width: 20,
                              height: 20,
                            ),
                          ],
                        )
                      else
                        const SizedBox(
                          width: 30,
                        ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AutoSizeText(
                                  minFontSize: 5,
                                  wrapWords: false,
                                  widget.aeToken.symbol,
                                  style: ArchethicThemeStyles
                                      .textStyleSize18W600MainButtonLabel,
                                ),
                                if (widget.aeToken.isVerified)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                      bottom: 1,
                                    ),
                                    child: Icon(
                                      Symbols.verified,
                                      color: ArchethicTheme.activeColorSwitch,
                                      size: 15,
                                    ),
                                  ),
                              ],
                            ),

                            if (settings.showBalances == true)
                              Row(
                                children: [
                                  if (widget.aeToken.isLpToken)
                                    AutoSizeText(
                                      minFontSize: 5,
                                      wrapWords: false,
                                      '${widget.aeToken.balance.formatNumber(precision: 8)} ${widget.aeToken.lpTokenPair!.token1.symbol.reduceSymbol()}/${widget.aeToken.lpTokenPair!.token2.symbol.reduceSymbol()}',
                                      style: ArchethicThemeStyles
                                          .textStyleSize12W100Primary,
                                    )
                                  else
                                    AutoSizeText(
                                      minFontSize: 5,
                                      wrapWords: false,
                                      '${widget.aeToken.balance.formatNumber(precision: 8)} ${widget.aeToken.symbol.reduceSymbol(lengthMax: 10)}',
                                      style: ArchethicThemeStyles
                                          .textStyleSize12W100Primary,
                                    ),
                                  const SizedBox(width: 5),
                                  if (price != null && price > 0)
                                    AutoSizeText(
                                      minFontSize: 5,
                                      wrapWords: false,
                                      '\$${(widget.aeToken.balance * price).formatNumber(precision: 2)}',
                                      textAlign: TextAlign.center,
                                      style: ArchethicThemeStyles
                                          .textStyleSize12W100Primary,
                                    ),
                                ],
                              )
                            else
                              Row(
                                children: [
                                  Text(
                                    '···········',
                                    style: ArchethicThemeStyles
                                        .textStyleSize12W100Primary60,
                                  ),
                                  const SizedBox(width: 5),
                                ],
                              ),
                            if (widget.aeToken.isVerified == false)
                              AutoSizeText(
                                AddressFormatters(
                                  widget.aeToken.address ?? '',
                                ).getShortString4(),
                                style: ArchethicThemeStyles
                                    .textStyleSize12W100Primary,
                              ),

                            /// KPI
                            if (settings.showPriceChart &&
                                priceHistory != null &&
                                widget.aeToken.isVerified &&
                                widget.aeToken.ucid != null &&
                                connectivityStatusProvider ==
                                    ConnectivityStatus.isConnected)
                              BalanceInfosKpi(
                                chartInfos: priceHistory,
                                aeToken: widget.aeToken,
                              ),

                            if (widget.aeToken.isUCO)
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .earnValueLbl,
                                      style: ArchethicThemeStyles
                                          .textStyleSize14W200Primary,
                                    ),
                                    Text(
                                      ' $apr ',
                                      style: ArchethicThemeStyles
                                          .textStyleSize14W200PrimaryPositiveValue,
                                    ),
                                    Text(
                                      'APR',
                                      style: ArchethicThemeStyles
                                          .textStyleSize14W200Primary,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            blockInfoColor: widget.aeToken.isUCO
                ? aedappfm.BlockInfoColor.purple
                : widget.aeToken.isLpToken
                    ? aedappfm.BlockInfoColor.neutral
                    : aedappfm.BlockInfoColor.blue,
          ),

          const Positioned(
            right: 5,
            top: 30,
            child: Icon(
              Symbols.keyboard_arrow_right,
              weight: IconSize.weightM,
              opticalSize: IconSize.opticalSizeM,
              grade: IconSize.gradeM,
              size: 16,
            ),
          ),

          /// PRICE CHART
          if (settings.showPriceChart &&
              priceHistory != null &&
              widget.aeToken.isVerified &&
              widget.aeToken.ucid != null &&
              connectivityStatusProvider == ConnectivityStatus.isConnected)
            Positioned(
              child: Column(
                children: [
                  BalanceInfosChart(
                    chartInfos: priceHistory,
                  ),
                  Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: ArchethicTheme.text.withOpacity(0.05),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
