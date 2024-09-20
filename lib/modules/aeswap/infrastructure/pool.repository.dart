import 'dart:async';

import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/get_pool_infos_response.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/model_parser.dart';
import 'package:aewallet/modules/aeswap/domain/repositories/pool.repository.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class PoolRepositoryImpl with ModelParser implements PoolRepository {
  PoolRepositoryImpl(this.apiService);

  final ApiService apiService;

  @override
  Future<List<DexPool>> getPoolInfosBatch(List<DexPool> poolList) async {
    final poolInfosList = <DexPool>[];
    final batches = <List<DexPool>>[];
    for (var i = 0; i < poolList.length; i += 20) {
      batches.add(
        poolList.sublist(
          i,
          i + 20 > poolList.length ? poolList.length : i + 20,
        ),
      );
    }

    final futures = <Future<List<DexPool>>>[];
    for (final batch in batches) {
      futures.add(_processBatch(batch));
    }
    final results = await Future.wait(futures);
    for (final result in results) {
      poolInfosList.addAll(result);
    }

    return poolInfosList;
  }

  Future<List<DexPool>> _processBatch(List<DexPool> batch) async {
    final resultBatch = <DexPool>[];
    final scCallFunctionRequests = <SCCallFunctionRequest>[];
    final mapPoolByRPCId = <int, DexPool>{};
    var id = 1;

    for (final pool in batch) {
      mapPoolByRPCId[id] = pool;
      scCallFunctionRequests.add(
        SCCallFunctionRequest(
          method: 'contract_fun',
          id: id,
          params: SCCallFunctionParams(
            contract: pool.poolAddress.toUpperCase(),
            function: 'get_pool_infos',
            args: [],
          ),
        ),
      );
      id++;
    }

    final resultJsonGlobal = await apiService.callSCFunctionMulti(
      jsonRPCRequests: scCallFunctionRequests,
    );

    for (final resultJson in resultJsonGlobal) {
      if (resultJson.containsKey('result') &&
          resultJson.containsKey('id') &&
          mapPoolByRPCId[resultJson['id']] != null) {
        final result = resultJson['result'] as Map<String, dynamic>;
        final getPoolInfosResponse = GetPoolInfosResponse.fromJson(result);
        final poolInput = mapPoolByRPCId[resultJson['id']];
        final dexPool = await poolInfoToModel(poolInput!, getPoolInfosResponse);
        resultBatch.add(dexPool);
      }
    }
    return resultBatch;
  }
}
