/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;

abstract class PoolFactoryRepository {
  Future<Map<String, dynamic>> getPoolInfos();

  Future<aedappfm.Result<DexPool, aedappfm.Failure>> populatePoolInfos(
    DexPool poolInput,
  );

  Future<aedappfm.Result<double?, aedappfm.Failure>> getEquivalentAmount(
    String tokenAddress,
    double tokenAmount,
  );

  Future<aedappfm.Result<double?, aedappfm.Failure>> getPoolRatio(
    String tokenAddress,
  );

  Future<aedappfm.Result<double?, aedappfm.Failure>> getLPTokenToMint(
    double token1Amount,
    double token2Amount,
  );

  Future<aedappfm.Result<Map<String, dynamic>?, aedappfm.Failure>>
      getSwapInfosInput(
    String tokenAddress,
    double outputAmount,
  );

  Future<aedappfm.Result<Map<String, dynamic>?, aedappfm.Failure>>
      getSwapInfosOutput(
    String tokenAddress,
    double inputAmount,
  );

  Future<Map<String, dynamic>?> getRemoveAmounts(
    double lpTokenAmount,
  );

  Future<aedappfm.Result<void, aedappfm.Failure>> addLiquidity(
    double token1MinAmount,
    double token2MinAmount,
  );

  Future<aedappfm.Result<void, aedappfm.Failure>> removeLiquidity();

  Future<aedappfm.Result<void, aedappfm.Failure>> swap(
    double minAmountToReceive,
  );
}
