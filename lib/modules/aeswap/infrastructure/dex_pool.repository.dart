import 'package:aewallet/modules/aeswap/application/router_factory.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/domain/repositories/dex_pool.repository.dart';
import 'package:aewallet/modules/aeswap/infrastructure/dex_config.repository.dart';
import 'package:aewallet/modules/aeswap/infrastructure/hive/dex_pool.hive.dart';
import 'package:aewallet/modules/aeswap/infrastructure/hive/pools_list.hive.dart';
import 'package:aewallet/modules/aeswap/infrastructure/pool_factory.repository.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class DexPoolRepositoryImpl implements DexPoolRepository {
  DexPoolRepositoryImpl({
    required this.apiService,
    required this.verifiedTokensRepository,
  });

  final ApiService apiService;
  final aedappfm.VerifiedTokensRepositoryInterface verifiedTokensRepository;

  @override
  Future<DexPool?> getPool(
    String poolAddress,
    List<String> tokenVerifiedList,
  ) async {
    final environment = aedappfm.Environment.byEndpoint(apiService.endpoint);
    final poolsListDatasource = await HivePoolsListDatasource.getInstance();
    final poolHive = poolsListDatasource.getPool(
      environment.name,
      poolAddress,
    );
    if (poolHive == null) {
      final dexConf = await DexConfigRepositoryImpl().getDexConfig(environment);
      final resultPoolList = await RouterFactory(
        dexConf.routerGenesisAddress,
        apiService,
        verifiedTokensRepository,
      ).getPoolList(environment, tokenVerifiedList);

      return await resultPoolList.map(
        success: (poolList) async {
          for (final poolInput in poolList) {
            if (poolInput.poolAddress.toUpperCase() ==
                poolAddress.toUpperCase()) {
              final pool = await populatePoolInfos(poolInput);
              await poolsListDatasource.setPool(
                environment.name,
                pool.toHive(),
              );
              return pool;
            }
          }
          return null;
        },
        failure: (failure) {
          return null;
        },
      );
    }

    return poolsListDatasource
        .getPool(environment.name, poolAddress)
        ?.toDexPool();
  }

  @override
  Future<DexPool> populatePoolInfos(
    DexPool poolInput,
  ) async {
    final poolFactory = PoolFactoryRepositoryImpl(
      poolInput.poolAddress,
      apiService,
    );

    return poolFactory.populatePoolInfos(poolInput).valueOrThrow;
  }
}
