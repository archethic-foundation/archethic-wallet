import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LineType { header, current, beforeCurrent, afterCurrent }

class AirdropPersonalStepData {
  AirdropPersonalStepData({
    required this.actualValue,
    required this.numberOfLP,
    required this.multiplier,
  });
  final int actualValue;
  final int numberOfLP;
  final String multiplier;
}

class AirdropPersonalStepTab extends ConsumerWidget {
  const AirdropPersonalStepTab({
    this.displayNoteMultiplier = true,
    super.key,
  });

  final bool displayNoteMultiplier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = _generateAirdropStepData();
    final airdropForm = ref.watch(airdropFormNotifierProvider);
    final localizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF4C2470).withValues(alpha: 0.8),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
              },
              children: [
                _buildTableHeader(context, localizations),
                for (final row in data)
                  _buildTableRow(context, row, airdropForm),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<AirdropPersonalStepData> _generateAirdropStepData() {
    return [
      AirdropPersonalStepData(actualValue: 0, numberOfLP: 0, multiplier: '0x'),
      AirdropPersonalStepData(actualValue: 1, numberOfLP: 1, multiplier: '1x'),
      AirdropPersonalStepData(actualValue: 2, numberOfLP: 5, multiplier: '2x'),
      AirdropPersonalStepData(actualValue: 3, numberOfLP: 20, multiplier: '3x'),
      AirdropPersonalStepData(actualValue: 4, numberOfLP: 60, multiplier: '5x'),
      AirdropPersonalStepData(
        actualValue: 5,
        numberOfLP: 150,
        multiplier: '8x',
      ),
      AirdropPersonalStepData(
        actualValue: 6,
        numberOfLP: 300,
        multiplier: '13x',
      ),
      AirdropPersonalStepData(
        actualValue: 7,
        numberOfLP: 500,
        multiplier: '21x',
      ),
      AirdropPersonalStepData(
        actualValue: 8,
        numberOfLP: 750,
        multiplier: '34x',
      ),
      AirdropPersonalStepData(
        actualValue: 9,
        numberOfLP: 1000,
        multiplier: '55x',
      ),
    ];
  }

  TableRow _buildTableHeader(
    BuildContext context,
    AppLocalizations localizations,
  ) {
    return TableRow(
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(color: Color(0xFF4C2470)),
          left: BorderSide(color: Color(0xFF4C2470)),
          right: BorderSide(color: Color(0xFF4C2470)),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      children: [
        _buildTableCell(
          context,
          localizations.airdropPersonalMultiplierTableHeaderLPLocked,
          LineType.header,
          true,
        ),
        _buildTableCell(
          context,
          localizations.airdropPersonalMultiplierTableHeaderPersonalMultiplier,
          LineType.header,
          false,
        ),
      ],
    );
  }

  TableRow _buildTableRow(
    BuildContext context,
    AirdropPersonalStepData row,
    AirdropFormState airdropForm,
  ) {
    final isCurrentRow = '${airdropForm.personalMultiplier}x' == row.multiplier;
    final isBeforeCurrent = airdropForm.personalMultiplier >
        int.parse(row.multiplier.replaceAll('x', ''));

    final backgroundColor = isCurrentRow
        ? aedappfm.ArchethicThemeBase.raspberry500.withValues(alpha: 0.5)
        : row.actualValue.isEven
            ? aedappfm.ArchethicThemeBase.palePurpleBackground
            : Colors.transparent;

    return TableRow(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      children: [
        _buildTableCell(
          context,
          '${row.numberOfLP} LP ',
          isCurrentRow
              ? LineType.current
              : isBeforeCurrent
                  ? LineType.beforeCurrent
                  : LineType.afterCurrent,
          true,
          textSmallOpacity: _lpIndollarsCalculation(
            airdropForm.actualLPFiatValue,
            row.numberOfLP,
          ),
        ),
        _buildTableCell(
          context,
          row.multiplier,
          isCurrentRow
              ? LineType.current
              : isBeforeCurrent
                  ? LineType.beforeCurrent
                  : LineType.afterCurrent,
          false,
        ),
      ],
    );
  }

  Widget _buildTableCell(
    BuildContext context,
    String text,
    LineType lineType,
    bool alignStart, {
    String? textSmallOpacity,
  }) {
    final textStyle = _getTextStyle(context, lineType);

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
      child: Row(
        mainAxisAlignment:
            alignStart ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: textStyle,
          ),
          if (lineType == LineType.afterCurrent && !alignStart)
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Icon(
                Icons.lock_outline,
                size: 12,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
          if (textSmallOpacity != null)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                textSmallOpacity,
                style: textStyle.copyWith(
                  color: textStyle.color?.withValues(
                    alpha: lineType == LineType.afterCurrent ||
                            lineType == LineType.current
                        ? 0.6
                        : 0.2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  TextStyle _getTextStyle(BuildContext context, LineType lineType) {
    final baseStyle = Theme.of(context).textTheme.bodySmall!;
    switch (lineType) {
      case LineType.header:
        return baseStyle.copyWith(fontWeight: FontWeight.bold);
      case LineType.current:
      case LineType.afterCurrent:
        return baseStyle;
      case LineType.beforeCurrent:
        return baseStyle.copyWith(
          color: baseStyle.color?.withValues(alpha: 0.2),
        );
    }
  }

  String _lpIndollarsCalculation(double lpValue, int amount) {
    return '(≃\$${(Decimal.parse(amount.toString()) * Decimal.parse(lpValue.toString())).toDouble().toStringAsFixed(2)})';
  }
}
