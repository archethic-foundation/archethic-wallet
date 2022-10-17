/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/currency.dart';
import 'package:aewallet/application/primary_currency.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';

class BalanceIndicatorWidget extends ConsumerWidget {
  const BalanceIndicatorWidget({
    super.key,
    this.displaySwitchButton = true,
  });

  final bool displaySwitchButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);

    return preferences.showBalances
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (primaryCurrency.primaryCurrency ==
                  AvailablePrimaryCurrencyEnum.native)
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
              if (displaySwitchButton == true)
                // TODO(Chralu): Works only twice
                IconButton(
                  icon: const Icon(Icons.change_circle),
                  alignment: Alignment.centerRight,
                  color: theme.textFieldIcon,
                  onPressed: () async {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          preferences.activeVibrations,
                        );
                    if (primaryCurrency.primaryCurrency ==
                        AvailablePrimaryCurrencyEnum.native) {
                      await ref.read(
                        PrimaryCurrencyProviders.selectPrimaryCurrency(
                          primaryCurrency: const AvailablePrimaryCurrency(
                            AvailablePrimaryCurrencyEnum.fiat,
                          ),
                        ).future,
                      );
                    } else {
                      await ref.read(
                        PrimaryCurrencyProviders.selectPrimaryCurrency(
                          primaryCurrency: const AvailablePrimaryCurrency(
                            AvailablePrimaryCurrencyEnum.native,
                          ),
                        ).future,
                      );
                    }
                  },
                ),
            ],
          )
        : const SizedBox();
  }
}

class _BalanceIndicatorFiat extends ConsumerWidget {
  const _BalanceIndicatorFiat({required this.primary});

  final bool primary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSelectedBalance = StateContainer.of(context)
        .appWallet!
        .appKeychain!
        .getAccountSelected()!
        .balance;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final currency = ref.watch(CurrencyProviders.selectedCurrency);
    return RichText(
      text: TextSpan(
        text: '',
        children: <InlineSpan>[
          if (primary == false)
            TextSpan(
              text: '(',
              style: primary
                  ? theme.textStyleSize16W100Primary
                  : theme.textStyleSize14W100Primary,
            ),
          TextSpan(
            text: CurrencyUtil.getConvertedAmount(
              currency.currency.name,
              accountSelectedBalance!.fiatCurrencyValue!,
            ),
            style: primary
                ? theme.textStyleSize16W700Primary
                : theme.textStyleSize14W700Primary,
          ),
          if (primary == false)
            TextSpan(
              text: ')',
              style: primary
                  ? theme.textStyleSize16W100Primary
                  : theme.textStyleSize14W100Primary,
            ),
        ],
      ),
    );
  }
}

class _BalanceIndicatorNative extends ConsumerWidget {
  const _BalanceIndicatorNative({required this.primary});

  final bool primary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSelectedBalance = StateContainer.of(context)
        .appWallet!
        .appKeychain!
        .getAccountSelected()!
        .balance;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return RichText(
      text: TextSpan(
        text: '',
        children: <InlineSpan>[
          if (primary == false)
            TextSpan(
              text: '(',
              style: primary
                  ? theme.textStyleSize16W100Primary
                  : theme.textStyleSize14W100Primary,
            ),
          TextSpan(
            text:
                '${accountSelectedBalance!.nativeTokenValueToString()} ${accountSelectedBalance.nativeTokenName!}',
            style: primary
                ? theme.textStyleSize16W700Primary
                : theme.textStyleSize14W700Primary,
          ),
          if (primary == false)
            TextSpan(
              text: ')',
              style: primary
                  ? theme.textStyleSize16W100Primary
                  : theme.textStyleSize14W100Primary,
            ),
        ],
      ),
    );
  }
}
