/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/price_history/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/market_price_history.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class TokenDetailChartInterval extends ConsumerWidget {
  const TokenDetailChartInterval({
    super.key,
    this.chartInfos,
  });

  final List<PriceHistoryValue>? chartInfos;

  static const List<MarketPriceHistoryInterval> _chartIntervalOptions = [
    MarketPriceHistoryInterval.hour,
    MarketPriceHistoryInterval.day,
    MarketPriceHistoryInterval.week,
    MarketPriceHistoryInterval.twoWeeks,
    MarketPriceHistoryInterval.month,
    MarketPriceHistoryInterval.twoMonths,
    MarketPriceHistoryInterval.year,
    MarketPriceHistoryInterval.all,
  ];

  int _intervalOptionIndex(MarketPriceHistoryInterval interval) =>
      _chartIntervalOptions.indexWhere((element) => element == interval);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedInterval = ref.watch(PriceHistoryProviders.scaleOption);

    if (chartInfos == null) {
      return const SizedBox.shrink();
    }

    return Wrap(
      children: [
        BottomBar(
          selectedIndex: _intervalOptionIndex(selectedInterval),
          curve: Curves.easeIn,
          duration: const Duration(milliseconds: 500),
          itemPadding: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(right: 10, left: 10),
          onTap: (int index) async {
            final settings = ref.read(SettingsProviders.settings);

            sl.get<HapticUtil>().feedback(
                  FeedbackType.light,
                  settings.activeVibrations,
                );
            await ref
                .read(SettingsProviders.settings.notifier)
                .setPriceChartInterval(_chartIntervalOptions[index]);
          },
          items: _chartIntervalOptions.map((optionChart) {
            return BottomBarItem(
              icon: Text(
                optionChart.getChartOptionLabel(context),
                style: ArchethicThemeStyles.textStyleSize12W100Primary,
              ),
              backgroundColorOpacity:
                  ArchethicTheme.bottomBarBackgroundColorOpacity,
              activeIconColor: ArchethicTheme.bottomBarActiveIconColor,
              activeTitleColor: ArchethicTheme.bottomBarActiveTitleColor,
              activeColor: ArchethicTheme.bottomBarActiveColor,
              inactiveColor: ArchethicTheme.bottomBarInactiveIcon,
            );
          }).toList(),
        ),
      ],
    );
  }
}
