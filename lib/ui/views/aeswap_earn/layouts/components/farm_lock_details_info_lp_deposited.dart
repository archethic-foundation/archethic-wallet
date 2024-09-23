import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/infrastructure/pool_factory.repository.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/widgets/components/sheet_detail_card.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockDetailsInfoLPDeposited extends ConsumerWidget {
  const FarmLockDetailsInfoLPDeposited({
    super.key,
    required this.farmLock,
  });

  final DexFarmLock farmLock;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return SheetDetailCard(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              AppLocalizations.of(context)!.farmDetailsInfoLPDeposited,
              style: AppTextStyles.bodyMedium(context),
            ),
            SelectableText(
              '${farmLock.lpTokensDeposited.formatNumber(precision: 8)} ${farmLock.lpTokensDeposited > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
              style: AppTextStyles.bodyMedium(context),
            ),
            SelectableText(
              '(\$${farmLock.estimateLPTokenInFiat.formatNumber(precision: 2)})',
              style: AppTextStyles.bodyMedium(context),
            ),
            if (farmLock.lpTokensDeposited > 0)
              FutureBuilder<Map<String, dynamic>?>(
                future: PoolFactoryRepositoryImpl(
                  farmLock.poolAddress,
                  aedappfm.sl.get<ApiService>(),
                ).getRemoveAmounts(
                  farmLock.lpTokensDeposited,
                ),
                builder: (
                  context,
                  snapshotAmounts,
                ) {
                  if (snapshotAmounts.hasData && snapshotAmounts.data != null) {
                    final amountToken1 = snapshotAmounts.data!['token1'] == null
                        ? 0.0
                        : snapshotAmounts.data!['token1'] as double;
                    final amountToken2 = snapshotAmounts.data!['token2'] == null
                        ? 0.0
                        : snapshotAmounts.data!['token2'] as double;

                    return SelectableText(
                      '${AppLocalizations.of(context)!.poolDetailsInfoDepositedEquivalent} ${amountToken1.formatNumber(precision: amountToken1 > 1 ? 2 : 8)} ${farmLock.lpTokenPair!.token1.symbol.reduceSymbol()} / ${amountToken2.formatNumber(precision: amountToken2 > 1 ? 2 : 8)} ${farmLock.lpTokenPair!.token2.symbol.reduceSymbol()}',
                      style: AppTextStyles.bodySmall(context),
                    );
                  }
                  return SelectableText(
                    ' ',
                    style: AppTextStyles.bodySmall(context),
                  );
                },
              )
            else
              SelectableText(' ', style: AppTextStyles.bodySmall(context)),
          ],
        ),
      ],
    );
  }
}
