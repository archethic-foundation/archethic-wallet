import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_token_balance.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/layouts/components/liquidity_add_need_tokens.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddToken1Amount extends ConsumerStatefulWidget {
  const LiquidityAddToken1Amount({
    super.key,
  });

  @override
  ConsumerState<LiquidityAddToken1Amount> createState() =>
      _LiquidityAddToken1AmountState();
}

class _LiquidityAddToken1AmountState
    extends ConsumerState<LiquidityAddToken1Amount> {
  late TextEditingController tokenAmountController;

  @override
  void initState() {
    super.initState();
    _updateAmountTextController();
  }

  void _updateAmountTextController() {
    final liquidityAdd = ref.read(liquidityAddFormNotifierProvider);
    tokenAmountController = TextEditingController();
    tokenAmountController.value = AmountTextInputFormatter(
      precision: 8,
    ).formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: liquidityAdd.token1Amount == 0
            ? ''
            : liquidityAdd.token1Amount.toString(),
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
    final liquidityAddNotifier =
        ref.watch(liquidityAddFormNotifierProvider.notifier);

    final liquidityAdd = ref.watch(liquidityAddFormNotifierProvider);

    if (liquidityAdd.tokenFormSelected != 1) {
      _updateAmountTextController();
    }

    return Column(
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
                          child: liquidityAdd.calculateToken1
                              ? const SizedBox(
                                  height: 48,
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                )
                              : TextField(
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  autocorrect: false,
                                  controller: tokenAmountController,
                                  onChanged: (text) async {
                                    liquidityAddNotifier
                                        .setTokenFormSelected(1);
                                    await liquidityAddNotifier.setToken1Amount(
                                      AppLocalizations.of(context)!,
                                      double.tryParse(
                                            text.replaceAll(' ', ''),
                                          ) ??
                                          0,
                                    );
                                  },
                                  onTap: () {
                                    liquidityAddNotifier
                                        .setTokenFormSelected(1);
                                  },
                                  textAlign: TextAlign.right,
                                  textInputAction: TextInputAction.done,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  inputFormatters: <TextInputFormatter>[
                                    AmountTextInputFormatter(
                                      precision: 8,
                                    ),
                                    LengthLimitingTextInputFormatter(
                                      liquidityAdd.token1Balance
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
                                    contentPadding: EdgeInsets.only(right: 10),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                DexTokenBalance(
                  tokenBalance: liquidityAdd.token1Balance,
                  token: liquidityAdd.token1,
                  fiatTextStyleMedium: true,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  aedappfm.ButtonHalf(
                    height: 40,
                    balanceAmount: liquidityAdd.token1Balance,
                    onTap: () async {
                      tokenAmountController.value = AmountTextInputFormatter(
                        precision: 8,
                      ).formatEditUpdate(
                        TextEditingValue.empty,
                        TextEditingValue(
                          text: (Decimal.parse(
                                    liquidityAdd.token1Balance.toString(),
                                  ) /
                                  Decimal.fromInt(2))
                              .toDouble()
                              .toString(),
                        ),
                      );
                      liquidityAddNotifier.setTokenFormSelected(1);
                      await liquidityAddNotifier.setToken1Amount(
                        AppLocalizations.of(context)!,
                        (Decimal.parse(
                                  liquidityAdd.token1Balance.toString(),
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
                    height: 40,
                    balanceAmount: liquidityAdd.token1Balance,
                    onTap: () async {
                      tokenAmountController.value = AmountTextInputFormatter(
                        precision: 8,
                      ).formatEditUpdate(
                        TextEditingValue.empty,
                        TextEditingValue(
                          text: liquidityAdd.token1Balance.toString(),
                        ),
                      );
                      liquidityAddNotifier.setTokenFormSelected(1);
                      await liquidityAddNotifier.setToken1Amount(
                        AppLocalizations.of(context)!,
                        liquidityAdd.token1Balance,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (liquidityAdd.token1 != null &&
                  (liquidityAdd.token1Balance == 0 ||
                      (liquidityAdd.failure != null &&
                          (liquidityAdd.failure! as aedappfm.OtherFailure)
                                  .cause ==
                              AppLocalizations.of(context)!
                                  .liquidityAddControlToken1AmountExceedBalance)))
                LiquidityAddNeedTokens(
                  balance: liquidityAdd.token1Balance,
                  token: liquidityAdd.token1!,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
