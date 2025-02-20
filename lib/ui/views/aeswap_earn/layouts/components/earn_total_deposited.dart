import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:numeral/numeral.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;

class EarnTotalDeposited extends ConsumerWidget {
  const EarnTotalDeposited({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final farmLock = ref.watch(farmLockFormFarmLockProvider).value;

    return aedappfm.BlackBoxInfo(
      textWidget: farmLock == null
          ? Text(
              r'$__',
              style: AppTextStyles.bodyLarge(context).copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )
          : Text(
              '\$${farmLock.estimateLPTokenInFiat.numeral(digits: 0)}',
              style: AppTextStyles.bodyLarge(context).copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
      additionalWidget: Text(
        localizations.earnTotalDeposited,
        style: AppTextStyles.bodySmallWithOpacity(context),
        textAlign: TextAlign.center,
      ),
    );
  }
}
