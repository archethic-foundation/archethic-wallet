import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/farm_lock_block_list_single_line_lock.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AirdropLPAvailable extends ConsumerWidget {
  const AirdropLPAvailable({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final airdropForm = ref.watch(airdropFormNotifierProvider);
    if (airdropForm.personalLPFlexible == 0) {
      return const SizedBox.shrink();
    }
    final farmLock = ref.watch(farmLockFormFarmLockProvider).valueOrNull;
    if (farmLock == null || farmLock.userInfos.entries.isEmpty) {
      return const SizedBox.shrink();
    }

    final localizations = AppLocalizations.of(context)!;
    AppTextStyles.bodyMediumSecondaryColor(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () async {
          await CupertinoScaffold.showCupertinoModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return FractionallySizedBox(
                heightFactor: 1,
                child: Scaffold(
                  backgroundColor:
                      aedappfm.AppThemeBase.sheetBackground.withOpacity(0.2),
                  body: const FarmLockBlockListSingleLineLock(),
                ),
              );
            },
          );
        },
        child: aedappfm.BlockInfo(
          width: MediaQuery.of(context).size.width,
          paddingEdgeInsetsInfo: const EdgeInsets.all(10),
          info: Stack(
            children: [
              Icon(
                Symbols.info,
                color: AppTextStyles.bodySmallWithOpacity(context).color,
                size: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, right: 10),
                      child: Text(
                        localizations.airdropDashboardLPTokenAvailable(
                          airdropForm.personalLPFlexible
                              .formatNumber(precision: 2),
                        ),
                        style: AppTextStyles.bodySmall(context),
                      ),
                    ),
                  ),
                  Icon(
                    Symbols.chevron_right,
                    color: AppTextStyles.bodySmallWithOpacity(context).color,
                    size: 24,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
