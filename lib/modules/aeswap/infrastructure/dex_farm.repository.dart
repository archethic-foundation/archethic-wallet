import 'package:aewallet/modules/aeswap/application/farm/farm_factory.dart';
import 'package:aewallet/modules/aeswap/application/router_factory.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_farm.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/domain/repositories/dex_farm.repository.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class DexFarmRepositoryImpl implements DexFarmRepository {
  @override
  Future<List<DexFarm>> getFarmList(
    String routerAddress,
    ApiService apiService,
    List<DexPool> poolList,
  ) async =>
      RouterFactory(
        routerAddress,
        apiService,
      )
          .getFarmList(
            poolList,
            farmType: kFarmTypeLock,
          )
          .valueOrThrow;

  @override
  Future<DexFarm> populateFarmInfos(
    String farmGenesisAddress,
    DexPool pool,
    DexFarm farmInput,
    String userGenesisAddress,
  ) async {
    final apiService = aedappfm.sl.get<ApiService>();
    final farmFactory = FarmFactory(farmGenesisAddress, apiService);

    return farmFactory
        .populateFarmInfos(pool, farmInput, userGenesisAddress)
        .valueOrThrow;
  }
}
