import 'package:aewallet/application/airdrop/airdrop.dart';
import 'package:aewallet/application/airdrop/airdrop_notifier.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme_base.dart';
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
    final airdropAsync = ref.watch(airdropNotifierProvider);
    var personalMultiplier = 0;
    var personalRewards = 0.0;

    airdropAsync.when(
      data: (airdrop) {
        if (airdrop != null) {
          personalMultiplier = airdrop.personalMultiplier ?? 0;
          ref.watch(airdropCountProvider).when(
                data: (airdropCount) {
                  if (airdropCount.totalMultiplier != null &&
                      airdropCount.totalMultiplier! > 0) {
                    final archethicOracleUCO = ref
                        .watch(aedappfm
                            .ArchethicOracleUCOProviders.archethicOracleUCO)
                        .valueOrNull;

                    if (archethicOracleUCO?.usd != null) {
                      final result = (Decimal.parse('100000000') /
                                  Decimal.fromInt(
                                      airdropCount.totalMultiplier!))
                              .toDecimal(scaleOnInfinitePrecision: 8) *
                          Decimal.fromInt(personalMultiplier) *
                          Decimal.parse('${archethicOracleUCO?.usd}');
                      personalRewards = result.toDouble();
                    }
                  }
                },
                loading: () {},
                error: (error, stack) {},
              );
        }
      },
      loading: () {},
      error: (error, stack) {},
    );

    return Container(
      height: 105,
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
      decoration: BoxDecoration(
        border: Border.all(
          color: ArchethicThemeBase.palePurpleBorder,
        ),
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '\$${personalRewards.numeral(digits: 2)}',
            style: AppTextStyles.bodyLarge(context).copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            localizations.airdropPersonalValue,
            style: AppTextStyles.bodyMediumWithOpacity(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
