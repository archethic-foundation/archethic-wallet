import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_token_balance.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_textfield.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_withdraw/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockWithdrawAmount extends ConsumerStatefulWidget {
  const FarmLockWithdrawAmount({
    super.key,
  });

  @override
  ConsumerState<FarmLockWithdrawAmount> createState() =>
      _FarmLockWithdrawToken1AmountState();
}

class _FarmLockWithdrawToken1AmountState
    extends ConsumerState<FarmLockWithdrawAmount> {
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
    final farmLockWithdraw = ref.read(farmLockWithdrawFormNotifierProvider);
    tokenAmountController = TextEditingController();
    tokenAmountController.value = AmountTextInputFormatter(
      precision: 8,
    ).formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: farmLockWithdraw.amount == 0
            ? ''
            : farmLockWithdraw.amount
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
    final farmLockWithdrawNotifier =
        ref.watch(farmLockWithdrawFormNotifierProvider.notifier);

    final farmLockWithdraw = ref.watch(farmLockWithdrawFormNotifierProvider);
    final textNum = double.tryParse(tokenAmountController.text);
    if (!(farmLockWithdraw.amount != 0.0 ||
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
                  farmLockWithdrawNotifier.setAmount(
                    AppLocalizations.of(context)!,
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
                  onTap: () {
                    ref
                        .read(
                          farmLockWithdrawFormNotifierProvider.notifier,
                        )
                        .setAmountMax(
                          AppLocalizations.of(context)!,
                        );
                    _updateAmountTextController();
                  },
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            DexTokenBalance(
              tokenBalance: farmLockWithdraw.depositedAmount!,
              token: farmLockWithdraw.lpToken,
              withFiat: false,
            ),
          ],
        ),
      ],
    );
  }
}
