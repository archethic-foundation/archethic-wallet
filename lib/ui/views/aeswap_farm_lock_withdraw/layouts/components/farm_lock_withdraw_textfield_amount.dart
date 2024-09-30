import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_lp_token_fiat_value.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_token_balance.dart';
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
  late FocusNode tokenAmountFocusNode;

  @override
  void initState() {
    super.initState();
    tokenAmountFocusNode = FocusNode();
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
            : farmLockWithdraw.amount.toString(),
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
                              farmLockWithdrawNotifier.setAmount(
                                AppLocalizations.of(context)!,
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
                              LengthLimitingTextInputFormatter(10),
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
                  tokenBalance: farmLockWithdraw.depositedAmount!,
                  token: farmLockWithdraw.lpToken,
                  withFiat: false,
                ),
                const SizedBox(
                  width: 5,
                ),
                SelectableText(
                  ref.watch(
                    dexLPTokenFiatValueProvider(
                      farmLockWithdraw.lpTokenPair!.token1,
                      farmLockWithdraw.lpTokenPair!.token2,
                      farmLockWithdraw.depositedAmount!,
                      farmLockWithdraw.poolAddress!,
                    ),
                  ),
                  style: AppTextStyles.bodyLarge(context),
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
                    balanceAmount: farmLockWithdraw.depositedAmount!,
                    onTap: () {
                      ref
                          .read(
                            farmLockWithdrawFormNotifierProvider.notifier,
                          )
                          .setAmountHalf(
                            AppLocalizations.of(context)!,
                          );
                      _updateAmountTextController();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  aedappfm.ButtonMax(
                    height: 40,
                    balanceAmount: farmLockWithdraw.depositedAmount!,
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
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
