/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/modules/aeswap/domain/models/dex_farm.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/get_farm_infos_response.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/get_user_infos_response.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/model_parser.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

/// Farm is a factory allowing users to deposit lp token from a pool and to receive reward for a period of time.
class FarmFactory with ModelParser {
  FarmFactory(this.factoryAddress, this.apiService);

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

  Future<aedappfm.Result<DexFarm, aedappfm.Failure>> populateFarmInfos(
    DexPool pool,
    DexFarm farmInput,
    String userGenesisAddress,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final result = await getFarmInfos();

        final getFarmInfosResponse = GetFarmInfosResponse.fromJson(result);
        return farmInfosToModel(
          factoryAddress,
          getFarmInfosResponse,
          pool,
          userGenesisAddress,
          dexFarmInput: farmInput,
        );
      },
    );
  }

  /// Returns the informations of a user who has deposited lp token in the farm
  Future<
      aedappfm.Result<({double depositedAmount, double rewardAmount}),
          aedappfm.Failure>> getUserInfos(
    String userGenesisAddress,
  ) async {
    return aedappfm.Result.guard(
      () async {
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
        ) as Map<String, dynamic>?;

        final getUserInfosResponse = GetUserInfosResponse.fromJson(results!);
        return (
          depositedAmount: getUserInfosResponse.depositedAmount,
          rewardAmount: getUserInfosResponse.rewardAmount,
        );
      },
    );
  }
}
