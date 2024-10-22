import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_lp_token_fiat_value.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_token_balance.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/bloc/provider.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockDepositAmount extends ConsumerStatefulWidget {
  const FarmLockDepositAmount({
    super.key,
  });

  @override
  ConsumerState<FarmLockDepositAmount> createState() =>
      _FarmLockDepositToken1AmountState();
}

class _FarmLockDepositToken1AmountState
    extends ConsumerState<FarmLockDepositAmount> {
  late TextEditingController tokenAmountController;
  late FocusNode tokenAmountFocusNode;

  @override
  void initState() {
    super.initState();
    tokenAmountFocusNode = FocusNode();
    _updateAmountTextController();
  }

  void _updateAmountTextController() {
    final farmLockDeposit = ref.read(farmLockDepositFormNotifierProvider);
    tokenAmountController = TextEditingController();
    tokenAmountController.value = AmountTextInputFormatter(
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

  @override
  void dispose() {
    tokenAmountFocusNode.dispose();
    tokenAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final farmLockDepositNotifier =
        ref.watch(farmLockDepositFormNotifierProvider.notifier);

    final farmLockDeposit = ref.watch(farmLockDepositFormNotifierProvider);
    final textNum = double.tryParse(tokenAmountController.text);
    if (!(farmLockDeposit.amount != 0.0 ||
        tokenAmountController.text == '' ||
        (textNum != null && textNum == 0))) {
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
                          child: TextField(
                            style: Theme.of(context).textTheme.bodyLarge,
                            autocorrect: false,
                            controller: tokenAmountController,
                            onChanged: (text) async {
                              farmLockDepositNotifier.setAmount(
                                double.tryParse(text.replaceAll(' ', '')) ?? 0,
                              );
                            },
                            focusNode: tokenAmountFocusNode,
                            textAlign: TextAlign.right,
                            textInputAction: TextInputAction.done,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: <TextInputFormatter>[
                              AmountTextInputFormatter(
                                precision: 8,
                              ),
                              LengthLimitingTextInputFormatter(
                                farmLockDeposit.lpTokenBalance
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
              children: [
                DexTokenBalance(
                  tokenBalance: farmLockDeposit.lpTokenBalance,
                  token: farmLockDeposit.pool!.lpToken,
                  withFiat: false,
                  fiatTextStyleMedium: true,
                  withOpacity: false,
                ),
                const SizedBox(
                  width: 5,
                ),
                Opacity(
                  opacity: AppTextStyles.kOpacityText,
                  child: SelectableText(
                    ref.watch(
                      dexLPTokenFiatValueProvider(
                        farmLockDeposit.pool!.pair.token1,
                        farmLockDeposit.pool!.pair.token2,
                        farmLockDeposit.lpTokenBalance,
                        farmLockDeposit.pool!.poolAddress,
                      ),
                    ),
                    style: AppTextStyles.bodyMedium(context),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  aedappfm.ButtonHalf(
                    height: 40,
                    balanceAmount: farmLockDeposit.lpTokenBalance,
                    onTap: () {
                      ref
                          .read(
                            farmLockDepositFormNotifierProvider.notifier,
                          )
                          .setAmountHalf();
                      _updateAmountTextController();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  aedappfm.ButtonMax(
                    height: 40,
                    balanceAmount: farmLockDeposit.lpTokenBalance,
                    onTap: () {
                      ref
                          .read(
                            farmLockDepositFormNotifierProvider.notifier,
                          )
                          .setAmountMax();
                      _updateAmountTextController();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
