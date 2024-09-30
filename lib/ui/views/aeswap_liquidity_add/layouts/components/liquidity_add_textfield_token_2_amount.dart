/// SPDX-License-Identifier: AGPL-3.0-or-later
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

class LiquidityAddToken2Amount extends ConsumerStatefulWidget {
  const LiquidityAddToken2Amount({
    super.key,
  });

  @override
  ConsumerState<LiquidityAddToken2Amount> createState() =>
      _LiquidityAddToken2AmountState();
}

class _LiquidityAddToken2AmountState
    extends ConsumerState<LiquidityAddToken2Amount> {
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
        text: liquidityAdd.token2Amount == 0
            ? ''
            : liquidityAdd.token2Amount.toString(),
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

    if (liquidityAdd.tokenFormSelected != 2) {
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
                          child: liquidityAdd.calculateToken2
                              ? const SizedBox(
                                  width: 10,
                                  height: 48,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 317,
                                      right: 10,
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
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  autocorrect: false,
                                  controller: tokenAmountController,
                                  onChanged: (text) async {
                                    liquidityAddNotifier
                                        .setTokenFormSelected(2);
                                    await liquidityAddNotifier.setToken2Amount(
                                      AppLocalizations.of(context)!,
                                      double.tryParse(
                                            text.replaceAll(' ', ''),
                                          ) ??
                                          0,
                                    );
                                  },
                                  onTap: () {
                                    liquidityAddNotifier
                                        .setTokenFormSelected(2);
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
                                      liquidityAdd.token2Balance
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
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DexTokenBalance(
                  tokenBalance: liquidityAdd.token2Balance,
                  token: liquidityAdd.token2,
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
                    balanceAmount: liquidityAdd.token2Balance,
                    onTap: () async {
                      tokenAmountController.value = AmountTextInputFormatter(
                        precision: 8,
                      ).formatEditUpdate(
                        TextEditingValue.empty,
                        TextEditingValue(
                          text: (Decimal.parse(
                                    liquidityAdd.token2Balance.toString(),
                                  ) /
                                  Decimal.fromInt(2))
                              .toDouble()
                              .toString(),
                        ),
                      );
                      liquidityAddNotifier.setTokenFormSelected(2);
                      await liquidityAddNotifier.setToken2Amount(
                        AppLocalizations.of(context)!,
                        (Decimal.parse(
                                  liquidityAdd.token2Balance.toString(),
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
                    balanceAmount: liquidityAdd.token2Balance,
                    onTap: () async {
                      tokenAmountController.value = AmountTextInputFormatter(
                        precision: 8,
                      ).formatEditUpdate(
                        TextEditingValue.empty,
                        TextEditingValue(
                          text: liquidityAdd.token2Balance.toString(),
                        ),
                      );
                      liquidityAddNotifier.setTokenFormSelected(2);
                      await liquidityAddNotifier.setToken2Amount(
                        AppLocalizations.of(context)!,
                        liquidityAdd.token2Balance,
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
              if (liquidityAdd.token2 != null &&
                  (liquidityAdd.token2Balance == 0 ||
                      (liquidityAdd.failure != null &&
                          (liquidityAdd.failure! as aedappfm.OtherFailure)
                                  .cause ==
                              AppLocalizations.of(context)!
                                  .liquidityAddControlToken2AmountExceedBalance)))
                LiquidityAddNeedTokens(
                  balance: liquidityAdd.token2Balance,
                  token: liquidityAdd.token2!,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
