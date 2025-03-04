import 'dart:convert';

import 'package:aewallet/modules/aeswap/application/balance.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/layouts/liquidity_add_sheet.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_remove/layouts/liquidity_remove_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class EarnSectionAddLiquidity extends ConsumerWidget {
  const EarnSectionAddLiquidity({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final pool = ref.watch(farmLockFormPoolProvider).valueOrNull;
    final farmLock = ref.watch(farmLockFormFarmLockProvider).valueOrNull;
    double? token2Balance;

    if (farmLock != null && farmLock.lpTokenPair != null) {
      token2Balance = ref
          .watch(
            getBalanceProvider(
              farmLock.lpTokenPair!.token2.isUCO
                  ? kUCOAddress
                  : farmLock.lpTokenPair!.token2.address,
            ),
          )
          .valueOrNull;
    }

    if (token2Balance == null || token2Balance == 0) {
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
            Text(
              '2. ${localizations.earnSectionAddLiquidityTitle}',
              style: AppTextStyles.bodyLarge(context).copyWith(
                color: aedappfm.ArchethicThemeBase.neutral10,
              ),
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
          Text(
            '2. ${localizations.earnSectionAddLiquidityTitle}',
            style: Theme.of(context).textTheme.titleSmallSemiBold,
          ),
          const SizedBox(height: 20),
          Text(
            localizations.earnSectionAddLiquidityDesc1,
            style: Theme.of(context).textTheme.bodySmallWithOpacity,
          ),
          const SizedBox(height: 20),
          Text(
            localizations.earnSectionAddLiquidityDesc2,
            style: Theme.of(context)
                .textTheme
                .bodySmallWithOpacity
                .copyWith(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 30),
          Wrap(
            runSpacing: 10,
            children: [
              BtnPrimary(
                buttonText:
                    localizations.earnSectionAddLiquidityAddLiquidityBtn,
                onTap: () async {
                  final poolJson = jsonEncode(
                    pool!.toJson(),
                  );
                  final poolEncoded = Uri.encodeComponent(poolJson);
                  await context.push(
                    Uri(
                      path: LiquidityAddSheet.routerPage,
                      queryParameters: {
                        'pool': poolEncoded,
                      },
                    ).toString(),
                  );
                },
              ),
              const SizedBox(
                width: 10,
              ),
              BtnPrimary(
                buttonText:
                    localizations.earnSectionAddLiquidityWithdrawLiquidityBtn,
                onTap: () async {
                  final poolJson = jsonEncode(
                    pool!.toJson(),
                  );
                  final pairJson = jsonEncode(
                    pool.pair.toJson(),
                  );
                  final lpTokenJson = jsonEncode(
                    pool.lpToken.toJson(),
                  );
                  final poolEncoded = Uri.encodeComponent(
                    poolJson,
                  );
                  final pairEncoded = Uri.encodeComponent(
                    pairJson,
                  );
                  final lpTokenEncoded = Uri.encodeComponent(
                    lpTokenJson,
                  );
                  await context.push(
                    Uri(
                      path: LiquidityRemoveSheet.routerPage,
                      queryParameters: {
                        'pool': poolEncoded,
                        'pair': pairEncoded,
                        'lpToken': lpTokenEncoded,
                      },
                    ).toString(),
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
