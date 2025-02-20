import 'dart:convert';

import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/layouts/farm_lock_deposit_sheet.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class EarnSectionStartEarning extends ConsumerWidget {
  const EarnSectionStartEarning({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final balances = ref.watch(farmLockFormBalancesProvider);
    final farmLock = ref.watch(farmLockFormFarmLockProvider).valueOrNull;
    final pool = ref.watch(farmLockFormPoolProvider).valueOrNull;

    if (balances.lpTokenBalance <= 0) {
      return aedappfm.BlockInfo(
        blockInfoColor: aedappfm.BlockInfoColor.grey,
        borderWidth: 2,
        paddingEdgeInsetsInfo:
            const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        width: MediaQuery.of(context).size.width,
        info: Row(
          children: [
            Icon(
              Symbols.lock,
              color: aedappfm.ArchethicThemeBase.neutral10,
              size: 14,
            ),
            const SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Text(
                  '3. ${localizations.earnSectionStartEarningTitle} ',
                  style: AppTextStyles.bodyLarge(context).copyWith(
                    color: aedappfm.ArchethicThemeBase.neutral10,
                  ),
                ),
                if (farmLock != null && farmLock.apr3years > 0)
                  Text(
                    '${localizations.earnSectionStartEarningTitleAPR((farmLock.apr3years * 100).formatNumber(precision: 0).replaceAll('.', ''))} ',
                    style: AppTextStyles.bodyLarge(context).copyWith(
                      color: aedappfm.ArchethicThemeBase.neutral10,
                    ),
                  ),
              ],
            ),
          ],
        ),
      );
    }

    return aedappfm.BlockInfo(
      blockInfoColor: aedappfm.BlockInfoColor.purple,
      borderWidth: 0,
      paddingEdgeInsetsInfo: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      info: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '3. ${localizations.earnSectionStartEarningTitle} ',
                style: AppTextStyles.bodyLargeSecondaryColor(context).copyWith(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              if (farmLock != null && farmLock.apr3years > 0)
                Text(
                  '${localizations.earnSectionStartEarningTitleAPR((farmLock.apr3years * 100).formatNumber(precision: 0).replaceAll('.', ''))} ',
                  style:
                      AppTextStyles.bodyLargeSecondaryColor(context).copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Text.rich(
            TextSpan(
              text: '',
              children: <InlineSpan>[
                TextSpan(
                  text: localizations.earnSectionStartEarningDesc1,
                  style: AppTextStyles.bodySmall(context),
                ),
                TextSpan(
                  text:
                      '${balances.lpTokenBalance.formatNumber(precision: 2)} LP',
                  style: AppTextStyles.bodySmall(context).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: localizations.earnSectionStartEarningDesc2,
                  style: AppTextStyles.bodySmall(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              CustomSmallBtn(
                buttonText: localizations.earnSectionStartEarningDepositLPBtn,
                onPressed: () async {
                  final poolJson = jsonEncode(pool!.toJson());
                  final poolEncoded = Uri.encodeComponent(poolJson);
                  await context.push(
                    Uri(
                      path: FarmLockDepositSheet.routerPage,
                      queryParameters: {
                        'pool': poolEncoded,
                      },
                    ).toString(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
