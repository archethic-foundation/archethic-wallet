/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/get_pool_infos_response.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/model_parser.dart';
import 'package:aewallet/modules/aeswap/domain/repositories/pool_factory.repository.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class PoolFactoryRepositoryImpl
    with ModelParser
    implements PoolFactoryRepository {
  PoolFactoryRepositoryImpl(this.factoryAddress, this.apiService);

  final String factoryAddress;
  final ApiService apiService;

  /// Returns infos of the pool as:
  /// {
  ///   "token1": {
  ///     "address": "00001234...",
  ///     "reserve": 1021.45
  ///   },
  ///   "token2": {
  ///     "address": "00005678...",
  ///     "reserve": 894.565
  ///   },
  ///   "lp_token": {
  ///     "address": "0000ABCD...",
  ///     "supply": 950.45645
  ///   },
  ///   "fee": 0.25
  /// }
  @override
  Future<Map<String, dynamic>> getPoolInfos() async {
    final result = await apiService.callSCFunction(
      jsonRPCRequest: SCCallFunctionRequest(
        method: 'contract_fun',
        params: SCCallFunctionParams(
          contract: factoryAddress.toUpperCase(),
          function: 'get_pool_infos',
          args: [],
        ),
      ),
      resultMap: true,
    ) as Map<String, dynamic>;

    return result;
  }

  @override
  Future<aedappfm.Result<DexPool, aedappfm.Failure>> populatePoolInfos(
    DexPool poolInput,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final result = await getPoolInfos();

        final getPoolInfosResponse = GetPoolInfosResponse.fromJson(result);
        return poolInfoToModel(poolInput, getPoolInfosResponse);
      },
    );
  }

  /// Returns the equivalent amount of the other token of the pool. This should be used in the process of adding liquidity
  /// [tokenAddress] is the token you want to provide (result amount will be the other token)
  /// [tokenAmount] is the amount of token_address you want to provide
  @override
  Future<aedappfm.Result<double?, aedappfm.Failure>> getEquivalentAmount(
    String tokenAddress,
    double tokenAmount,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final result = await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'get_equivalent_amount',
              args: [
                tokenAddress,
                tokenAmount,
              ],
            ),
          ),
        );
        return double.tryParse(result.toString());
      },
    );
  }

  /// Returns the pool ratio
  /// [tokenAddress] is the token you want to provide (result amount will be the other token)
  @override
  Future<aedappfm.Result<double?, aedappfm.Failure>> getPoolRatio(
    String tokenAddress,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final result = await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'get_ratio',
              args: [
                tokenAddress,
              ],
            ),
          ),
        );
        return double.tryParse(result.toString());
      },
    );
  }

  /// Returns the amount of LP token that will be minted if the amount of tokens are provided
  /// [token1Amount] Amount of token1 to provide (token1 is the first token returned by get_pair_tokens)
  /// [token1Amount] Amount of token2 to provide (token2 is the second token returned by get_pair_tokens)
  @override
  Future<aedappfm.Result<double?, aedappfm.Failure>> getLPTokenToMint(
    double token1Amount,
    double token2Amount,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final result = await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'get_lp_token_to_mint',
              args: [
                token1Amount,
                token2Amount,
              ],
            ),
          ),
        );
        return double.tryParse(result.toString());
      },
    );
  }

  /// Returns the info about a swap: expected output_amount, fee and price impact
  /// [tokenAddress] One of the 2 tokens of the pool
  /// [inputAmount] Amount of this token you want to swap
  @override
  Future<aedappfm.Result<Map<String, dynamic>?, aedappfm.Failure>>
      getSwapInfosOutput(
    String tokenAddress,
    double inputAmount,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final result = await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'get_output_swap_infos',
              args: [
                tokenAddress,
                inputAmount,
              ],
            ),
          ),
          resultMap: true,
        ) as Map<String, dynamic>?;

        return result;
      },
    );
  }

  /// Returns the info about a swap: expected input_amount, fee and price impact
  /// [tokenAddress] One of the 2 tokens of the pool
  /// [outputAmount] Amount of this token swapped
  @override
  Future<aedappfm.Result<Map<String, dynamic>?, aedappfm.Failure>>
      getSwapInfosInput(
    String tokenAddress,
    double outputAmount,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final result = await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'get_input_swap_infos',
              args: [
                tokenAddress,
                outputAmount,
              ],
            ),
          ),
          resultMap: true,
        ) as Map<String, dynamic>?;

        return result;
      },
    );
  }

  /// Returns amounts of token to get back when removing liquidity
  /// [lpTokenAmount] Number of lp token to remove
  @override
  Future<Map<String, dynamic>?> getRemoveAmounts(
    double lpTokenAmount,
  ) async {
    final result = await apiService.callSCFunction(
      jsonRPCRequest: SCCallFunctionRequest(
        method: 'contract_fun',
        params: SCCallFunctionParams(
          contract: factoryAddress.toUpperCase(),
          function: 'get_remove_amounts',
          args: [lpTokenAmount],
        ),
      ),
      resultMap: true,
    ) as Map<String, dynamic>?;
    return result;
  }

  /// This action allow user to add liquidity to the pool. User must send tokens to the pool's genesis address.
  /// The amounts sent should be equivalent to the pool ratio. User can specify a slippage tolerance by providing the minimum amount by token that the pool can use.
  /// If there is more fund sent by the user than the needed liquidity, the excedent is returned to the user.
  /// In exchange of the liquidity, the user will receive some LP token.
  /// [token1MinAmount] is the minimum amount of token1 to add in liquidity (token1 is the first token returned by the function get_pair_tokens())
  /// [token2MinAmount] is the minimum amount of token2 to add in liquidity (token2 is the second token returned by the function get_pair_tokens())
  @override
  Future<aedappfm.Result<void, aedappfm.Failure>> addLiquidity(
    double token1MinAmount,
    double token2MinAmount,
  ) async {
    return aedappfm.Result.guard(
      () async {
        await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'add_liquidity',
              args: [
                token1MinAmount,
                token2MinAmount,
              ],
            ),
          ),
        );
      },
    );
  }

  /// This action allow user to remove the liquidity he previously provided.
  /// User must send the lp token he wants to remove to the burn address ("000...000")
  /// (don't forget to add the pool in recipient otherwise lp token will only be burned).
  /// The pool will calculate the share of the user and return the corresponding amount of both pool tokens.
  @override
  Future<aedappfm.Result<void, aedappfm.Failure>> removeLiquidity() async {
    return aedappfm.Result.guard(
      () async {
        await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'remove_liquidity',
              args: [],
            ),
          ),
        );
      },
    );
  }

  /// This action allow user to swap a token of the pool against the other token.
  /// User must send the input token to the pool's genesis address.
  /// The pool will calculate the output amount and send it to the user.
  /// User can specify a slippage tolerance by providing the minimum amount of the output token to receive.
  /// [minAmountToReceive] is the minimum amount of the output token to receive
  @override
  Future<aedappfm.Result<void, aedappfm.Failure>> swap(
    double minAmountToReceive,
  ) async {
    return aedappfm.Result.guard(
      () async {
        await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'swap',
              args: [
                minAmountToReceive,
              ],
            ),
          ),
        );
      },
    );
  }
}
