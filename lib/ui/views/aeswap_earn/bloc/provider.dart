import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/modules/aeswap/application/dex_token.dart';
import 'package:aewallet/modules/aeswap/application/farm/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/application/pool/dex_pool.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/pool_farm_available.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/state.dart';
import 'package:decimal/decimal.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class EarnFormNotifier extends _$EarnFormNotifier {
  EarnFormNotifier();

  static final _logger = Logger('EarnFormNotifier');

  @override
  Future<EarnFormState> build() async {
    try {
      var _tempState = const EarnFormState();

      final env =
          ref.read(SettingsProviders.settings).network.getNetworkLabel();
      final contextAddresses =
          PoolFarmAvailableState().getContextAddresses(env);

      final accountSelected = ref.watch(
        AccountProviders.accounts.select(
          (accounts) => accounts.value?.selectedAccount,
        ),
      );

      final poolFuture = ref.watch(
        DexPoolProviders.getPool(
          contextAddresses.aeETHUCOPoolAddress,
        ).future,
      );

      Future<DexFarmLock?>? farmLockFuture;
      if (contextAddresses.aeETHUCOFarmLockAddress.isNotEmpty) {
        farmLockFuture = ref.watch(
          DexFarmLockProviders.getFarmLockInfos(
            contextAddresses.aeETHUCOFarmLockAddress,
            contextAddresses.aeETHUCOPoolAddress,
            accountSelected!.genesisAddress,
            dexFarmLockInput: DexFarmLock(
              poolAddress: contextAddresses.aeETHUCOPoolAddress,
              farmAddress: contextAddresses.aeETHUCOFarmLockAddress,
            ),
          ).future,
        );
      }

      final results = await Future.wait([
        poolFuture,
        if (farmLockFuture != null) farmLockFuture,
      ]);

      final pool = results[0] as DexPool?;
      _tempState = _tempState.copyWith(pool: pool);

      final lpTokenBalance = accountSelected!.accountTokens
              ?.singleWhere(
                (token) =>
                    token.tokenInformation?.address!.toUpperCase() ==
                    pool?.lpToken.address!.toUpperCase(),
              )
              .amount ??
          0.0;
      _tempState = _tempState.copyWith(lpTokenBalance: lpTokenBalance);

      if (farmLockFuture != null) {
        final farmLock = results[1] as DexFarmLock?;
        if (farmLock != null) {
          _tempState = _tempState.copyWith(farmLock: farmLock);
          _tempState = await _calculateSummary(_tempState);

          return _tempState;
        }
      }
    } catch (e) {
      _logger.warning(
        '$e',
      );
    }

    return const EarnFormState();
  }

  Future<EarnFormState> _calculateSummary(
    EarnFormState state,
  ) async {
    var capitalInvested = 0.0;
    var rewardsEarned = 0.0;
    var farmedTokensCapitalInFiat = 0.0;
    var price = 0.0;

    state.farmLock?.userInfos.forEach((depositId, userInfos) {
      capitalInvested += userInfos.amount;
      rewardsEarned += userInfos.rewardAmount;
    });

    farmedTokensCapitalInFiat = await ref.watch(
      DexTokensProviders.estimateLPTokenInFiat(
        state.farmLock!.lpTokenPair!.token1,
        state.farmLock!.lpTokenPair!.token2,
        capitalInvested,
        state.farmLock!.poolAddress,
      ).future,
    );

    price = await ref.watch(
      DexTokensProviders.estimateTokenInFiat(state.farmLock!.rewardToken!)
          .future,
    );

    return state.copyWith(
      farmedTokensCapital: capitalInvested,
      farmedTokensRewards: rewardsEarned,
      farmedTokensCapitalInFiat: farmedTokensCapitalInFiat,
      farmedTokensRewardsInFiat:
          (Decimal.parse('$price') * Decimal.parse('$rewardsEarned'))
              .toDouble(),
    );
  }
}
