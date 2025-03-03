import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_token_balance.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_textfield.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_remove/bloc/provider.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityRemoveLPTokenAmount extends ConsumerStatefulWidget {
  const LiquidityRemoveLPTokenAmount({
    super.key,
  });

  @override
  ConsumerState<LiquidityRemoveLPTokenAmount> createState() =>
      _LiquidityRemoveLPTokenAmountState();
}

class _LiquidityRemoveLPTokenAmountState
    extends ConsumerState<LiquidityRemoveLPTokenAmount> {
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
    final liquidityRemove = ref.read(liquidityRemoveFormNotifierProvider);
    tokenAmountController = TextEditingController();
    tokenAmountController.value = AmountTextInputFormatter(
      precision: 8,
    ).formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: liquidityRemove.lpTokenAmount == 0
            ? ''
            : liquidityRemove.lpTokenAmount
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
    final liquidityRemoveNotifier =
        ref.watch(liquidityRemoveFormNotifierProvider.notifier);

    final liquidityRemove = ref.watch(liquidityRemoveFormNotifierProvider);
    final textNum = double.tryParse(tokenAmountController.text);
    if (!(liquidityRemove.lpTokenAmount != 0.0 ||
        tokenAmountController.text == '' ||
        (textNum != null && textNum == 0))) {
      _updateAmountTextController();
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: _hasFocus ? Colors.black : null,
                    ),
                autocorrect: false,
                controller: tokenAmountController,
                onChanged: (text) async {
                  await liquidityRemoveNotifier.setLPTokenAmount(
                    double.tryParse(text.replaceAll(' ', '')) ?? 0,
                  );
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
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                      _hasFocus ? Colors.white : Colors.white.withOpacity(0.15),
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
                  buttonText:
                      aedappfm.AppLocalizations.of(context)!.aedappfm_btn_max,
                  onTap: () async {
                    await ref
                        .read(
                          liquidityRemoveFormNotifierProvider.notifier,
                        )
                        .setLpTokenAmountMax();
                    _updateAmountTextController();
                  },
                ),
              ),
            ],
          ),
        ),
        if (liquidityRemove.pool != null)
          Row(
            children: [
              DexTokenBalance(
                tokenBalance: liquidityRemove.lpTokenBalance,
                token: liquidityRemove.pool!.lpToken,
                pool: liquidityRemove.pool,
                fiatTextStyleMedium: true,
              ),
            ],
          ),
      ],
    );
  }
}
