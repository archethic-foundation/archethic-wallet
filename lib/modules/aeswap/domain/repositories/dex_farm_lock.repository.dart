import 'package:aewallet/modules/aeswap/domain/models/dex_farm.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

abstract class DexFarmLockRepository {
  Future<List<DexFarm>> getFarmLockList(
    String routerAddress,
    ApiService apiService,
    List<DexPool> poolList,
  );

  Future<DexFarmLock> populateFarmLockInfos(
    String farmGenesisAddress,
    DexPool pool,
    DexFarmLock farmLockInput,
    String userGenesisAddress,
  );
}
