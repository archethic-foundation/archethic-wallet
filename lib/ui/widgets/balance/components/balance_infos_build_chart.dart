/// SPDX-License-Identifier: AGPL-3.0-or-later

part of '../balance_infos.dart';

class BalanceInfosChart extends ConsumerWidget {
  const BalanceInfosChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

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
        context.go(ChartSheet.routerPage);
      },
      child: Ink(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.08,
          child: Stack(
            children: <Widget>[
              FadeIn(
                duration: const Duration(milliseconds: 1000),
                child: chartInfos != null
                    ? HistoryChart(
                        intervals: chartInfos,
                        gradientColors: LinearGradient(
                          colors: <Color>[
                            ArchethicTheme.text20,
                            ArchethicTheme.text,
                          ],
                        ),
                        gradientColorsBar: LinearGradient(
                          colors: <Color>[
                            ArchethicTheme.text.withOpacity(0.9),
                            ArchethicTheme.text.withOpacity(0),
                          ],
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                        ),
                        tooltipBg: ArchethicTheme.backgroundDark,
                        tooltipText:
                            ArchethicThemeStyles.textStyleSize12W100Primary,
                        axisTextStyle:
                            ArchethicThemeStyles.textStyleSize12W100Primary,
                        optionChartSelected: settings.priceChartIntervalOption,
                        currency: settings.currency.name,
                        completeChart: false,
                      )
                    : const SizedBox(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localizations.priceChartHeader,
                    style: ArchethicThemeStyles.textStyleSize14W600Primary,
                  ),
                  const IconDataWidget(
                    icon: Symbols.show_chart,
                    width: AppFontSizes.size20,
                    height: AppFontSizes.size20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
