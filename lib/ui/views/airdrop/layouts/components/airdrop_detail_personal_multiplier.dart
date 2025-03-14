import 'package:aewallet/ui/figma_components/buttons/btn_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_modal_personal_multiplier.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AirdropDetailPersonalMultiplier extends ConsumerWidget {
  const AirdropDetailPersonalMultiplier({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final airdropForm = ref.watch(airdropFormNotifierProvider);

    return Column(
      children: [
        Text(
          localizations.airdropDashboardDetailPersonalMultiplierTitle,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeightTelegraf.fontWeightSemibold,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          textAlign: TextAlign.center,
          localizations.airdropDashboardDetailPersonalMultiplierDesc,
          style: Theme.of(context).textTheme.bodyMediumWithOpacity,
        ),
        const SizedBox(
          height: 20,
        ),
        aedappfm.BlockInfo(
          width: MediaQuery.of(context).size.width,
          paddingEdgeInsetsClipRRect: EdgeInsets.zero,
          paddingEdgeInsetsInfo: const EdgeInsets.all(10),
          blockInfoColor: aedappfm.BlockInfoColor.neutral,
          info: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizations.airdropDashboardDetailPersonalMultiplierLPLocked,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    airdropForm.personalLP.formatNumber(precision: 2),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeightTelegraf.fontWeightBold,
                        ),
                  ),
                  Text(
                    _lpIndollarsCalculation(
                      airdropForm.actualLPFiatValue,
                      airdropForm.personalLP,
                    ),
                    style: Theme.of(context).textTheme.bodySmallWithOpacity,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        aedappfm.BlockInfo(
          width: MediaQuery.of(context).size.width,
          paddingEdgeInsetsClipRRect: EdgeInsets.zero,
          paddingEdgeInsetsInfo: const EdgeInsets.all(10),
          blockInfoColor: aedappfm.BlockInfoColor.neutral,
          info: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizations
                    .airdropDashboardDetailPersonalMultiplierLPUnlocked,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    airdropForm.personalLPFlexible.formatNumber(precision: 2),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeightTelegraf.fontWeightBold,
                        ),
                  ),
                  Text(
                    _lpIndollarsCalculation(
                      airdropForm.actualLPFiatValue,
                      airdropForm.personalLPFlexible,
                    ),
                    style: Theme.of(context).textTheme.bodySmallWithOpacity,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        aedappfm.BlockInfo(
          width: MediaQuery.of(context).size.width,
          paddingEdgeInsetsClipRRect: EdgeInsets.zero,
          paddingEdgeInsetsInfo: const EdgeInsets.all(10),
          blockInfoColor: aedappfm.BlockInfoColor.neutral,
          info: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizations.airdropDashboardDetailPersonalMultiplierValue,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '${airdropForm.personalMultiplier}x',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeightTelegraf.fontWeightBold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: BtnPrimary(
            buttonText:
                localizations.airdropDashboardDetailPersonalMultiplierBtn,
            onTap: () async {
              await CupertinoScaffold.showCupertinoModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return FractionallySizedBox(
                    heightFactor: 1,
                    child: Scaffold(
                      backgroundColor: aedappfm.AppThemeBase.sheetBackground
                          .withValues(alpha: 0.2),
                      body: const AirdropModalPersonalMultiplier(),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  String _lpIndollarsCalculation(double lpValue, double amount) {
    return '(\$${(Decimal.parse(amount.toString()) * Decimal.parse(lpValue.toString())).toDouble().formatNumber(precision: 2)})';
  }
}
