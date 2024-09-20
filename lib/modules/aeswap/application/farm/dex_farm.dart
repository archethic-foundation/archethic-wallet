import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/modules/aeswap/application/dex_config.dart';
import 'package:aewallet/modules/aeswap/application/dex_token.dart';
import 'package:aewallet/modules/aeswap/application/pool/dex_pool.dart';
import 'package:aewallet/modules/aeswap/application/router_factory.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_farm.dart';
import 'package:aewallet/modules/aeswap/infrastructure/dex_farm.repository.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_farm.g.dart';
part 'dex_farm_list.dart';

@riverpod
DexFarmRepositoryImpl _dexFarmRepository(_DexFarmRepositoryRef ref) =>
    DexFarmRepositoryImpl();

@riverpod
Future<DexFarm?> _getFarmInfos(
  _GetFarmInfosRef ref,
  String farmGenesisAddress,
  String poolAddress, {
  DexFarm? dexFarmInput,
}) async {
  final poolList = await ref.read(DexPoolProviders.getPoolList.future);

  final pool = poolList.firstWhereOrNull(
    (poolSelect) =>
        poolSelect.poolAddress.toUpperCase() == poolAddress.toUpperCase(),
  );
  if (pool == null) return null;

  final userGenesisAddress = ref
          .watch(
            AccountProviders.accounts.select(
              (accounts) => accounts.valueOrNull?.selectedAccount,
            ),
          )
          ?.genesisAddress ??
      '';

  final farmInfos =
      await ref.watch(_dexFarmRepositoryProvider).populateFarmInfos(
            farmGenesisAddress,
            pool,
            dexFarmInput!,
            userGenesisAddress,
          );

  var apr = 0.0;
  final estimateLPTokenInFiat = await ref.read(
    DexTokensProviders.estimateLPTokenInFiat(
      farmInfos.lpTokenPair!.token1,
      farmInfos.lpTokenPair!.token2,
      farmInfos.lpTokenDeposited,
      dexFarmInput.poolAddress,
    ).future,
  );
  final now = DateTime.now().toUtc();

  final priceTokenInFiat = await ref.read(
    DexTokensProviders.estimateTokenInFiat(farmInfos.rewardToken!).future,
  );

  final remainingRewardInFiat = (Decimal.parse('$priceTokenInFiat') *
          Decimal.parse('${farmInfos.remainingReward}'))
      .toDouble();

  if (remainingRewardInFiat > 0 &&
      estimateLPTokenInFiat > 0 &&
      farmInfos.endDate != null &&
      now.isBefore(farmInfos.endDate!)) {
    final secondsUntilEnd = farmInfos.endDate!.difference(now).inSeconds;

    if (secondsUntilEnd > 0) {
      // 31 536 000 second in a year
      final rewardScalledToYear =
          remainingRewardInFiat * (31536000 / secondsUntilEnd);

      apr = (Decimal.parse('$rewardScalledToYear') /
              Decimal.parse('$estimateLPTokenInFiat'))
          .toDouble();
    }
  }

  return farmInfos.copyWith(
    estimateLPTokenInFiat: estimateLPTokenInFiat,
    remainingRewardInFiat: remainingRewardInFiat,
    apr: apr,
  );
}

abstract class DexFarmProviders {
  static final getFarmList = _getFarmListProvider;
  static const getFarmInfos = _getFarmInfosProvider;
}
