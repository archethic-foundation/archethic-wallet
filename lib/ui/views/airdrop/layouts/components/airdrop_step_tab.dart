import 'package:aewallet/application/airdrop/airdrop_notifier.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final airdropAsync = ref.watch(airdropNotifierProvider);
    var personalMultiplier = 0;

    airdropAsync.when(
      data: (airdrop) {
        if (airdrop != null) {
          personalMultiplier = airdrop.personalMultiplier ?? 0;
        }
      },
      loading: () {},
      error: (error, stack) {},
    );

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
              borderRadius: BorderRadius.circular(20),
            ),
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
                    tableCell(context, 'Step', title: true),
                    tableCell(context, 'LP Required (aeETH/UCO)', title: true),
                    tableCell(context, 'Multiplier', title: true),
                  ],
                ),
                for (final row in data)
                  TableRow(
                    decoration: BoxDecoration(
                      color: '${personalMultiplier}x' == row['Multiplier']
                          ? ArchethicThemeBase.raspberry500.withOpacity(0.5)
                          : row['Step'] % 2 == 0
                              ? ArchethicThemeBase.palePurpleBackground
                              : Colors.transparent,
                    ),
                    children: [
                      tableCell(context, row['Step'].toString()),
                      tableCell(context, row['LP Required']),
                      tableCell(context, row['Multiplier']),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget tableCell(BuildContext context, String text, {bool title = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8, right: 8),
      child: Text(
        title ? text : '  $text',
        style: title
            ? AppTextStyles.bodySmall(context)
                .copyWith(fontWeight: FontWeight.bold)
            : AppTextStyles.bodySmallWithOpacity(context),
      ),
    );
  }
}
