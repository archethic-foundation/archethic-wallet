import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme_base.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LineType { header, current, beforeCurrent, afterCurrent }

class AirdropStepTab extends ConsumerWidget {
  const AirdropStepTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = <Map<String, dynamic>>[
      {'Step': 1, 'LP Required': '1', 'Multiplier': '1x'},
      {'Step': 2, 'LP Required': '5', 'Multiplier': '2x'},
      {'Step': 3, 'LP Required': '20', 'Multiplier': '3x'},
      {'Step': 4, 'LP Required': '60', 'Multiplier': '5x'},
      {'Step': 5, 'LP Required': '150', 'Multiplier': '8x'},
      {'Step': 6, 'LP Required': '300', 'Multiplier': '13x'},
      {'Step': 7, 'LP Required': '500', 'Multiplier': '21x'},
      {'Step': 8, 'LP Required': '750', 'Multiplier': '34x'},
      {'Step': 9, 'LP Required': '1000', 'Multiplier': '55x'},
    ];
    final localizations = AppLocalizations.of(context)!;
    final airdropForm = ref.watch(airdropFormNotifierProvider);
    return Column(
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Note:',
                style: AppTextStyles.bodyMedium(context)
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: ' ${localizations.airdropStepsNoteDesc}',
                style: AppTextStyles.bodyMedium(context),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 50),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: ArchethicThemeBase.palePurpleBackground,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2),
                },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    children: [
                      tableCell(context, 'Step', LineType.header),
                      tableCell(
                        context,
                        'LP Required (aeETH/UCO)',
                        LineType.header,
                      ),
                      tableCell(context, 'Multiplier', LineType.header),
                    ],
                  ),
                  for (final row in data)
                    '${airdropForm.personalMultiplier}x' == row['Multiplier']
                        ? TableRow(
                            decoration: BoxDecoration(
                              color: ArchethicThemeBase.raspberry500
                                  .withOpacity(0.5),
                            ),
                            children: [
                              tableCell(
                                context,
                                row['Step'].toString(),
                                LineType.current,
                              ),
                              tableCell(
                                context,
                                row['LP Required'],
                                LineType.current,
                              ),
                              tableCell(
                                context,
                                row['Multiplier'],
                                LineType.current,
                              ),
                            ],
                          )
                        : airdropForm.personalMultiplier <
                                int.parse(
                                  row['Multiplier']
                                      .toString()
                                      .replaceAll('x', ''),
                                )
                            ? TableRow(
                                decoration: BoxDecoration(
                                  color: row['Step'] % 2 == 0
                                      ? ArchethicThemeBase.palePurpleBackground
                                      : Colors.transparent,
                                ),
                                children: [
                                  tableCell(
                                    context,
                                    row['Step'].toString(),
                                    LineType.beforeCurrent,
                                  ),
                                  tableCell(
                                    context,
                                    row['LP Required'],
                                    LineType.beforeCurrent,
                                  ),
                                  tableCell(
                                    context,
                                    row['Multiplier'],
                                    LineType.beforeCurrent,
                                  ),
                                ],
                              )
                            : TableRow(
                                decoration: BoxDecoration(
                                  color: row['Step'] % 2 == 0
                                      ? ArchethicThemeBase.palePurpleBackground
                                      : Colors.transparent,
                                ),
                                children: [
                                  tableCell(
                                    context,
                                    row['Step'].toString(),
                                    LineType.afterCurrent,
                                  ),
                                  tableCell(
                                    context,
                                    row['LP Required'],
                                    LineType.afterCurrent,
                                  ),
                                  tableCell(
                                    context,
                                    row['Multiplier'],
                                    LineType.afterCurrent,
                                  ),
                                ],
                              ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget tableCell(BuildContext context, String text, LineType lineType) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8, right: 8),
      child: Text(
        lineType == LineType.header ? text : '  $text',
        style: lineType == LineType.header
            ? AppTextStyles.bodySmall(context)
                .copyWith(fontWeight: FontWeight.bold)
            : lineType == LineType.beforeCurrent
                ? AppTextStyles.bodySmall(context)
                : lineType == LineType.afterCurrent
                    ? AppTextStyles.bodySmall(context).copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .color
                            ?.withOpacity(0.5),
                      )
                    : AppTextStyles.bodySmall(context)
                        .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
