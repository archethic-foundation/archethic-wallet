import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock_user_infos.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/farm_lock_block_list_single_line_lock.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class EarnFarmLockListLocks extends ConsumerStatefulWidget {
  const EarnFarmLockListLocks({
    required this.farmLock,
    required this.pool,
    super.key,
  });

  final DexFarmLock? farmLock;
  final DexPool pool;

  @override
  ConsumerState<EarnFarmLockListLocks> createState() =>
      _EarnFarmLockListLocksState();
}

class _EarnFarmLockListLocksState extends ConsumerState<EarnFarmLockListLocks> {
  List<DexFarmLockUserInfos> sortedUserInfos = [];

  @override
  void initState() {
    if (widget.farmLock != null) {
      sortedUserInfos = widget.farmLock!.userInfos.entries
          .map((entry) => entry.value)
          .toList();

      sortedUserInfos.sort((a, b) {
        return a.level.compareTo(b.level);
      });
    }

    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final preferences = ref.watch(SettingsProviders.settings);

    return InkWell(
      onTap: sortedUserInfos.isEmpty
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
                    child: aedappfm.ArchethicScrollbar(
                      thumbVisibility: false,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              AppLocalizations.of(
                                context,
                              )!
                                  .farmLockListLocksHeader,
                              style: AppTextStyles.bodyLarge(context),
                            ),
                          ),
                          ...sortedUserInfos.map(
                            (userInfo) {
                              return FarmLockBlockListSingleLineLock(
                                farmLock: widget.farmLock!,
                                farmLockUserInfos: userInfo,
                                pool: widget.pool,
                              );
                            },
                          ),
                        ],
                      ),
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
          gradient: sortedUserInfos.isEmpty
              ? aedappfm.AppThemeBase.gradient
              : aedappfm.AppThemeBase.gradientBtn,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          aedappfm.Iconsax.task,
          size: 18,
        ),
      ),
    );
  }
}
