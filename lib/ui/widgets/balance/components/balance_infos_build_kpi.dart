/// SPDX-License-Identifier: AGPL-3.0-or-later

part of '../balance_infos.dart';

class BalanceInfosKpi extends ConsumerWidget {
  const BalanceInfosKpi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final chartInfos = StateContainer.of(context).chartInfos;
    final accountSelectedBalance = ref.watch(
      AccountProviders.selectedAccount.select(
        (value) => value.valueOrNull?.balance,
      ),
    );

    final preferences = ref.watch(SettingsProviders.settings);

// TODO(Chralu): Token Price is null before pull-to-refresh
    if (accountSelectedBalance == null ||
        accountSelectedBalance.nativeTokenName == null ||
        accountSelectedBalance.tokenPrice?.amount == null) {
      return const SizedBox();
    }

    if (chartInfos?.data == null) {
      return const SizedBox(
        height: 30,
      );
    }

    return FadeIn(
      duration: const Duration(milliseconds: 1000),
      child: Container(
        height: 30,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 5),
          child: Row(
            children: <Widget>[
              AutoSizeText(
                '1 ${accountSelectedBalance.nativeTokenName!} = ${CurrencyUtil.getAmountPlusSymbol(accountSelectedBalance.fiatCurrencyCode!, accountSelectedBalance.tokenPrice!.amount!)}',
                style: theme.textStyleSize12W100Primary,
              ),
              const SizedBox(
                width: 10,
              ),
              AutoSizeText(
                '${chartInfos!.getPriceChangePercentage(StateContainer.of(context).idChartOption!)!.toStringAsFixed(2)}%',
                style: StateContainer.of(context)
                            .chartInfos!
                            .getPriceChangePercentage(
                              StateContainer.of(context).idChartOption!,
                            )! >=
                        0
                    ? theme.textStyleSize12W100PositiveValue
                    : theme.textStyleSize12W100NegativeValue,
              ),
              const SizedBox(width: 5),
              if (chartInfos.getPriceChangePercentage(
                    StateContainer.of(context).idChartOption!,
                  )! >=
                  0)
                FaIcon(
                  FontAwesomeIcons.caretUp,
                  color: theme.positiveValue,
                )
              else
                FaIcon(
                  FontAwesomeIcons.caretDown,
                  color: theme.negativeValue,
                ),
              const SizedBox(
                width: 10,
              ),
              AutoSizeText(
                ChartInfos.getChartOptionLabel(
                  context,
                  StateContainer.of(context).idChartOption!,
                ),
                style: theme.textStyleSize12W100Primary,
              ),
              const SizedBox(
                width: 10,
              ),
              if (accountSelectedBalance.tokenPrice!.useOracleUcoPrice!)
                InkWell(
                  onTap: () {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          preferences.activeVibrations,
                        );
                    AppDialogs.showInfoDialog(
                      context,
                      ref,
                      localizations.informations,
                      localizations.currencyOracleInfo,
                    );
                  },
                  child: const IconWidget(
                    icon: 'assets/icons/menu/oracle.svg',
                    width: 15,
                    height: 15,
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
