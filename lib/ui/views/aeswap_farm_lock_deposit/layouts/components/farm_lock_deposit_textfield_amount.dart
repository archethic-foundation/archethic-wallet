import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_token_balance.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_textfield.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockDepositLPAmount extends ConsumerStatefulWidget {
  const FarmLockDepositLPAmount({
    super.key,
  });

  @override
  ConsumerState<FarmLockDepositLPAmount> createState() =>
      _FarmLockDepositLPAmountState();
}

class _FarmLockDepositLPAmountState
    extends ConsumerState<FarmLockDepositLPAmount> {
  late TextEditingController controller;

  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void dispose() {
    controller.dispose();
    _focusNode
      ..removeListener(_onFocusChange)
      ..dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    _updateAmountTextController();
  }

  void _updateAmountTextController() {
    final farmLockDeposit = ref.read(farmLockDepositFormNotifierProvider);
    controller = TextEditingController();
    controller.value = AmountTextInputFormatter(
      precision: 8,
    ).formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: farmLockDeposit.amount == 0
            ? ''
            : farmLockDeposit.amount
                .formatNumber(precision: 8)
                .replaceAll(',', ' '),
      ),
    );
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
    final farmLockDepositNotifier =
        ref.watch(farmLockDepositFormNotifierProvider.notifier);

    final farmLockDeposit = ref.watch(farmLockDepositFormNotifierProvider);
    final textNum = double.tryParse(controller.text);
    if (!(farmLockDeposit.amount != 0.0 ||
        controller.text == '' ||
        (textNum != null && textNum == 0))) {
      _updateAmountTextController();
    }

    return Column(
      children: [
        Row(
          children: [
            SelectableText(
              farmLockDeposit.farmLockDepositMode == FarmLockDepositMode.uco
                  ? AppLocalizations.of(context)!
                      .farmLockDepositTextFieldUCOLabel
                  : AppLocalizations.of(context)!
                      .farmLockDepositTextFieldLPLabel,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
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
                controller: controller,
                onChanged: (text) async {
                  await farmLockDepositNotifier.setAmount(
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
                  LengthLimitingTextInputFormatter(
                    farmLockDeposit.userBalance
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
                  onTap: () {
                    ref
                        .read(
                          farmLockDepositFormNotifierProvider.notifier,
                        )
                        .setAmountMax();
                    _updateAmountTextController();
                  },
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                DexTokenBalance(
                  tokenBalance: farmLockDeposit.userBalance,
                  token: farmLockDeposit.farmLockDepositMode ==
                          FarmLockDepositMode.uco
                      ? const DexToken(
                          address: kUCOAddress,
                          symbol: kUCOAddress,
                        )
                      : farmLockDeposit.pool!.lpToken,
                  pool: farmLockDeposit.pool,
                  fiatTextStyleMedium: true,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
