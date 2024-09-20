/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_token_balance.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/fiat_value.dart';
import 'package:aewallet/ui/views/aeswap_swap/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_swap/layouts/components/swap_change.dart';
import 'package:aewallet/ui/views/aeswap_swap/layouts/components/swap_icon_refresh.dart';
import 'package:aewallet/ui/views/aeswap_swap/layouts/components/swap_icon_settings.dart';
import 'package:aewallet/ui/views/aeswap_swap/layouts/components/swap_token_to_swap_selection.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapTokenToSwapAmount extends ConsumerStatefulWidget {
  const SwapTokenToSwapAmount({
    super.key,
  });

  @override
  ConsumerState<SwapTokenToSwapAmount> createState() =>
      _SwapTokenToSwapAmountState();
}

class _SwapTokenToSwapAmountState extends ConsumerState<SwapTokenToSwapAmount> {
  late TextEditingController tokenAmountController;

  @override
  void initState() {
    super.initState();
    _updateAmountTextController();
  }

  void _updateAmountTextController() {
    final swap = ref.read(SwapFormProvider.swapForm);
    tokenAmountController = TextEditingController();
    tokenAmountController.value = aedappfm.AmountTextInputFormatter(
      precision: 8,
      thousandsSeparator: ',',
      useUnifyDecimalSeparator: false,
    ).formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: swap.tokenToSwapAmount == 0
            ? ''
            : swap.tokenToSwapAmount
                .formatNumber(precision: 8)
                .replaceAll(',', ''),
      ),
    );
  }

  @override
  void dispose() {
    tokenAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final swapNotifier = ref.watch(SwapFormProvider.swapForm.notifier);

    final swap = ref.watch(SwapFormProvider.swapForm);
    if (swap.tokenFormSelected != 1) {
      _updateAmountTextController();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText(
              AppLocalizations.of(context)!.swapFromLbl,
              style: AppTextStyles.bodyMedium(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SelectableText(
                  '${AppLocalizations.of(context)!.slippage_tolerance} ${swap.slippageTolerance}%',
                  style: AppTextStyles.bodyMedium(context),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: SwapTokenIconSettings(),
                ),
                const SizedBox(
                  width: 5,
                ),
                const SwapTokenIconRefresh(),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Stack(
              alignment: Alignment.centerRight,
              children: [
                SizedBox(
                  width: aedappfm.AppThemeBase.sizeBoxComponentWidth,
                  child: Row(
                    children: [
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      width: 0.5,
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        Theme.of(context)
                                            .colorScheme
                                            .surface
                                            .withOpacity(1),
                                        Theme.of(context)
                                            .colorScheme
                                            .surface
                                            .withOpacity(0.3),
                                      ],
                                      stops: const [0, 1],
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left:
                                          aedappfm.Responsive.isMobile(context)
                                              ? 110
                                              : 160,
                                      right: 70,
                                    ),
                                    child: swap.calculateAmountToSwap
                                        ? const SizedBox(
                                            width: 10,
                                            height: 48,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: 10,
                                                right: 330,
                                                top: 15,
                                                bottom: 15,
                                              ),
                                              child: CircularProgressIndicator(
                                                strokeWidth: 1,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : TextField(
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            autocorrect: false,
                                            controller: tokenAmountController,
                                            onChanged: (text) async {
                                              swapNotifier
                                                  .setTokenFormSelected(1);
                                              await swapNotifier
                                                  .setTokenToSwapAmount(
                                                double.tryParse(
                                                      text.replaceAll(',', ''),
                                                    ) ??
                                                    0,
                                              );
                                            },
                                            onTap: () {
                                              swapNotifier
                                                  .setTokenFormSelected(1);
                                            },
                                            textAlign: TextAlign.left,
                                            textInputAction:
                                                TextInputAction.done,
                                            keyboardType: const TextInputType
                                                .numberWithOptions(
                                              decimal: true,
                                            ),
                                            inputFormatters: <TextInputFormatter>[
                                              aedappfm.AmountTextInputFormatter(
                                                precision: 8,
                                                thousandsSeparator: ',',
                                                useUnifyDecimalSeparator: false,
                                              ),
                                              LengthLimitingTextInputFormatter(
                                                swap.tokenToSwapBalance
                                                        .formatNumber(
                                                          precision: 0,
                                                        )
                                                        .length +
                                                    8 +
                                                    1,
                                              ),
                                            ],
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.only(left: 10),
                                            ),
                                          ),
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
                if (swap.tokenToSwap != null)
                  if (swap.calculationInProgress == false)
                    Positioned(
                      top: 17,
                      right: aedappfm.Responsive.isMobile(context) ? 5 : 10,
                      child: FutureBuilder<String>(
                        future: FiatValue().display(
                          ref,
                          swap.tokenToSwap!,
                          swap.tokenToSwapAmount,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SelectableText(
                              snapshot.data!,
                              style: Theme.of(context).textTheme.bodySmall,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    )
                  else
                    Container(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, right: 15),
                      child: const SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      ),
                    ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: SwapTokenToSwapSelection(),
            ),
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (swap.calculationInProgress == false)
                  DexTokenBalance(
                    tokenBalance: swap.tokenToSwapBalance,
                    token: swap.tokenToSwap,
                    digits: aedappfm.Responsive.isMobile(context) &&
                            swap.tokenToSwapBalance > 1
                        ? 2
                        : 8,
                    fiatTextStyleMedium: true,
                  )
                else
                  Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: const SizedBox(
                      height: 10,
                      width: 10,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    ),
                  ),
                const SwapChange(),
              ],
            ),
            if (swap.tokenToSwapBalance > 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  aedappfm.ButtonHalf(
                    balanceAmount: swap.tokenToSwapBalance,
                    onTap: () async {
                      tokenAmountController.value =
                          aedappfm.AmountTextInputFormatter(
                        precision: 8,
                        thousandsSeparator: ',',
                        useUnifyDecimalSeparator: false,
                      ).formatEditUpdate(
                        TextEditingValue.empty,
                        TextEditingValue(
                          text: (Decimal.parse(
                                    swap.tokenToSwapBalance.toString(),
                                  ) /
                                  Decimal.fromInt(2))
                              .toDouble()
                              .formatNumber(),
                        ),
                      );
                      swapNotifier.setTokenFormSelected(1);
                      await swapNotifier.setTokenToSwapAmount(
                        (Decimal.parse(swap.tokenToSwapBalance.toString()) /
                                Decimal.fromInt(2))
                            .toDouble(),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  aedappfm.ButtonMax(
                    balanceAmount: swap.tokenToSwapBalance,
                    onTap: () async {
                      tokenAmountController.value =
                          aedappfm.AmountTextInputFormatter(
                        precision: 8,
                        thousandsSeparator: ',',
                        useUnifyDecimalSeparator: false,
                      ).formatEditUpdate(
                        TextEditingValue.empty,
                        TextEditingValue(
                          text: swap.tokenToSwapBalance.toString(),
                        ),
                      );
                      swapNotifier.setTokenFormSelected(1);
                      await swapNotifier
                          .setTokenToSwapAmount(swap.tokenToSwapBalance);
                    },
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
