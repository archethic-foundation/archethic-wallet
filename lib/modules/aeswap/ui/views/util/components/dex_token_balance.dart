/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_lp_token_fiat_value.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/fiat_value.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DexTokenBalance extends ConsumerWidget {
  const DexTokenBalance({
    required this.tokenBalance,
    this.token,
    this.withFiat = true,
    this.fiatVertical = false,
    this.fiatAlignLeft = false,
    this.fiatTextStyleMedium = false,
    this.height = 30,
    this.pool,
    this.digits = 8,
    this.styleResponsive = true,
    this.withOpacity,
    super.key,
  });

  final double tokenBalance;
  final DexToken? token;
  final DexPool? pool;
  final int digits;
  final bool withFiat;
  final double height;
  final bool fiatVertical;
  final bool fiatAlignLeft;
  final bool fiatTextStyleMedium;
  final bool styleResponsive;
  final bool? withOpacity;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    if (token == null || token!.symbol.isEmpty) {
      return SizedBox(
        height: height,
      );
    }
    var opacity = withOpacity != null && withOpacity == false
        ? 1.0
        : AppTextStyles.kOpacityText;
    if (tokenBalance <= 0) {
      opacity = 0.5;
    }

    return fiatVertical
        ? Column(
            crossAxisAlignment: fiatAlignLeft
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    aedappfm.Iconsax.empty_wallet,
                    size: 14,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Opacity(
                    opacity: opacity,
                    child: SelectableText(
                      '${tokenBalance.formatNumber(precision: digits)} ${getSymbolDisplay(context, token!, tokenBalance)}',
                      style: fiatTextStyleMedium
                          ? styleResponsive
                              ? AppTextStyles.bodyMedium(context)
                              : Theme.of(context).textTheme.bodyMedium!
                          : styleResponsive
                              ? AppTextStyles.bodyLarge(context)
                              : Theme.of(context).textTheme.bodyLarge!,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (withFiat)
                    if (token != null && pool != null && token!.isLpToken)
                      Opacity(
                        opacity: opacity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 5,
                          ),
                          child: SelectableText(
                            ref.watch(
                              dexLPTokenFiatValueProvider(
                                pool!.pair.token1,
                                pool!.pair.token2,
                                tokenBalance,
                                pool!.poolAddress,
                              ),
                            ),
                            style: fiatTextStyleMedium
                                ? styleResponsive
                                    ? AppTextStyles.bodyMedium(context)
                                    : Theme.of(context).textTheme.bodyMedium!
                                : styleResponsive
                                    ? AppTextStyles.bodyLarge(context)
                                    : Theme.of(context).textTheme.bodyLarge!,
                          ),
                        ),
                      )
                    else
                      FutureBuilder<String>(
                        future: FiatValue().display(
                          ref,
                          token!,
                          tokenBalance,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Opacity(
                              opacity: opacity,
                              child: SelectableText(
                                snapshot.data!,
                                style: fiatTextStyleMedium
                                    ? styleResponsive
                                        ? AppTextStyles.bodyMedium(context)
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                    : styleResponsive
                                        ? AppTextStyles.bodyLarge(context)
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyLarge!,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                ],
              ),
            ],
          )
            .animate()
            .fade(
              duration: const Duration(milliseconds: 200),
            )
            .scale(
              duration: const Duration(milliseconds: 200),
            )
        : SizedBox(
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  aedappfm.Iconsax.empty_wallet,
                  size: 14,
                ),
                const SizedBox(
                  width: 5,
                ),
                Opacity(
                  opacity: opacity,
                  child: SelectableText(
                    '${tokenBalance.formatNumber(precision: digits)} ${getSymbolDisplay(context, token!, tokenBalance)}',
                    style: fiatTextStyleMedium
                        ? styleResponsive
                            ? AppTextStyles.bodyMedium(context)
                            : Theme.of(context).textTheme.bodyMedium!
                        : styleResponsive
                            ? AppTextStyles.bodyLarge(context)
                            : Theme.of(context).textTheme.bodyLarge!,
                  ),
                ),
                if (withFiat)
                  if (token != null && pool != null && token!.isLpToken)
                    Opacity(
                      opacity: opacity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                        ),
                        child: SelectableText(
                          ref.watch(
                            dexLPTokenFiatValueProvider(
                              pool!.pair.token1,
                              pool!.pair.token2,
                              tokenBalance,
                              pool!.poolAddress,
                            ),
                          ),
                          style: fiatTextStyleMedium
                              ? styleResponsive
                                  ? AppTextStyles.bodyMedium(context)
                                  : Theme.of(context).textTheme.bodyMedium!
                              : styleResponsive
                                  ? AppTextStyles.bodyLarge(context)
                                  : Theme.of(context).textTheme.bodyLarge!,
                        ),
                      ),
                    )
                  else
                    FutureBuilder<String>(
                      future: FiatValue().display(
                        ref,
                        token!,
                        tokenBalance,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Opacity(
                            opacity: opacity,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                              ),
                              child: SelectableText(
                                snapshot.data!,
                                style: fiatTextStyleMedium
                                    ? styleResponsive
                                        ? AppTextStyles.bodyMedium(context)
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                    : styleResponsive
                                        ? AppTextStyles.bodyLarge(context)
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyLarge!,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
              ],
            ),
          )
            .animate()
            .fade(
              duration: const Duration(milliseconds: 200),
            )
            .scale(
              duration: const Duration(milliseconds: 200),
            );
  }

  String getSymbolDisplay(
    BuildContext context,
    DexToken token,
    double balance,
  ) {
    if (token.isLpToken == true) {
      if (balance > 1) {
        return AppLocalizations.of(context)!.lpTokens;
      } else {
        return AppLocalizations.of(context)!.lpToken;
      }
    }
    return token.symbol.reduceSymbol();
  }
}
