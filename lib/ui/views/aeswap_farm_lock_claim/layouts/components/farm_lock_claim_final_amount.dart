import 'package:aewallet/ui/views/aeswap_farm_lock_claim/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockClaimFinalAmount extends ConsumerWidget {
  const FarmLockClaimFinalAmount({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmLockClaim =
        ref.watch(FarmLockClaimFormProvider.farmLockClaimForm);
    if (farmLockClaim.farmLockClaimOk == false) return const SizedBox.shrink();

    final finalAmount = farmLockClaim.finalAmount;
    final timeout = ref.watch(
      FarmLockClaimFormProvider.farmLockClaimForm
          .select((value) => value.failure != null),
    );

    return finalAmount != null
        ? SelectableText(
            '${AppLocalizations.of(context)!.farmLockClaimFinalAmount} ${finalAmount.formatNumber(precision: 8)} ${farmLockClaim.rewardToken!.symbol}',
            style: TextStyle(
              fontSize: aedappfm.Responsive.fontSizeFromValue(
                context,
                desktopValue: 13,
              ),
            ),
          )
        : timeout == false
            ? Row(
                children: [
                  SelectableText(
                    AppLocalizations.of(context)!.farmLockClaimFinalAmount,
                    style: TextStyle(
                      fontSize: aedappfm.Responsive.fontSizeFromValue(
                        context,
                        desktopValue: 13,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(strokeWidth: 1),
                  ),
                ],
              )
            : SelectableText(
                '${AppLocalizations.of(context)!.farmLockClaimFinalAmount} ${AppLocalizations.of(context)!.finalAmountNotRecovered}',
                style: TextStyle(
                  fontSize: aedappfm.Responsive.fontSizeFromValue(
                    context,
                    desktopValue: 13,
                  ),
                ),
              );
  }
}
