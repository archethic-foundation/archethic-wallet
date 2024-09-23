import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/state.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/farm_lock_details_info.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class EarnFarmLockInfos extends ConsumerWidget {
  const EarnFarmLockInfos({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final earnForm =
        ref.watch(earnFormNotifierProvider).value ?? const EarnFormState();
    final preferences = ref.watch(SettingsProviders.settings);

    return InkWell(
      onTap: earnForm.farmLock == null
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
                  return FractionallySizedBox(
                    heightFactor: 0.90,
                    child: FarmLockDetailsInfo(
                      farmLock: earnForm.farmLock!,
                    ),
                  );
                },
              );
            },
      child: Container(
        height: 36,
        width: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: earnForm.farmLock == null
              ? aedappfm.AppThemeBase.gradient
              : aedappfm.AppThemeBase.gradientBtn,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          aedappfm.Iconsax.search_status,
          size: 18,
        ),
      ),
    );
  }
}
