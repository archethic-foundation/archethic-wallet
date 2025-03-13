import 'package:aewallet/application/airdrop/airdrop.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/figma_components/box/box_dark.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:numeral/numeral.dart';

class AirdropPersonalRewards extends ConsumerWidget {
  const AirdropPersonalRewards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final airdropForm = ref.watch(airdropFormNotifierProvider);
    var personalRewards = 0.0;

    ref.watch(airdropCountProvider).when(
          data: (airdropCount) {
            if (airdropCount.totalMultiplier != null &&
                airdropCount.totalMultiplier! > 0 &&
                airdropForm.personalMultiplier > 0) {
              final result = (Decimal.parse('100000000') /
                          Decimal.fromInt(airdropCount.totalMultiplier!))
                      .toDecimal(scaleOnInfinitePrecision: 8) *
                  Decimal.fromInt(airdropForm.personalMultiplier);
              personalRewards = result.toDouble();
            }
          },
          loading: () {},
          error: (error, stack) {},
        );

    return Column(
      spacing: 5,
      children: [
        BoxDark(
          textWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$${personalRewards.numeral(digits: 2)}',
                style: AppTextStyles.bodyLarge(context).copyWith(
                  fontSize: 24,
                  fontWeight: FontWeightTelegraf.fontWeightBold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Text(
                  '*',
                  style:
                      Theme.of(context).textTheme.bodySmallWithOpacity.copyWith(
                            fontSize: 24,
                          ),
                ),
              ),
            ],
          ),
          additionalWidget: Column(
            children: [
              Text(
                localizations.airdropPersonalValue,
                style: Theme.of(context).textTheme.bodyMediumWithOpacity,
                textAlign: TextAlign.center,
              ),
              Text(
                localizations.airdropPersonalValueInfo,
                style: Theme.of(context)
                    .textTheme
                    .bodySmallWithOpacity
                    .copyWith(fontSize: 8),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Text(
                '*',
                style:
                    Theme.of(context).textTheme.bodySmallWithOpacity.copyWith(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
              ),
            ),
            Text(
              '${localizations.airdropDashboard1MultiplierDollars} \$${airdropForm.actualLPFiatValue.formatNumber(precision: 2)}',
              style: Theme.of(context).textTheme.bodySmallWithOpacity.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
