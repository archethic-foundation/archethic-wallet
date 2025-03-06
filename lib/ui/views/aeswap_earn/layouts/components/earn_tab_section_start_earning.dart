import 'dart:convert';

import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/settings.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/farm_lock_block_list_single_line_lock.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/layouts/farm_lock_deposit_sheet.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_withdraw/layouts/farm_lock_withdraw_funds_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
    final earnUserLevel = ref.watch(
      SettingsProviders.settings.select((settings) => settings.earnUserLevel),
    );
    final accountSelected = ref.watch(
      accountsNotifierProvider.select(
        (accounts) => accounts.valueOrNull?.selectedAccount,
      ),
    );

    if ((earnUserLevel == EarnUserLevelType.beginner &&
            accountSelected != null &&
            accountSelected.balance != null &&
            accountSelected.balance!.nativeTokenValue <= 0) ||
        (earnUserLevel == EarnUserLevelType.advanced &&
            balances.lpTokenBalance <= 0)) {
      return aedappfm.BlockInfo(
        blockInfoColor: aedappfm.BlockInfoColor.grey,
        borderWidth: 2,
        paddingEdgeInsetsInfo:
            const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
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
                  earnUserLevel == EarnUserLevelType.beginner
                      ? '2. ${localizations.earnSectionStartEarningTitle} '
                      : '3. ${localizations.earnSectionStartEarningTitle} ',
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
                earnUserLevel == EarnUserLevelType.beginner
                    ? '2. ${localizations.earnSectionStartEarningTitle} '
                    : '3. ${localizations.earnSectionStartEarningTitle} ',
                style: Theme.of(context).textTheme.titleSmallSemiBold,
              ),
              if (farmLock != null && farmLock.apr3years > 0)
                Text(
                  '${localizations.earnSectionStartEarningTitleAPR((farmLock.apr3years * 100).formatNumber(precision: 0).replaceAll('.', ''))} ',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
            ],
          ),
          const SizedBox(height: 20),
          if (earnUserLevel == EarnUserLevelType.beginner)
            Text(
              localizations.earnSectionStartEarningBeginnerDesc1,
              style: Theme.of(context).textTheme.bodySmallWithOpacity,
            )
          else
            Text.rich(
              TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: localizations.earnSectionStartEarningDesc1,
                    style: Theme.of(context).textTheme.bodySmallWithOpacity,
                  ),
                  TextSpan(
                    text:
                        '${balances.lpTokenBalance.formatNumber(precision: 2)} LP',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmallWithOpacity
                        .copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextSpan(
                    text: localizations.earnSectionStartEarningDesc2,
                    style: Theme.of(context).textTheme.bodySmallWithOpacity,
                  ),
                ],
              ),
            ),
          const SizedBox(height: 30),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 10,
            children: [
              BtnPrimary(
                buttonText: earnUserLevel == EarnUserLevelType.beginner
                    ? localizations.earnSectionStartEarningBeginnerDepositLPBtn
                    : localizations.earnSectionStartEarningDepositLPBtn,
                onTap: () async {
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
              const SizedBox(width: 10),
              if (earnUserLevel == EarnUserLevelType.advanced)
                BtnPrimary(
                  buttonText:
                      localizations.earnSectionStartEarningWithdrawLPBtn,
                  onTap: () async {
                    await CupertinoScaffold.showCupertinoModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return FractionallySizedBox(
                          heightFactor: 1,
                          child: Scaffold(
                            backgroundColor: aedappfm
                                .AppThemeBase.sheetBackground
                                .withOpacity(0.2),
                            body: const FarmLockBlockListSingleLineLock(),
                          ),
                        );
                      },
                    );
                  },
                  btnPrimaryType: BtnPrimaryType.outlinePrimary,
                )
              else
                BtnPrimary(
                  buttonText:
                      localizations.earnSectionStartEarningWithdrawLPBtn,
                  onTap: () async {
                    await context.push(
                      FarmLockWithdrawFundsSheet.routerPage,
                    );
                  },
                  btnPrimaryType: BtnPrimaryType.outlinePrimary,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
