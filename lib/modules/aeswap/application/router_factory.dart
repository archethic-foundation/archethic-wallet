/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/modules/aeswap/domain/models/dex_farm.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/get_farm_list_response.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/get_pool_list_response.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/model_parser.dart';
import 'package:aewallet/modules/aeswap/infrastructure/hive/dex_token.hive.dart';
import 'package:aewallet/modules/aeswap/infrastructure/hive/tokens_list.hive.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

/// Router is a helper factory for user to easily retrieve existing pools and create new pools.
class RouterFactory with ModelParser {
  RouterFactory(this.factoryAddress, this.apiService);

  final String factoryAddress;
  final ApiService apiService;

  /// Returns the info of the pool for the 2 tokens address.
  /// [token1Address] is the address of the first token
  /// [token2Address] is the address of the second token
  Future<aedappfm.Result<Map<String, dynamic>?, aedappfm.Failure>>
      getPoolAddresses(
    String token1Address,
    String token2Address,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final result = await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'get_pool_addresses',
              args: [
                token1Address,
                token2Address,
              ],
            ),
          ),
          resultMap: true,
        ) as Map<String, dynamic>?;
        if (result == null) {
          aedappfm.sl.get<aedappfm.LogManager>().log(
                'getPoolAddresses: result null $token1Address $token2Address',
                level: aedappfm.LogLevel.error,
                name: 'getPoolAddresses',
              );
        }
        return result;
      },
    );
  }

  /// Return the infos of all the pools.
  Future<aedappfm.Result<List<DexPool>, aedappfm.Failure>> getPoolList(
    List<String> tokenVerifiedList,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final results = await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'get_pool_list',
              args: [],
            ),
          ),
          resultMap: true,
        ) as List<dynamic>;

        final poolList = <DexPool>[];

        final tokensListDatasource =
            await HiveTokensListDatasource.getInstance();
        final tokensAddresses = <String>[];
        for (final result in results) {
          final getPoolListResponse = GetPoolListResponse.fromJson(result);
          final tokens = getPoolListResponse.tokens.split('/');
          if (tokens[0] != 'UCO') {
            if (tokensListDatasource.getToken(
                  aedappfm.EndpointUtil.getEnvironnement(),
                  tokens[0],
                ) ==
                null) {
              tokensAddresses.add(tokens[0]);
            }
          }
          if (tokens[1] != 'UCO') {
            if (tokensListDatasource.getToken(
                  aedappfm.EndpointUtil.getEnvironnement(),
                  tokens[1],
                ) ==
                null) {
              tokensAddresses.add(tokens[1]);
            }
          }
          if (tokensListDatasource.getToken(
                aedappfm.EndpointUtil.getEnvironnement(),
                getPoolListResponse.lpTokenAddress,
              ) ==
              null) {
            tokensAddresses.add(getPoolListResponse.lpTokenAddress);
          }
        }
        final tokenResultMap = await aedappfm.sl.get<ApiService>().getToken(
              tokensAddresses.toSet().toList(),
              request: 'name, symbol',
            );

        for (final entry in tokenResultMap.entries) {
          final address = entry.key.toUpperCase();
          var tokenResult = tokenSDKToModel(entry.value, 0);
          tokenResult = tokenResult.copyWith(address: address);
          await tokensListDatasource.setToken(
            aedappfm.EndpointUtil.getEnvironnement(),
            tokenResult.toHive(),
          );
        }

        for (final result in results) {
          final getPoolListResponse = GetPoolListResponse.fromJson(result);
          poolList.add(
            await poolListItemToModel(getPoolListResponse, tokenVerifiedList),
          );
        }

        return poolList;
      },
    );
  }

  /// Return the infos of all the farms.
  Future<aedappfm.Result<List<DexFarm>, aedappfm.Failure>> getFarmList(
    List<DexPool> poolList, {
    int farmType = 1,
  }) async {
    return aedappfm.Result.guard(
      () async {
        final results = await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'get_farm_list',
              args: [],
            ),
          ),
          resultMap: true,
        ) as List<dynamic>;

        final farmList = <DexFarm>[];

        for (final result in results) {
          final getFarmListResponse = GetFarmListResponse.fromJson(result);
          if (getFarmListResponse.type != null &&
              getFarmListResponse.type == 2) {
            continue;
          }
          final dexpool = poolList.singleWhere(
            (pool) =>
                pool.lpToken.address!.toUpperCase() ==
                getFarmListResponse.lpTokenAddress.toUpperCase(),
          );

          farmList.add(
            await farmListToModel(
              getFarmListResponse,
              dexpool,
            ),
          );
        }

        return farmList;
      },
    );
  }

  /// This action allows users to add a new pool in the router.
  /// The transaction triggering this action should be the transaction that create the pool.
  /// The transaction should be a token transaction with the token definition returned by the function get_lp_token_definition.
  /// It should also have the code returned by the function get_pool_code.
  Future<aedappfm.Result<void, aedappfm.Failure>> addPool(
    String token1Address,
    String token2Address,
    String stateAddress,
  ) async {
    return aedappfm.Result.guard(
      () async {
        await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'add_pool',
              args: [
                token1Address,
                token2Address,
                stateAddress,
              ],
            ),
          ),
        );
      },
    );
  }

  /// This action allows the Master chain of the dex to add a new farm in the router.
  /// The transaction triggering this action should also add the first amount of reward token to the previously created farm.
  /// The transaction that created the farm should be a contract transaction with the code returned by the function get_farm_code
  /// of the Factory contract.
  Future<aedappfm.Result<void, aedappfm.Failure>> addFarm(
    String lpTokenAddress,
    int startDate,
    int endDate,
    String rewardTokenAddress,
    String farmCreationAddress,
  ) async {
    return aedappfm.Result.guard(
      () async {
        await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'add_farm',
              args: [
                lpTokenAddress,
                startDate,
                endDate,
                rewardTokenAddress,
                farmCreationAddress,
              ],
            ),
          ),
        );
      },
    );
  }
}
