/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/application/price_history/providers.dart';
import 'package:aewallet/application/settings/primary_currency.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/domain/models/market_price_history.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/sheets/chart_sheet.dart';
import 'package:aewallet/ui/widgets/balance/components/balance_infos_popup.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/history_chart.dart';
import 'package:aewallet/ui/widgets/components/icon_widget.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

part 'components/balance_infos_build_chart.dart';
part 'components/balance_infos_build_kpi.dart';

class BalanceInfos extends ConsumerWidget {
  const BalanceInfos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final accountSelectedBalance = ref.watch(
      AccountProviders.selectedAccount
          .select((value) => value.valueOrNull?.balance),
    );
    final settings = ref.watch(SettingsProviders.settings);
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);

    if (accountSelectedBalance == null) return const SizedBox();

    return GestureDetector(
      child: SizedBox(
        height: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Card(
            color: Colors.transparent,
            child: DecoratedBox(
              decoration: theme.getDecorationBalance(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: primaryCurrency.primaryCurrency ==
                          AvailablePrimaryCurrencyEnum.native
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: AutoSizeText(
                                AccountBalance.cryptoCurrencyLabel,
                                style: theme.textStyleSize35W900EquinoxPrimary,
                              ),
                            ),
                            if (settings.showBalances)
                              _BalanceInfosNativeShowed(
                                accountSelectedBalance: accountSelectedBalance,
                              )
                            else
                              const _BalanceInfosNotShowed()
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: AutoSizeText(
                                settings.currency.name,
                                style: theme.textStyleSize35W900EquinoxPrimary,
                              ),
                            ),
                            if (settings.showBalances)
                              _BalanceInfosFiatShowed(
                                accountSelectedBalance: accountSelectedBalance,
                              )
                            else
                              const _BalanceInfosNotShowed()
                          ],
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
      onTapDown: (details) {
        BalanceInfosPopup.getPopup(
          context,
          ref,
          details,
          accountSelectedBalance,
        );
      },
    );
  }
}

class _BalanceInfosNativeShowed extends ConsumerWidget {
  const _BalanceInfosNativeShowed({
    required this.accountSelectedBalance,
  });
  final AccountBalance accountSelectedBalance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final currency = ref.watch(
      SettingsProviders.settings.select((settings) => settings.currency),
    );
    final fiatValue = ref
        .watch(
          MarketPriceProviders.convertedToSelectedCurrency(
            nativeAmount: accountSelectedBalance.nativeTokenValue,
          ),
        )
        .valueOrNull;
    if (fiatValue == null) {
      return const SizedBox();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AutoSizeText(
          accountSelectedBalance.nativeTokenValueToString(),
          style: theme.textStyleSize25W900EquinoxPrimary,
        ),
        AutoSizeText(
          CurrencyUtil.format(
            currency.name,
            fiatValue,
          ),
          textAlign: TextAlign.center,
          style: theme.textStyleSize12W600Primary,
        ),
      ],
    );
  }
}

class _BalanceInfosFiatShowed extends ConsumerWidget {
  const _BalanceInfosFiatShowed({
    required this.accountSelectedBalance,
  });
  final AccountBalance accountSelectedBalance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final currency = ref.watch(
      SettingsProviders.settings.select((settings) => settings.currency),
    );
    final fiatValue = ref
        .watch(
          MarketPriceProviders.convertedToSelectedCurrency(
            nativeAmount: accountSelectedBalance.nativeTokenValue,
          ),
        )
        .valueOrNull;
    if (fiatValue == null) {
      return const SizedBox();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AutoSizeText(
          CurrencyUtil.format(
            currency.name,
            fiatValue,
          ),
          textAlign: TextAlign.center,
          style: theme.textStyleSize25W900EquinoxPrimary,
        ),
        AutoSizeText(
          '${accountSelectedBalance.nativeTokenValueToString()} ${accountSelectedBalance.nativeTokenName}',
          style: theme.textStyleSize12W600Primary,
        ),
      ],
    );
  }
}

class _BalanceInfosNotShowed extends ConsumerWidget {
  const _BalanceInfosNotShowed();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AutoSizeText(
          '···········',
          style: theme.textStyleSize25W900EquinoxPrimary60,
        ),
        AutoSizeText(
          '···········',
          textAlign: TextAlign.center,
          style: theme.textStyleSize12W600Primary60,
        ),
      ],
    );
  }
}
