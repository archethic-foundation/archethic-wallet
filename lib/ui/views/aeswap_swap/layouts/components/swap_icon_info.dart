/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/views/aeswap_swap/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_swap/layouts/components/swap_infos.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SwapTokenIconInfo extends ConsumerWidget {
  const SwapTokenIconInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(SwapFormProvider.swapForm);
    final disabled = swap.tokenToSwap == null ||
        swap.tokenSwapped == null ||
        swap.pool == null ||
        swap.pool!.poolAddress.isEmpty;

    final preferences = ref.watch(SettingsProviders.settings);
    return InkWell(
      onTap: disabled || swap.calculationInProgress
          ? null
          : () async {
              sl.get<HapticUtil>().feedback(
                    FeedbackType.light,
                    preferences.activeVibrations,
                  );

              await showBarModalBottomSheet(
                context: context,
                backgroundColor:
                    aedappfm.AppThemeBase.sheetBackground.withOpacity(0.2),
                builder: (BuildContext context) {
                  return const FractionallySizedBox(
                    heightFactor: 0.75,
                    child: SwapInfos(),
                  );
                },
              );
            },
      child: Container(
        height: 30,
        width: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: disabled
              ? aedappfm.AppThemeBase.gradient
              : aedappfm.AppThemeBase.gradientBtn,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          aedappfm.Iconsax.info_circle,
          size: 15,
        ),
      ),
    );
  }
}
