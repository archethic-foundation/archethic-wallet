import 'package:aewallet/ui/figma_components/box/box_dark.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EarnTotalDeposited extends ConsumerWidget {
  const EarnTotalDeposited({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final farmLockAsync = ref.watch(farmLockFormFarmLockProvider);

    return BoxDark(
      textWidget: farmLockAsync.when(
        data: (farmLock) {
          if (farmLock == null) {
            return Text(
              r'$__',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeightTelegraf.fontWeightBold,
                  ),
            );
          }
          return Text(
            '\$${farmLock.estimateLPTokenInFiat.formatNumber(precision: 0).replaceAll('.', '')}',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeightTelegraf.fontWeightBold,
                ),
          );
        },
        error: (_, __) {
          return Text(
            r'$__',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeightTelegraf.fontWeightBold,
                ),
          );
        },
        loading: () {
          return const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 7),
            child: SizedBox.square(
              dimension: 15,
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            ),
          );
        },
      ),
      additionalWidget: Text(
        localizations.earnTotalDeposited,
        style: Theme.of(context).textTheme.bodySmallWithOpacity,
        textAlign: TextAlign.center,
      ),
    );
  }
}
