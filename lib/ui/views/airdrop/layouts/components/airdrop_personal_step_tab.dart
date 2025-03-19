import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LineType { header, current, beforeCurrent, afterCurrent }

class AirdropPersonalStepTab extends ConsumerWidget {
  const AirdropPersonalStepTab({
    this.displayNoteMultiplier = true,
    super.key,
  });

  final bool displayNoteMultiplier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                for (var i = 0; i < airdropPersonalStepDataList.length; i++)
                  _buildTableRow(
                    context,
                    airdropPersonalStepDataList[i],
                    airdropForm,
                    i,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
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
    int index,
  ) {
    final personalMultiplier = airdropForm.personalMultiplier;
    final isCurrentRow = '${personalMultiplier}x' == row.personalMultiplier;
    final isBeforeCurrent = personalMultiplier >
        int.parse(row.personalMultiplier.replaceAll('x', ''));

    final backgroundColor = isCurrentRow
        ? aedappfm.ArchethicThemeBase.raspberry500.withValues(alpha: 0.5)
        : index.isEven
            ? aedappfm.ArchethicThemeBase.palePurpleBackground
            : Colors.transparent;

    return TableRow(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      children: [
        _buildTableCell(
          context,
          '${row.lpTokensLocked} LP ',
          isCurrentRow
              ? LineType.current
              : isBeforeCurrent
                  ? LineType.beforeCurrent
                  : LineType.afterCurrent,
          true,
          textSmallOpacity: _lpIndollarsCalculation(
            airdropForm.actualLPFiatValue,
            row.lpTokensLocked,
          ),
        ),
        _buildTableCell(
          context,
          row.personalMultiplier,
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
            Text(
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
