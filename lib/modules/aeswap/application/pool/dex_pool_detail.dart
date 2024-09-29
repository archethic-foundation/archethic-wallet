/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'dex_pool.dart';

@Riverpod(keepAlive: true)
Future<DexPool?> _getPool(
  _GetPoolRef ref,
  String genesisAddress,
) async {
  final dexPoolRepository = ref.watch(_dexPoolRepositoryProvider);
  final tokenVerifiedList = await ref.watch(
    verifiedTokensProvider.future,
  );

  return dexPoolRepository.getPool(genesisAddress, tokenVerifiedList);
}

@riverpod
Future<DexPool> _loadPoolCard(
  _LoadPoolCardRef ref,
  DexPool poolInput, {
  bool forceLoadFromBC = false,
}) async {
  final environment = ref.watch(environmentProvider);
  final apiService = ref.watch(apiServiceProvider);
  DexPool poolOutput;

  // Load from cache
  final poolsListDatasource = await HivePoolsListDatasource.getInstance();
  final poolHive = poolsListDatasource.getPool(
    environment.name,
    poolInput.poolAddress,
  );

  if (forceLoadFromBC == true || poolHive == null) {
    // Set to cache
    await poolsListDatasource.setPool(
      environment.name,
      poolInput.toHive(),
    );
    poolOutput = poolInput;
  } else {
    poolOutput = poolHive.toDexPool();
  }

  // Load dynamic values
  final poolFactory =
      PoolFactoryRepositoryImpl(poolInput.poolAddress, apiService);
  final populatePoolInfosResult =
      await poolFactory.populatePoolInfos(poolInput);
  populatePoolInfosResult.map(
    success: (success) {
      poolOutput = success;
    },
    failure: (failure) {},
  );

  final userBalance = await ref.watch(userBalanceProvider.future);
  var lpTokenInUserBalance = false;
  for (final userTokensBalance in userBalance.token) {
    if (poolOutput.lpToken.address.toUpperCase() ==
        userTokensBalance.address!.toUpperCase()) {
      lpTokenInUserBalance = true;
    }
  }
  poolOutput = poolOutput.copyWith(
    lpTokenInUserBalance: lpTokenInUserBalance,
  );

  final tvl = await ref
      .watch(DexPoolProviders.estimatePoolTVLInFiat(poolOutput).future);

  poolOutput =
      await ref.watch(DexPoolProviders.estimateStats(poolOutput).future);

  // Favorite
  final favoritePoolsDatasource =
      await HiveFavoritePoolsDatasource.getInstance();
  final isFavorite = favoritePoolsDatasource.isFavoritePool(
    environment.name,
    poolInput.poolAddress,
  );

  return poolOutput.copyWith(
    isFavorite: isFavorite,
    infos: poolOutput.infos!.copyWith(
      tvl: tvl,
    ),
  );
}
