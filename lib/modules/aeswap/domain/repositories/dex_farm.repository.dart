import 'package:aewallet/modules/aeswap/domain/models/dex_farm.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

abstract class DexFarmRepository {
  Future<List<DexFarm>> getFarmList(
    String routerAddress,
    ApiService apiService,
    List<DexPool> poolList,
  );

  Future<DexFarm> populateFarmInfos(
    String farmGenesisAddress,
    DexPool pool,
    DexFarm farmInput,
    String userGenesisAddress,
  );
}
