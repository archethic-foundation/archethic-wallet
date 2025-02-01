/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/get_farm_lock_farm_infos_response.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/model_parser.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class FarmLockFactory with ModelParser {
  FarmLockFactory(this.factoryAddress, this.apiService);

  final String factoryAddress;
  final ApiService apiService;

  /// Returns the informations of the farm
  Future<Map<String, dynamic>> getFarmInfos() async {
    final result = await apiService.callSCFunction(
      jsonRPCRequest: SCCallFunctionRequest(
        method: 'contract_fun',
        params: SCCallFunctionParams(
          contract: factoryAddress.toUpperCase(),
          function: 'get_farm_infos',
          args: [],
        ),
      ),
      resultMap: true,
    ) as Map<String, dynamic>;

    return result;
  }

  Future<aedappfm.Result<DexFarmLock, aedappfm.Failure>> populateFarmLockInfos(
    DexPool pool,
    DexFarmLock farmLockInput,
    String userGenesisAddress,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final result = await getFarmInfos();

        final getFarmLockInfosResponse =
            GetFarmLockFarmInfosResponse.fromJson(result);
        return farmLockInfosToModel(
          apiService,
          factoryAddress,
          getFarmLockInfosResponse,
          pool,
          userGenesisAddress,
          dexFarmLockInput: farmLockInput,
        );
      },
    );
  }

  /// Returns the informations of a user who has deposited and locked lp token in the farm
  Future<List<dynamic>> getUserInfos(
    String userGenesisAddress,
  ) async {
    if (userGenesisAddress.isEmpty) {
      return [];
    }
    final results = await apiService.callSCFunction(
      jsonRPCRequest: SCCallFunctionRequest(
        method: 'contract_fun',
        params: SCCallFunctionParams(
          contract: factoryAddress.toUpperCase(),
          function: 'get_user_infos',
          args: [userGenesisAddress],
        ),
      ),
      resultMap: true,
    ) as List<dynamic>;

    return results;
  }

  /// Returns the informations of multiple addresses who has deposited and locked lp token in the farm
  Future<List<dynamic>> getUserInfosFromMultipleAddresses(
    List<String> userGenesisAddresses,
  ) async {
    if (userGenesisAddresses.isEmpty) {
      return [];
    }

    final scCallFunctionRequestList = <SCCallFunctionRequest>[];
    for (final userGenesisAddress in userGenesisAddresses) {
      scCallFunctionRequestList.add(
        SCCallFunctionRequest(
          method: 'contract_fun',
          params: SCCallFunctionParams(
            contract: factoryAddress.toUpperCase(),
            function: 'get_user_infos',
            args: [userGenesisAddress],
          ),
        ),
      );
    }

    final results = await apiService.callSCFunctionMulti(
      jsonRPCRequests: scCallFunctionRequestList,
    );

    final userinfos = [];
    for (final result in results) {
      if (result['result'] != null && (result['result'] as List).isNotEmpty) {
        userinfos.add(result['result']);
      }
    }

    return userinfos;
  }
}
