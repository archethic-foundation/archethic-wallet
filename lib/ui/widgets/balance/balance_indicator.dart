/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/application/settings/primary_currency.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
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
    final preferences = ref.watch(SettingsProviders.settings);
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);

    return preferences.showBalances
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (primaryCurrency.primaryCurrency ==
                  AvailablePrimaryCurrencyEnum.native)
                const Column(
                  children: [
                    _BalanceIndicatorNative(
                      primary: true,
                    ),
                    _BalanceIndicatorFiat(
                      primary: false,
                    ),
                  ],
                )
              else
                const Column(
                  children: [
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
              if (displaySwitchButton == true) const _BalanceIndicatorButton(),
            ],
          )
        : const SizedBox();
  }
}

class _BalanceIndicatorButton extends ConsumerWidget {
  const _BalanceIndicatorButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);
    return IconButton(
      icon: primaryCurrency.primaryCurrency == AvailablePrimaryCurrencyEnum.fiat
          ? const Icon(UiIcons.primary_currency)
          : const Icon(UiIcons.primary_currency_uco),
      alignment: Alignment.centerRight,
      color: theme.textFieldIcon,
      onPressed: () async {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              preferences.activeVibrations,
            );
        await ref
            .read(SettingsProviders.settings.notifier)
            .switchSelectedPrimaryCurrency();
      },
    );
  }
}

class _BalanceIndicatorFiat extends ConsumerWidget {
  const _BalanceIndicatorFiat({required this.primary});

  final bool primary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSelectedBalance = ref.watch(
      AccountProviders.selectedAccount
          .select((value) => value.valueOrNull?.balance),
    );
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final currency = ref.watch(
      SettingsProviders.settings.select((settings) => settings.currency),
    );

    if (accountSelectedBalance == null) return const SizedBox();

    final fiatValue = ref
        .watch(
          MarketPriceProviders.convertedToSelectedCurrency(
            nativeAmount: accountSelectedBalance.nativeTokenValue,
          ),
        )
        .valueOrNull;
    if (fiatValue == null) return const SizedBox();

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
            text: CurrencyUtil.format(
              currency.name,
              fiatValue,
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
    final accountSelectedBalance = ref.watch(
      AccountProviders.selectedAccount
          .select((value) => value.valueOrNull?.balance),
    );

    final theme = ref.watch(ThemeProviders.selectedTheme);

    if (accountSelectedBalance == null) return const SizedBox();
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
                '${accountSelectedBalance.nativeTokenValueToString()} ${accountSelectedBalance.nativeTokenName}',
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
