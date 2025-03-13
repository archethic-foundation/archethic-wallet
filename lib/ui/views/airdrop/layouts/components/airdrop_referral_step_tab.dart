import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LineType { header, current, beforeCurrent, afterCurrent }

class AirdropReferralStepData {
  AirdropReferralStepData({
    required this.actualValue,
    required this.numberOfLP,
  });
  final int actualValue;
  final int numberOfLP;
}

class AirdropReferralStepTab extends ConsumerWidget {
  const AirdropReferralStepTab({
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
                for (var i = 0; i < data.length; i++)
                  _buildTableRow(context, data[i], airdropForm, i),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<AirdropReferralStepData> _generateAirdropStepData() {
    return [
      AirdropReferralStepData(actualValue: 0, numberOfLP: 0),
      AirdropReferralStepData(actualValue: 1, numberOfLP: 1),
      AirdropReferralStepData(actualValue: 2, numberOfLP: 5),
      AirdropReferralStepData(actualValue: 3, numberOfLP: 20),
      AirdropReferralStepData(actualValue: 5, numberOfLP: 60),
      AirdropReferralStepData(
        actualValue: 10,
        numberOfLP: 150,
      ),
      AirdropReferralStepData(
        actualValue: 20,
        numberOfLP: 300,
      ),
      AirdropReferralStepData(
        actualValue: 40,
        numberOfLP: 500,
      ),
      AirdropReferralStepData(
        actualValue: 100,
        numberOfLP: 750,
      ),
      AirdropReferralStepData(
        actualValue: 1000,
        numberOfLP: 1000,
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
      ),
      children: [
        _buildTableCell(
          context,
          localizations.airdropReferralMultiplierTableHeaderLPLocked,
          LineType.header,
          true,
        ),
        _buildTableCell(
          context,
          localizations.airdropReferralMultiplierTableHeaderMaxReferral,
          LineType.header,
          false,
        ),
      ],
    );
  }

  TableRow _buildTableRow(
    BuildContext context,
    AirdropReferralStepData row,
    AirdropFormState airdropForm,
    int index, // Ajoutez l'index de la ligne
  ) {
    final isCurrentRow =
        airdropForm.referralParticipantRewarded == row.actualValue;
    final isBeforeCurrent =
        airdropForm.referralParticipantRewarded > row.actualValue;

    // Utilisez l'index pour alterner la couleur de fond
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
          row.actualValue.toString(),
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
                color: Colors.white.withValues(alpha: 0.8),
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
                        ? 0.8
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
