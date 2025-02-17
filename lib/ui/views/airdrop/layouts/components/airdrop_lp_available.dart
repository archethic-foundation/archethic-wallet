import 'package:aewallet/application/airdrop/airdrop.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropLPAvailable extends ConsumerWidget {
  const AirdropLPAvailable({
    required this.personalLPFlexibleAmount,
    super.key,
  });

  final double personalLPFlexibleAmount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    ref.watch(airdropCountProvider);
    final bodyMedium = AppTextStyles.bodyMedium(context);
    AppTextStyles.bodyMediumSecondaryColor(context);

    if (personalLPFlexibleAmount > 0) {
      return Container(
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: aedappfm.ArchethicThemeBase.systemPositive300,
          ),
          borderRadius: BorderRadius.circular(12),
          color: Colors.black,
        ),
        child: Text(
          localizations.airdropDashboardLPTokenAvailable(
            personalLPFlexibleAmount.formatNumber(precision: 2),
          ),
          style: bodyMedium,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
