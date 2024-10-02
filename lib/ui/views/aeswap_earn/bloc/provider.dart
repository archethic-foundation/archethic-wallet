import 'package:aewallet/application/aeswap/dex_token.dart';
import 'package:aewallet/modules/aeswap/application/balance.dart';
import 'package:aewallet/modules/aeswap/application/farm/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/application/pool/dex_pool.dart';
import 'package:aewallet/modules/aeswap/application/session/provider.dart';
import 'package:aewallet/modules/aeswap/application/session/state.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/state.dart';
import 'package:decimal/decimal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
FarmLockFormBalances farmLockFormBalances(
  FarmLockFormBalancesRef ref,
) {
  final pool = ref.watch(farmLockFormPoolProvider).value;

  if (pool == null) return const FarmLockFormBalances();

  return FarmLockFormBalances(
    token1Balance: ref
            .watch(
              getBalanceProvider(
                pool.pair.token1.address,
              ),
            )
            .value ??
        0,
    token2Balance: ref
            .watch(
              getBalanceProvider(
                pool.pair.token2.address,
              ),
            )
            .value ??
        0,
    lpTokenBalance: ref
            .watch(
              getBalanceProvider(
                pool.lpToken.address,
              ),
            )
            .value ??
        0,
  );
}

@riverpod
FarmLockFormSummary farmLockFormSummary(
  FarmLockFormSummaryRef ref,
) {
  final farmLock = ref.watch(farmLockFormFarmLockProvider).value;

  if (farmLock == null) return const FarmLockFormSummary();

  var capitalInvested = 0.0;
  var rewardsEarned = 0.0;
  var farmedTokensCapitalInFiat = 0.0;
  var price = 0.0;

  farmLock.userInfos.forEach((depositId, userInfos) {
    capitalInvested = capitalInvested + userInfos.amount;
    rewardsEarned = rewardsEarned + userInfos.rewardAmount;
  });

  farmedTokensCapitalInFiat = ref
          .watch(
            DexTokensProviders.estimateLPTokenInFiat(
              farmLock.lpTokenPair!.token1.address,
              farmLock.lpTokenPair!.token2.address,
              capitalInvested,
              farmLock.poolAddress,
            ),
          )
          .value ??
      0;

  price = ref
          .watch(
            DexTokensProviders.estimateTokenInFiat(
              farmLock.rewardToken!.address,
            ),
          )
          .value ??
      0;

  return FarmLockFormSummary(
    farmedTokensCapital: capitalInvested,
    farmedTokensRewards: rewardsEarned,
    farmedTokensCapitalInFiat: farmedTokensCapitalInFiat,
    farmedTokensRewardsInFiat:
        (Decimal.parse('$price') * Decimal.parse('$rewardsEarned')).toDouble(),
  );
}

@riverpod
Future<DexPool?> farmLockFormPool(FarmLockFormPoolRef ref) {
  final environment = ref.watch(environmentProvider);
  return ref.watch(
    DexPoolProviders.getPool(
      environment.aeETHUCOPoolAddress,
    ).future,
  );
}

@riverpod
Future<DexFarmLock?> farmLockFormFarmLock(
  FarmLockFormFarmLockRef ref,
) {
  final environment = ref.watch(environmentProvider);

  return ref.watch(
    DexFarmLockProviders.getFarmLockInfos(
      environment.aeETHUCOFarmLockAddress,
      environment.aeETHUCOPoolAddress,
      dexFarmLockInput: DexFarmLock(
        poolAddress: environment.aeETHUCOPoolAddress,
        farmAddress: environment.aeETHUCOFarmLockAddress,
      ),
    ).future,
  );
}
