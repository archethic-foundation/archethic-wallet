/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_token_balance.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/fiat_value.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/views/aeswap_swap/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_swap/layouts/components/swap_token_swapped_selection.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapTokenSwappedAmount extends ConsumerStatefulWidget {
  const SwapTokenSwappedAmount({
    super.key,
  });

  @override
  ConsumerState<SwapTokenSwappedAmount> createState() =>
      _SwapTokenSwappedAmountState();
}

class _SwapTokenSwappedAmountState
    extends ConsumerState<SwapTokenSwappedAmount> {
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
        text: swap.tokenSwappedAmount == 0
            ? ''
            : swap.tokenSwappedAmount
                .formatNumber(precision: 8)
                .replaceAll(',', ' '),
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
    final tokenSwappedBalance =
        ref.watch(tokenSwappedBalanceProvider).value ?? 0;
    final swap = ref.watch(swapFormNotifierProvider);
    if (swap.tokenFormSelected != 2) {
      _updateAmountTextController();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText(
              AppLocalizations.of(context)!.swapToEstimatedLbl,
              style: AppTextStyles.bodyMedium(context),
            ),
            if (swap.tokenSwapped != null)
              if (swap.calculationInProgress == false)
                FutureBuilder<String>(
                  future: FiatValue().display(
                    ref,
                    swap.tokenSwapped!,
                    swap.tokenSwappedAmount,
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
                )
              else
                Container(
                  padding:
                      const EdgeInsets.only(top: 10, bottom: 10, right: 15),
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
                                    child: swap.calculateAmountSwapped
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
                                                  .setTokenFormSelected(2);
                                              await swapNotifier
                                                  .setTokenSwappedAmount(
                                                double.tryParse(
                                                      text.replaceAll(' ', ''),
                                                    ) ??
                                                    0,
                                              );
                                            },
                                            onTap: () {
                                              swapNotifier
                                                  .setTokenFormSelected(2);
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
                                                tokenSwappedBalance
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
              child: SwapTokenSwappedSelection(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (swap.calculationInProgress == false)
              DexTokenBalance(
                tokenBalance: tokenSwappedBalance,
                token: swap.tokenSwapped,
                digits: aedappfm.Responsive.isMobile(context) &&
                        tokenSwappedBalance > 1
                    ? 2
                    : 8,
                fiatTextStyleMedium: true,
                withOpacity: false,
              )
            else
              const SizedBox(
                height: 30,
              ),
            /*if (swap.tokenSwappedBalance > 0)
              Row(
                children: [
                  aedappfm.ButtonHalf(
                    balanceAmount: swap.tokenSwappedBalance,
                    onTap: () async {
                      tokenAmountController.value =
                          AmountTextInputFormatter(precision: 8,
)
                              .formatEditUpdate(
                        TextEditingValue.empty,
                        TextEditingValue(
                          text: (Decimal.parse(
                                    swap.tokenSwappedBalance.toString(),
                                  ) /
                                  Decimal.fromInt(2))
                              .toDouble()
                              .toString(),
                        ),
                      );
                      swapNotifier.setTokenFormSelected(2);
                      await swapNotifier.setTokenSwappedAmount(
                        (Decimal.parse(swap.tokenSwappedBalance.toString()) /
                                Decimal.fromInt(2))
                            .toDouble(),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  aedappfm.ButtonMax(
                    balanceAmount: swap.tokenSwappedBalance,
                    onTap: () async {
                      tokenAmountController.value =
                          AmountTextInputFormatter(precision: 8,
   )
                              .formatEditUpdate(
                        TextEditingValue.empty,
                        TextEditingValue(
                          text: swap.tokenSwappedBalance.toString(),
                        ),
                      );
                      swapNotifier.setTokenFormSelected(2);
                      await swapNotifier
                          .setTokenSwappedAmount(swap.tokenSwappedBalance);
                    },
                  ),
                ],
              ),*/
          ],
        ),
      ],
    );
  }
}
