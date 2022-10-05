/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';

class BalanceIndicatorWidget extends StatefulWidget {
  const BalanceIndicatorWidget({
    super.key,
    this.primaryCurrency,
    this.onPrimaryCurrencySelected,
    this.displaySwitchButton = true,
  });

  final PrimaryCurrencySetting? primaryCurrency;
  final ValueChanged<PrimaryCurrency>? onPrimaryCurrencySelected;
  final bool displaySwitchButton;

  @override
  State<BalanceIndicatorWidget> createState() => _BalanceIndicatorWidgetState();
}

enum PrimaryCurrency { fiat, native }

class _BalanceIndicatorWidgetState extends State<BalanceIndicatorWidget> {
  PrimaryCurrency primaryCurrency = PrimaryCurrency.native;

  @override
  void initState() {
    super.initState();
    if (widget.primaryCurrency!.primaryCurrency.name ==
        PrimaryCurrencySetting(AvailablePrimaryCurrency.native)
            .primaryCurrency
            .name) {
      primaryCurrency = PrimaryCurrency.native;
    } else {
      primaryCurrency = PrimaryCurrency.fiat;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StateContainer.of(context).showBalance
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (primaryCurrency == PrimaryCurrency.native)
                Column(
                  children: const [
                    _BalanceIndicatorNative(
                      primary: true,
                    ),
                    _BalanceIndicatorFiat(
                      primary: false,
                    ),
                  ],
                )
              else
                Column(
                  children: const [
                    _BalanceIndicatorFiat(
                      primary: true,
                    ),
                    _BalanceIndicatorNative(
                      primary: false,
                    ),
                  ],
                ),
              const SizedBox(
                width: 10,
              ),
              if (widget.displaySwitchButton == true)
                IconButton(
                  icon: const Icon(Icons.change_circle),
                  alignment: Alignment.centerRight,
                  color: StateContainer.of(context).curTheme.textFieldIcon,
                  onPressed: () {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          StateContainer.of(context).activeVibrations,
                        );
                    if (primaryCurrency == PrimaryCurrency.native) {
                      setState(() {
                        primaryCurrency = PrimaryCurrency.fiat;
                      });
                    } else {
                      setState(() {
                        primaryCurrency = PrimaryCurrency.native;
                      });
                    }
                    widget.onPrimaryCurrencySelected!(primaryCurrency);
                  },
                ),
            ],
          )
        : const SizedBox();
  }
}

class _BalanceIndicatorFiat extends StatelessWidget {
  const _BalanceIndicatorFiat({required this.primary});

  final bool primary;

  @override
  Widget build(BuildContext context) {
    final accountSelectedBalance = StateContainer.of(context)
        .appWallet!
        .appKeychain!
        .getAccountSelected()!
        .balance;

    return RichText(
      text: TextSpan(
        text: '',
        children: <InlineSpan>[
          if (primary == false)
            TextSpan(
              text: '(',
              style: primary
                  ? AppStyles.textStyleSize16W100Primary(context)
                  : AppStyles.textStyleSize14W100Primary(context),
            ),
          TextSpan(
            text: CurrencyUtil.getConvertedAmount(
              StateContainer.of(context).curCurrency.currency.name,
              accountSelectedBalance!.fiatCurrencyValue!,
            ),
            style: primary
                ? AppStyles.textStyleSize16W700Primary(context)
                : AppStyles.textStyleSize14W700Primary(context),
          ),
          if (primary == false)
            TextSpan(
              text: ')',
              style: primary
                  ? AppStyles.textStyleSize16W100Primary(context)
                  : AppStyles.textStyleSize14W100Primary(context),
            ),
        ],
      ),
    );
  }
}

class _BalanceIndicatorNative extends StatelessWidget {
  const _BalanceIndicatorNative({required this.primary});

  final bool primary;

  @override
  Widget build(BuildContext context) {
    final accountSelectedBalance = StateContainer.of(context)
        .appWallet!
        .appKeychain!
        .getAccountSelected()!
        .balance;

    return RichText(
      text: TextSpan(
        text: '',
        children: <InlineSpan>[
          if (primary == false)
            TextSpan(
              text: '(',
              style: primary
                  ? AppStyles.textStyleSize16W100Primary(context)
                  : AppStyles.textStyleSize14W100Primary(context),
            ),
          TextSpan(
            text:
                '${accountSelectedBalance!.nativeTokenValueToString()} ${accountSelectedBalance.nativeTokenName!}',
            style: primary
                ? AppStyles.textStyleSize16W700Primary(context)
                : AppStyles.textStyleSize14W700Primary(context),
          ),
          if (primary == false)
            TextSpan(
              text: ')',
              style: primary
                  ? AppStyles.textStyleSize16W100Primary(context)
                  : AppStyles.textStyleSize14W100Primary(context),
            ),
        ],
      ),
    );
  }
}
