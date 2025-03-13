/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_token_balance.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_textfield.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/layouts/components/liquidity_add_need_tokens.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
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

  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
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
            : liquidityAdd.token2Amount
                .formatNumber(precision: 8)
                .replaceAll(',', ' '),
      ),
    );
  }

  @override
  void dispose() {
    tokenAmountController.dispose();
    _focusNode
      ..removeListener(_onFocusChange)
      ..dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
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
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              if (liquidityAdd.calculateToken2)
                const SizedBox(
                  height: 48,
                  child: Row(
                    children: [
                      Spacer(),
                      SizedBox(
                        width: 10,
                        height: 10,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 70),
                    ],
                  ),
                )
              else
                TextField(
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: _hasFocus ? Colors.black : null,
                      ),
                  autocorrect: false,
                  controller: tokenAmountController,
                  onChanged: (text) async {
                    liquidityAddNotifier.setTokenFormSelected(2);
                    await liquidityAddNotifier.setToken2Amount(
                      AppLocalizations.of(context)!,
                      double.tryParse(
                            text.replaceAll(' ', ''),
                          ) ??
                          0,
                    );
                  },
                  onTap: () {
                    liquidityAddNotifier.setTokenFormSelected(2);
                  },
                  focusNode: _focusNode,
                  textAlign: TextAlign.left,
                  textInputAction: TextInputAction.done,
                  keyboardType: const TextInputType.numberWithOptions(
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
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: _hasFocus
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.15),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusColor: Colors.white,
                    contentPadding: const EdgeInsets.only(left: 10),
                  ),
                ),
              Positioned(
                right: 10,
                child: BtnTextField(
                  buttonText: Text(
                    aedappfm.AppLocalizations.of(context)!.aedappfm_btn_max,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeightTelegraf.fontWeightRegular,
                        ),
                  ),
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
              ),
            ],
          ),
        ),
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
