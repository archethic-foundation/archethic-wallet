import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LineType { header, current, beforeCurrent, afterCurrent }

class AirdropStepData {
  AirdropStepData({
    required this.actualValue,
    required this.numberOfLP,
    required this.multiplier,
  });
  final int actualValue;
  final String numberOfLP;
  final String multiplier;
}

class AirdropStepTab extends ConsumerWidget {
  const AirdropStepTab({
    this.displayNoteMultiplier = true,
    super.key,
  });

  final bool displayNoteMultiplier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = <AirdropStepData>[
      AirdropStepData(actualValue: 0, numberOfLP: '0', multiplier: '0x'),
      AirdropStepData(actualValue: 1, numberOfLP: '1', multiplier: '1x'),
      AirdropStepData(actualValue: 2, numberOfLP: '5', multiplier: '2x'),
      AirdropStepData(actualValue: 3, numberOfLP: '20', multiplier: '3x'),
      AirdropStepData(actualValue: 4, numberOfLP: '60', multiplier: '5x'),
      AirdropStepData(actualValue: 5, numberOfLP: '150', multiplier: '8x'),
      AirdropStepData(actualValue: 6, numberOfLP: '300', multiplier: '13x'),
      AirdropStepData(actualValue: 7, numberOfLP: '500', multiplier: '21x'),
      AirdropStepData(actualValue: 8, numberOfLP: '750', multiplier: '34x'),
      AirdropStepData(actualValue: 9, numberOfLP: '1000', multiplier: '55x'),
    ];
    final airdropForm = ref.watch(airdropFormNotifierProvider);
    final localizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: aedappfm.ArchethicThemeBase.palePurpleBackground,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
              },
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  children: [
                    tableCell(
                      context,
                      localizations.airdropStepDataLPDepositHeader,
                      LineType.header,
                    ),
                    tableCell(
                      context,
                      localizations.airdropStepDataMultiplierHeader,
                      LineType.header,
                      asterisque: displayNoteMultiplier,
                    ),
                    tableCell(
                      context,
                      localizations.airdropStepDataActualValueHeader,
                      LineType.header,
                    ),
                  ],
                ),
                for (final row in data)
                  '${airdropForm.personalMultiplier}x' == row.multiplier
                      ? TableRow(
                          decoration: BoxDecoration(
                            color: aedappfm.ArchethicThemeBase.raspberry500
                                .withOpacity(0.5),
                          ),
                          children: [
                            tableCell(
                              context,
                              row.numberOfLP,
                              LineType.current,
                            ),
                            tableCell(
                              context,
                              row.multiplier,
                              LineType.current,
                            ),
                            tableCell(
                              context,
                              '\$${(row.actualValue * airdropForm.actualLPFiatValue).formatNumber(precision: 2)}',
                              LineType.current,
                            ),
                          ],
                        )
                      : airdropForm.personalMultiplier <
                              int.parse(
                                row.multiplier.replaceAll('x', ''),
                              )
                          ? TableRow(
                              decoration: BoxDecoration(
                                color: row.actualValue.isEven
                                    ? aedappfm
                                        .ArchethicThemeBase.palePurpleBackground
                                    : Colors.transparent,
                              ),
                              children: [
                                tableCell(
                                  context,
                                  row.numberOfLP,
                                  LineType.beforeCurrent,
                                ),
                                tableCell(
                                  context,
                                  row.multiplier,
                                  LineType.beforeCurrent,
                                ),
                                tableCell(
                                  context,
                                  '\$${(row.actualValue * airdropForm.actualLPFiatValue).formatNumber(precision: 2)}',
                                  LineType.beforeCurrent,
                                ),
                              ],
                            )
                          : TableRow(
                              decoration: BoxDecoration(
                                color: row.actualValue.isEven
                                    ? aedappfm
                                        .ArchethicThemeBase.palePurpleBackground
                                    : Colors.transparent,
                              ),
                              children: [
                                tableCell(
                                  context,
                                  row.numberOfLP,
                                  LineType.afterCurrent,
                                ),
                                tableCell(
                                  context,
                                  row.multiplier,
                                  LineType.afterCurrent,
                                ),
                                tableCell(
                                  context,
                                  '\$${(row.actualValue * airdropForm.actualLPFiatValue).formatNumber(precision: 2)}',
                                  LineType.afterCurrent,
                                ),
                              ],
                            ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget tableCell(
    BuildContext context,
    String text,
    LineType lineType, {
    bool asterisque = false,
  }) {
    return Padding(
      padding: lineType == LineType.header
          ? const EdgeInsets.only(top: 8, bottom: 8)
          : const EdgeInsets.only(top: 8, bottom: 8, right: 30),
      child: asterisque
          ? Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: text,
                    style: AppTextStyles.bodySmall(context)
                        .copyWith(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: ' *',
                        style: AppTextStyles.bodySmall(context).copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          textBaseline: TextBaseline.alphabetic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Text(
              text,
              textAlign: lineType == LineType.header
                  ? TextAlign.center
                  : TextAlign.end,
              style: lineType == LineType.header
                  ? AppTextStyles.bodySmall(context)
                      .copyWith(fontWeight: FontWeight.bold)
                  : lineType == LineType.beforeCurrent ||
                          lineType == LineType.current
                      ? AppTextStyles.bodySmall(context)
                      : AppTextStyles.bodySmall(context).copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .color
                              ?.withOpacity(0.5),
                        ),
            ),
    );
  }
}
