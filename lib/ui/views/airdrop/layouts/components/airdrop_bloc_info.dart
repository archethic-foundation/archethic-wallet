import 'package:aewallet/application/airdrop/airdrop.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_participants_count.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:numeral/numeral.dart';

class AirdropBlocInfo extends ConsumerWidget {
  const AirdropBlocInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final boldBodyLarge = AppTextStyles.bodyLarge(context).copyWith(
      fontWeight: FontWeight.bold,
    );
    final boldBodyLargeSecondary =
        AppTextStyles.bodyLargeSecondaryColor(context).copyWith(
      fontWeight: FontWeight.bold,
    );
    final bodyMediumSecondary = AppTextStyles.bodyMediumSecondaryColor(context);

    double? ucoPerParticipant;
    ref.watch(airdropCountProvider).when(
          data: (airdropCount) {
            if (airdropCount.totalMultiplier != null &&
                airdropCount.totalMultiplier! > 0) {
              final archethicOracleUCO = ref
                  .watch(
                      aedappfm.ArchethicOracleUCOProviders.archethicOracleUCO)
                  .valueOrNull;

              ucoPerParticipant = ((Decimal.parse('100000000') /
                              Decimal.fromInt(
                                airdropCount.totalMultiplier!,
                              ))
                          .toDecimal() *
                      Decimal.parse('${archethicOracleUCO?.usd ?? 0}'))
                  .toDouble();
            }
          },
          loading: () {},
          error: (error, stack) {},
        );

    return LayoutBuilder(
      builder: (context, constraints) {
        return aedappfm.BlockInfo(
          paddingEdgeInsetsClipRRect: EdgeInsets.zero,
          paddingEdgeInsetsInfo: EdgeInsets.zero,
          height: 190,
          width: constraints.maxWidth,
          info: Stack(
            children: [
              Positioned.fill(
                top: -40,
                left: -200,
                child: Transform.rotate(
                  angle: -10 * 3.14 / 180,
                  child: Opacity(
                    opacity: 0.2,
                    child: Image.asset(
                      'assets/themes/archethic/logo_crystal.png',
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    localizations.airdropParticipateStepWelcomeCardTitle,
                    style: boldBodyLargeSecondary,
                  ),
                  Text(
                    localizations.airdropParticipateStepWelcomeCardAmount,
                    style: boldBodyLarge.copyWith(fontSize: 32),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localizations
                            .airdropParticipateStepWelcomeCardUCOValuePerParticipant,
                        style: boldBodyLarge,
                      ),
                      Text(
                        ucoPerParticipant == null
                            ? '?'
                            : '\$${ucoPerParticipant!.numeral(digits: 2)}',
                        style: bodyMediumSecondary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const AirdropParticipantsCount(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
