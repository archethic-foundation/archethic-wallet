import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/figma_components/text/gradient_text.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_level_up/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockLevelUpFinalAmount extends ConsumerWidget {
  const FarmLockLevelUpFinalAmount({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmLockLevelUp = ref.watch(farmLockLevelUpFormNotifierProvider);
    final finalAmount = farmLockLevelUp.finalAmount;
    final timeout = ref.watch(
      farmLockLevelUpFormNotifierProvider
          .select((value) => value.failure != null),
    );

    return aedappfm.BlockInfo(
      blockInfoColor: aedappfm.BlockInfoColor.purple,
      borderWidth: 0,
      paddingEdgeInsetsInfo: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      info: finalAmount != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  AppLocalizations.of(context)!.farmLockLevelUpFinalAmount,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeightTelegraf.fontWeightSemibold,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: GradientText(
                    '${finalAmount.formatNumber(precision: 8)} ${finalAmount > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
                    gradient: ArchethicGradients.gradientArchethic,
                    style: Theme.of(context).textTheme.bodyLarge!,
                  ),
                ),
              ],
            )
          : timeout
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      AppLocalizations.of(context)!.farmLockLevelUpFinalAmount,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeightTelegraf.fontWeightSemibold,
                          ),
                    ),
                    SelectableText(
                      AppLocalizations.of(context)!.finalAmountNotRecovered,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                )
              : const SizedBox.shrink(),
    );
  }
}
