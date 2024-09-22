import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_token_balance.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_remove/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveConfirmInfos extends ConsumerWidget {
  const LiquidityRemoveConfirmInfos({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final liquidityRemove =
        ref.watch(LiquidityRemoveFormProvider.liquidityRemoveForm);
    if (liquidityRemove.token1 == null) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: aedappfm.AppThemeBase.sheetBackgroundSecondary,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: aedappfm.AppThemeBase.sheetBorderSecondary,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!
                          .liquidityRemovePleaseConfirm,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    TextSpan(
                      text:
                          '${liquidityRemove.lpTokenAmount.formatNumber(precision: 8)} ',
                      style: AppTextStyles.bodyLargeSecondaryColor(context),
                    ),
                    TextSpan(
                      text: liquidityRemove.lpTokenAmount > 1
                          ? AppLocalizations.of(context)!
                              .liquidityRemoveAmountLPTokens
                          : AppLocalizations.of(context)!
                              .liquidityRemoveAmountLPToken,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: aedappfm.AppThemeBase.gradient,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Opacity(
                opacity: AppTextStyles.kOpacityText,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!.confirmBeforeLbl,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    SelectableText(
                      AppLocalizations.of(context)!.confirmAfterLbl,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: liquidityRemove.token1Balance,
                    token: liquidityRemove.token1,
                    height: 20,
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                    fiatAlignLeft: true,
                    fiatTextStyleMedium: true,
                    fiatVertical: true,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              liquidityRemove.token1Balance.toString(),
                            ) +
                            Decimal.parse(
                              liquidityRemove.token1AmountGetBack.toString(),
                            ))
                        .toDouble(),
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                    token: liquidityRemove.token1,
                    height: 20,
                    fiatTextStyleMedium: true,
                    fiatVertical: true,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: liquidityRemove.token2Balance,
                    token: liquidityRemove.token2,
                    height: 20,
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                    fiatAlignLeft: true,
                    fiatTextStyleMedium: true,
                    fiatVertical: true,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              liquidityRemove.token2Balance.toString(),
                            ) +
                            Decimal.parse(
                              liquidityRemove.token2AmountGetBack.toString(),
                            ))
                        .toDouble(),
                    token: liquidityRemove.token2,
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                    height: 20,
                    fiatTextStyleMedium: true,
                    fiatVertical: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: aedappfm.AppThemeBase.gradient,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Opacity(
                opacity: AppTextStyles.kOpacityText,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!.confirmBeforeLbl,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                    SelectableText(
                      AppLocalizations.of(context)!.confirmAfterLbl,
                      style: AppTextStyles.bodyLarge(context),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: liquidityRemove.lpTokenBalance,
                    token: liquidityRemove.pool!.lpToken,
                    withFiat: false,
                    height: 20,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              liquidityRemove.lpTokenBalance.toString(),
                            ) -
                            Decimal.parse(
                              liquidityRemove.lpTokenAmount.toString(),
                            ))
                        .toDouble(),
                    token: liquidityRemove.pool!.lpToken,
                    withFiat: false,
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 300))
        .scale(duration: const Duration(milliseconds: 300));
  }
}
