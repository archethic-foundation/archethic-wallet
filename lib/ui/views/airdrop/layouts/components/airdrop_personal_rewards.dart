import 'package:aewallet/application/airdrop/airdrop.dart';
import 'package:aewallet/ui/figma_components/box/box_dark.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropPersonalRewards extends ConsumerWidget {
  const AirdropPersonalRewards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final airdropForm = ref.watch(airdropFormNotifierProvider);
    var personalRewards = 0.0;
    var oneMultiplierInDollars = 0.0;
    ref.watch(airdropCountProvider).when(
          data: (airdropCount) {
            final totalMultiplier =
                Decimal.fromInt(airdropCount.totalPersonalMultiplier ?? 0) +
                    Decimal.fromInt(airdropCount.totalReferralMultiplier ?? 0);

            if (totalMultiplier.toDouble() > 0 &&
                airdropForm.personalMultiplier > 0) {
              final result = (Decimal.parse('100000000') / totalMultiplier)
                      .toDecimal(scaleOnInfinitePrecision: 8) *
                  Decimal.fromInt(airdropForm.totalUserMultiplier);
              personalRewards = result.toDouble();
            }

            oneMultiplierInDollars =
                (Decimal.parse('100000000') / totalMultiplier).toDouble();
          },
          loading: () {},
          error: (error, stack) {},
        );

    return IntrinsicHeight(
      child: Column(
        spacing: 5,
        children: [
          BoxDark(
            textWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${personalRewards.formatNumber(precision: 2)}',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeightTelegraf.fontWeightBold,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Text(
                    '*',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmallWithOpacity
                        .copyWith(
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
                '${localizations.airdropDashboard1MultiplierDollars} \$${oneMultiplierInDollars.formatNumber(precision: 0).replaceAll('.', '')}',
                style:
                    Theme.of(context).textTheme.bodySmallWithOpacity.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
