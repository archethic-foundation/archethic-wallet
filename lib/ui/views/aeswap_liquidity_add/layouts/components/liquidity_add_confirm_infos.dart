import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_token_balance.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/bloc/provider.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddConfirmInfos extends ConsumerWidget {
  const LiquidityAddConfirmInfos({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final liquidityAdd = ref.watch(LiquidityAddFormProvider.liquidityAddForm);
    if (liquidityAdd.token1 == null) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectableText(
                    AppLocalizations.of(context)!
                        .liquidityAddConfirmInfosAmountTokens,
                    style: AppTextStyles.bodyLarge(context),
                  ),
                  SelectableText(
                    AppLocalizations.of(context)!
                        .liquidityAddConfirmInfosMinAmount,
                    style: AppTextStyles.bodyLarge(context),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SelectableText(
                        liquidityAdd.token1Amount.formatNumber(precision: 8),
                        style: AppTextStyles.bodyLargeSecondaryColor(context),
                      ),
                      Tooltip(
                        message: liquidityAdd.token1!.symbol,
                        child: SelectableText(
                          ' ${liquidityAdd.token1!.symbol.reduceSymbol()}',
                          style: AppTextStyles.bodyLarge(context),
                        ),
                      ),
                    ],
                  ),
                  Tooltip(
                    message: liquidityAdd.token1!.symbol,
                    child: SelectableText(
                      '+${liquidityAdd.token1minAmount.formatNumber()} ${liquidityAdd.token1!.symbol.reduceSymbol()}',
                      style: AppTextStyles.bodyLarge(context),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SelectableText(
                        liquidityAdd.token2Amount.formatNumber(precision: 8),
                        style: AppTextStyles.bodyLargeSecondaryColor(context),
                      ),
                      Tooltip(
                        message: liquidityAdd.token2!.symbol,
                        child: SelectableText(
                          ' ${liquidityAdd.token2!.symbol.reduceSymbol()}',
                          style: AppTextStyles.bodyLarge(context),
                        ),
                      ),
                    ],
                  ),
                  Tooltip(
                    message: liquidityAdd.token2!.symbol,
                    child: SelectableText(
                      '+${liquidityAdd.token2minAmount.formatNumber()} ${liquidityAdd.token2!.symbol.reduceSymbol()}',
                      style: AppTextStyles.bodyLarge(context),
                    ),
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
              Row(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: liquidityAdd.token1Balance,
                    token: liquidityAdd.token1,
                    height: 20,
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                    fiatVertical: true,
                    fiatAlignLeft: true,
                    fiatTextStyleMedium: true,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              liquidityAdd.token1Balance.toString(),
                            ) -
                            Decimal.parse(liquidityAdd.token1Amount.toString()))
                        .toDouble(),
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                    token: liquidityAdd.token1,
                    height: 20,
                    fiatVertical: true,
                    fiatTextStyleMedium: true,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: liquidityAdd.token2Balance,
                    token: liquidityAdd.token2,
                    height: 20,
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                    fiatVertical: true,
                    fiatAlignLeft: true,
                    fiatTextStyleMedium: true,
                  ),
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              liquidityAdd.token2Balance.toString(),
                            ) -
                            Decimal.parse(liquidityAdd.token2Amount.toString()))
                        .toDouble(),
                    digits: aedappfm.Responsive.isMobile(context) ? 2 : 8,
                    token: liquidityAdd.token2,
                    height: 20,
                    fiatVertical: true,
                    fiatTextStyleMedium: true,
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
              Row(
                children: [
                  SelectableText(
                    '+${liquidityAdd.expectedTokenLP.formatNumber()} ',
                    style: AppTextStyles.bodyLargeSecondaryColor(context),
                  ),
                  SelectableText(
                    liquidityAdd.expectedTokenLP > 1
                        ? AppLocalizations.of(context)!.lpTokensExpected
                        : AppLocalizations.of(context)!.lpTokenExpected,
                    style: AppTextStyles.bodyLarge(context),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectableText(
                    AppLocalizations.of(context)!.confirmBeforeLbl,
                    style: AppTextStyles.bodyLarge(context),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: liquidityAdd.lpTokenBalance,
                    token: liquidityAdd.pool!.lpToken,
                    withFiat: false,
                    height: 20,
                    fiatTextStyleMedium: true,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectableText(
                    AppLocalizations.of(context)!.confirmAfterLbl,
                    style: AppTextStyles.bodyLarge(context),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DexTokenBalance(
                    tokenBalance: (Decimal.parse(
                              liquidityAdd.lpTokenBalance.toString(),
                            ) +
                            Decimal.parse(
                              liquidityAdd.expectedTokenLP.toString(),
                            ))
                        .toDouble(),
                    token: liquidityAdd.pool!.lpToken,
                    withFiat: false,
                    height: 20,
                    fiatTextStyleMedium: true,
                  ),
                ],
              ),
              if (liquidityAdd.messageMaxHalfUCO)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: 45,
                    child: aedappfm.InfoBanner(
                      AppLocalizations.of(context)!
                          .liquidityAddConfirmMessageMaxHalfUCO,
                      aedappfm.InfoBannerType.request,
                    ),
                  ),
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
