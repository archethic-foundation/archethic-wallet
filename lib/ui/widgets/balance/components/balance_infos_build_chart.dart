/// SPDX-License-Identifier: AGPL-3.0-or-later

part of '../balance_infos.dart';

class BalanceInfosChart extends ConsumerWidget {
  const BalanceInfosChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final settings = ref.watch(SettingsProviders.settings);

    final chartInfos = ref
        .watch(
          PriceHistoryProviders.chartData(
            scaleOption: settings.priceChartIntervalOption,
          ),
        )
        .valueOrNull;

    return InkWell(
      onTap: () async {
        await sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              settings.activeVibrations,
            );

        Sheets.showAppHeightNineSheet(
          context: context,
          ref: ref,
          widget: const ChartSheet(),
        );
      },
      child: Ink(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.08,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      localizations.priceChartHeader,
                      style: theme.textStyleSize14W600EquinoxPrimary,
                    ),
                    const IconDataWidget(
                      icon: Icons.arrow_circle_right_outlined,
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
              ),
              FadeIn(
                duration: const Duration(milliseconds: 1000),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: chartInfos != null
                      ? HistoryChart(
                          intervals: chartInfos,
                          gradientColors: LinearGradient(
                            colors: <Color>[
                              theme.text20!,
                              theme.text!,
                            ],
                          ),
                          gradientColorsBar: LinearGradient(
                            colors: <Color>[
                              theme.text!.withOpacity(0.9),
                              theme.text!.withOpacity(0),
                            ],
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                          ),
                          tooltipBg: theme.backgroundDark!,
                          tooltipText: theme.textStyleSize12W100Primary,
                          axisTextStyle: theme.textStyleSize12W100Primary,
                          optionChartSelected:
                              settings.priceChartIntervalOption,
                          currency: settings.currency.name,
                          completeChart: false,
                        )
                      : const SizedBox(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
