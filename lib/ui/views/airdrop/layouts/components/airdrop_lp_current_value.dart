import 'package:aewallet/application/aeswap/dex_token.dart';
import 'package:aewallet/modules/aeswap/application/session/provider.dart';
import 'package:aewallet/modules/aeswap/application/session/state.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropLPCurrentValue extends ConsumerWidget {
  const AirdropLPCurrentValue({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmLock = ref.watch(farmLockFormFarmLockProvider).value;
    if (farmLock == null || farmLock.lpTokenPair == null) {
      return const SizedBox(
        height: 20,
      );
    }

    final localizations = AppLocalizations.of(context)!;

    final environment = ref.watch(environmentProvider);

    return FutureBuilder<double>(
      future: ref.watch(
        DexTokensProviders.estimateLPTokenInFiat(
          farmLock.lpTokenPair!.token1.address,
          farmLock.lpTokenPair!.token2.address,
          1,
          environment.aeETHUCOPoolAddress,
        ).future,
      ),
      builder: (
        context,
        snapshotAmounts,
      ) {
        if (snapshotAmounts.hasData && snapshotAmounts.data != null) {
          return Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text:
                      '\$${snapshotAmounts.data!.formatNumber(precision: 2)} ',
                  style: AppTextStyles.bodyMediumSecondaryColor(context),
                ),
                TextSpan(
                  text: localizations.airdropLPValue,
                  style: AppTextStyles.bodyMedium(context),
                ),
              ],
            ),
          );
        }
        return const SizedBox(
          height: 20,
        );
      },
    );
  }
}
