import 'package:aewallet/domain/models/market_price_history.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class PriceEvolutionIndicator extends ConsumerWidget {
  const PriceEvolutionIndicator(this.chartInfos, {super.key});

  final List<PriceHistoryValue>? chartInfos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstPrice = chartInfos!.first.price.toDouble();
    final lastPrice = chartInfos!.last.price.toDouble();
    final priceEvolution =
        firstPrice > 0 ? ((lastPrice - firstPrice) / firstPrice) * 100 : 0;
    return Row(
      children: [
        AutoSizeText(
          '${priceEvolution.toStringAsFixed(2)}%',
          style: priceEvolution >= 0
              ? ArchethicThemeStyles.textStyleSize12W100PositiveValue
              : ArchethicThemeStyles.textStyleSize12W100NegativeValue,
        ),
        const SizedBox(width: 5),
        if (priceEvolution >= 0)
          Icon(
            Symbols.arrow_upward,
            color: ArchethicTheme.positiveValue,
            size: 14,
          )
        else
          Icon(
            Symbols.arrow_downward,
            color: ArchethicTheme.negativeValue,
            size: 14,
          ),
      ],
    );
  }
}
