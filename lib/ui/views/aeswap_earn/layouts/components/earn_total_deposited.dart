import 'package:aewallet/ui/figma_components/box/box_dark.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:numeral/numeral.dart';

class EarnTotalDeposited extends ConsumerWidget {
  const EarnTotalDeposited({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final farmLock = ref.watch(farmLockFormFarmLockProvider).value;

    return BoxDark(
      textWidget: farmLock == null
          ? Text(
              r'$__',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeightTelegraf.fontWeightBold,
                  ),
            )
          : Text(
              '\$${farmLock.estimateLPTokenInFiat.numeral(digits: 0)}',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeightTelegraf.fontWeightBold,
                  ),
            ),
      additionalWidget: Text(
        localizations.earnTotalDeposited,
        style: Theme.of(context).textTheme.bodySmallWithOpacity,
        textAlign: TextAlign.center,
      ),
    );
  }
}
