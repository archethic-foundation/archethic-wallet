/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/application/settings/primary_currency.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:material_symbols_icons/symbols.dart';

class BalanceIndicatorWidget extends ConsumerWidget {
  const BalanceIndicatorWidget({
    super.key,
    this.displaySwitchButton = true,
    this.allDigits = true,
  });

  final bool displaySwitchButton;
  final bool allDigits;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);
    final localizations = AppLocalizations.of(context)!;

    return preferences.showBalances
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('${localizations.balance}: '),
                  if (displaySwitchButton == true)
                    const _BalanceIndicatorButton(),
                ],
              ),
              if (primaryCurrency.primaryCurrency ==
                  AvailablePrimaryCurrencyEnum.native)
                Row(
                  children: [
                    _BalanceIndicatorNative(
                      primary: true,
                      allDigits: allDigits,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: Text('/'),
                    ),
                    _BalanceIndicatorFiat(
                      primary: false,
                      allDigits: allDigits,
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    _BalanceIndicatorFiat(
                      primary: true,
                      allDigits: allDigits,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: Text('/'),
                    ),
                    _BalanceIndicatorNative(
                      primary: false,
                      allDigits: allDigits,
                    ),
                  ],
                ),
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
    return IconButton(
      icon: const Icon(Symbols.currency_exchange),
      color: theme.textFieldIcon,
      iconSize: 14,
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
  const _BalanceIndicatorFiat({
    required this.primary,
    this.allDigits = true,
  });

  final bool primary;
  final bool allDigits;

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

    return Text(
      NumberUtil.formatThousandsStr(
        CurrencyUtil.format(
          currency.name,
          fiatValue,
        ),
      ),
      style: theme.textStyleSize14W100Primary,
    );
  }
}

class _BalanceIndicatorNative extends ConsumerWidget {
  const _BalanceIndicatorNative({
    required this.primary,
    this.allDigits = true,
  });

  final bool primary;
  final bool allDigits;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSelectedBalance = ref.watch(
      AccountProviders.selectedAccount
          .select((value) => value.valueOrNull?.balance),
    );

    final theme = ref.watch(ThemeProviders.selectedTheme);

    if (accountSelectedBalance == null) return const SizedBox();

    if (allDigits == true) {
      return Text(
        '${NumberUtil.formatThousandsStr(
          accountSelectedBalance.nativeTokenValueToString(),
        )} ${accountSelectedBalance.nativeTokenName}',
        style: theme.textStyleSize14W100Primary,
      );
    } else {
      return Text(
        '${NumberUtil.formatThousandsStr(
          accountSelectedBalance.nativeTokenValueToString(digits: 2),
        )} ${accountSelectedBalance.nativeTokenName}',
        style: theme.textStyleSize14W100Primary,
      );
    }
  }
}
