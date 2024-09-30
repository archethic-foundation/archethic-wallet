/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_token_balance.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/fiat_value.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/views/aeswap_swap/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_swap/layouts/components/swap_change.dart';
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
    final swap = ref.read(swapFormNotifierProvider);
    tokenAmountController = TextEditingController();
    tokenAmountController.value = AmountTextInputFormatter(
      precision: 8,
    ).formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: swap.tokenToSwapAmount == 0
            ? ''
            : swap.tokenToSwapAmount.toString(),
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
    final swapNotifier = ref.watch(swapFormNotifierProvider.notifier);

    final swap = ref.watch(swapFormNotifierProvider);
    if (swap.tokenFormSelected != 1) {
      _updateAmountTextController();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText(
              AppLocalizations.of(context)!.swapFromLbl,
              style: AppTextStyles.bodyMedium(context),
            ),
            if (swap.tokenToSwap != null)
              if (swap.calculationInProgress == false)
                FutureBuilder<String>(
                  future: FiatValue().display(
                    ref,
                    swap.tokenToSwap!,
                    swap.tokenToSwapAmount,
                    withParenthesis: false,
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
          ],
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
                                    padding: const EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: swap.calculateAmountToSwap
                                        ? const SizedBox(
                                            height: 48,
                                            child: Row(
                                              children: [
                                                Spacer(),
                                                SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 1,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                              ],
                                            ),
                                          )
                                        : TextField(
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                            autocorrect: false,
                                            controller: tokenAmountController,
                                            onChanged: (text) async {
                                              swapNotifier
                                                  .setTokenFormSelected(1);
                                              await swapNotifier
                                                  .setTokenToSwapAmount(
                                                double.tryParse(
                                                      text.replaceAll(' ', ''),
                                                    ) ??
                                                    0,
                                              );
                                            },
                                            onTap: () {
                                              swapNotifier
                                                  .setTokenFormSelected(1);
                                            },
                                            textAlign: TextAlign.right,
                                            textInputAction:
                                                TextInputAction.done,
                                            keyboardType: const TextInputType
                                                .numberWithOptions(
                                              decimal: true,
                                            ),
                                            inputFormatters: <TextInputFormatter>[
                                              AmountTextInputFormatter(
                                                precision: 8,
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
                                                  EdgeInsets.only(right: 10),
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
                    withOpacity: false,
                  )
                else
                  const SizedBox(
                    height: 30,
                  ),
                const SwapChange(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: swap.tokenToSwapBalance > 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        aedappfm.ButtonHalf(
                          balanceAmount: swap.tokenToSwapBalance,
                          height: 40,
                          style:
                              AppTextStyles.bodyMediumSecondaryColor(context),
                          onTap: () async {
                            tokenAmountController.value =
                                AmountTextInputFormatter(
                              precision: 8,
                            ).formatEditUpdate(
                              TextEditingValue.empty,
                              TextEditingValue(
                                text: (Decimal.parse(
                                          swap.tokenToSwapBalance.toString(),
                                        ) /
                                        Decimal.fromInt(2))
                                    .toDouble()
                                    .toString(),
                              ),
                            );
                            swapNotifier.setTokenFormSelected(1);
                            await swapNotifier.setTokenToSwapAmount(
                              (Decimal.parse(
                                        swap.tokenToSwapBalance.toString(),
                                      ) /
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
                          height: 40,
                          style:
                              AppTextStyles.bodyMediumSecondaryColor(context),
                          onTap: () async {
                            tokenAmountController.value =
                                AmountTextInputFormatter(
                              precision: 8,
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
                    )
                  : const SizedBox(
                      height: 40,
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
