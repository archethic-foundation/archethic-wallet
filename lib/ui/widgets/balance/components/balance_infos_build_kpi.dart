/// SPDX-License-Identifier: AGPL-3.0-or-later

part of '../balance_infos.dart';

class BalanceInfosBuildKpi extends StatelessWidget {
  const BalanceInfosBuildKpi({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = StateContainer.of(context).curTheme;
    final chartInfos = StateContainer.of(context).chartInfos;
    final accountSelectedBalance = StateContainer.of(context)
        .appWallet!
        .appKeychain!
        .getAccountSelected()!
        .balance;

    if (chartInfos != null && chartInfos.data != null) {
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
                  '1 ${accountSelectedBalance!.nativeTokenName!} = ${CurrencyUtil.getAmountPlusSymbol(accountSelectedBalance.fiatCurrencyCode!, accountSelectedBalance.tokenPrice!.amount!)}',
                  style: AppStyles.textStyleSize12W100Primary(context),
                ),
                const SizedBox(
                  width: 10,
                ),
                AutoSizeText(
                  '${chartInfos.getPriceChangePercentage(StateContainer.of(context).idChartOption!)!.toStringAsFixed(2)}%',
                  style: StateContainer.of(context)
                              .chartInfos!
                              .getPriceChangePercentage(
                                StateContainer.of(context).idChartOption!,
                              )! >=
                          0
                      ? AppStyles.textStyleSize12W100PositiveValue(context)
                      : AppStyles.textStyleSize12W100NegativeValue(context),
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
                  style: AppStyles.textStyleSize12W100Primary(context),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (accountSelectedBalance.tokenPrice!.useOracleUcoPrice!)
                  InkWell(
                    onTap: () {
                      sl.get<HapticUtil>().feedback(
                            FeedbackType.light,
                            StateContainer.of(context).activeVibrations,
                          );
                      AppDialogs.showInfoDialog(
                        context,
                        localizations.informations,
                        localizations.currencyOracleInfo,
                      );
                    },
                    child: IconWidget.build(
                      context,
                      'assets/icons/oracle.png',
                      15,
                      15,
                    ),
                  )
                else
                  const SizedBox(),
              ],
            ),
          ),
        ),
      );
    } else {
      return const SizedBox(
        height: 30,
      );
    }
  }
}
