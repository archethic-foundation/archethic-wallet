import 'package:aewallet/modules/aeswap/application/farm/farm_lock_factory.dart';
import 'package:aewallet/modules/aeswap/application/router_factory.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_farm.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/domain/repositories/dex_farm_lock.repository.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class DexFarmLockRepositoryImpl implements DexFarmLockRepository {
  DexFarmLockRepositoryImpl({
    required this.apiService,
    required this.verifiedTokensRepository,
  });

  final ApiService apiService;
  final aedappfm.VerifiedTokensRepositoryInterface verifiedTokensRepository;

  @override
  Future<List<DexFarm>> getFarmLockList(
    String routerAddress,
    List<DexPool> poolList,
  ) async =>
      RouterFactory(
        routerAddress,
        apiService,
        verifiedTokensRepository,
      )
          .getFarmList(
            poolList,
            farmType: kFarmTypeLock,
          )
          .valueOrThrow;

  @override
  Future<DexFarmLock> populateFarmLockInfos(
    String farmGenesisAddress,
    DexPool pool,
    DexFarmLock farmLockInput,
    String userGenesisAddress,
  ) async {
    final farmLockFactory = FarmLockFactory(farmGenesisAddress, apiService);

    return farmLockFactory
        .populateFarmLockInfos(pool, farmLockInput, userGenesisAddress)
        .valueOrThrow;
  }
}
