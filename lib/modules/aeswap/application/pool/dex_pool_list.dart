/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'dex_pool.dart';

@riverpod
Future<List<DexPool>> _getPoolList(
  _GetPoolListRef ref,
) async {
  final environment = ref.watch(environmentProvider);
  final aeETHUCOPoolAddress = environment.aeETHUCOPoolAddress;

  final dexConf = await ref.watch(DexConfigProviders.dexConfig.future);

  final tokenVerifiedList = await ref.watch(
    verifiedTokensProvider.future,
  );

  final resultPoolList = await ref
      .watch(
        routerFactoryProvider(
          dexConf.routerGenesisAddress,
        ),
      )
      .getPoolList(
        environment,
        tokenVerifiedList,
      );

  final userBalance = await ref.watch(userBalanceProvider.future);
  return resultPoolList.map<List<DexPool>>(
    success: (pools) {
      return pools.map((pool) {
        final lpTokenInUserBalance = userBalance.token.any(
          (token) =>
              token.address!.toUpperCase() ==
              pool.lpToken.address.toUpperCase(),
        );
        return pool.copyWith(
          lpTokenInUserBalance: lpTokenInUserBalance,
        );
      }).toList()
        ..sort((a, b) {
          if (a.poolAddress.toUpperCase() ==
              aeETHUCOPoolAddress.toUpperCase()) {
            return -1;
          } else if (b.poolAddress.toUpperCase() ==
              aeETHUCOPoolAddress.toUpperCase()) {
            return 1;
          } else {
            return 0;
          }
        });
    },
    failure: (failure) => [],
  );
}

@riverpod
List<DexPool> _getPoolListForSearch(
  _GetPoolListForSearchRef ref,
  String searchText,
  List<DexPool> poolList,
) {
  bool _poolMatchesSearch(DexPool pool) {
    return (pool.poolAddress.toUpperCase() == searchText.toUpperCase() ||
            pool.pair.token1.address.toUpperCase() ==
                searchText.toUpperCase() ||
            pool.pair.token2.address.toUpperCase() ==
                searchText.toUpperCase() ||
            pool.lpToken.address.toUpperCase() == searchText.toUpperCase()) ||
        (searchText.toUpperCase().isUCO &&
            (pool.pair.token1.isUCO || pool.pair.token2.isUCO));
  }

  final dexPools = <DexPool>[];
  if (searchText.isEmpty ||
      (searchText.length != 68 && searchText.toUpperCase().isNotUCO)) {
    return dexPools;
  }

  for (final pool in poolList) {
    if (_poolMatchesSearch(pool)) dexPools.add(pool);
  }
  return dexPools;
}
