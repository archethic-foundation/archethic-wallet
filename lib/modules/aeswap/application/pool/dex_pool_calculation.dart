/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'dex_pool.dart';

@riverpod
Future<double> _getRatio(
  _GetRatioRef ref,
  String poolGenesisAddress,
  DexToken token,
) async {
  final apiService = ref.watch(apiServiceProvider);
  final poolRatioResult = await PoolFactoryRepositoryImpl(
    poolGenesisAddress,
    apiService,
  ).getPoolRatio(
    token.address,
  );
  var ratio = 0.0;
  poolRatioResult.map(
    success: (success) {
      if (success != null) {
        ratio = success;
      }
    },
    failure: (failure) {},
  );
  return ratio;
}

@riverpod
Future<double> _estimatePoolTVLInFiat(
  _EstimatePoolTVLInFiatRef ref,
  DexPool? pool,
) async {
  if (pool == null) return 0;

  var fiatValueToken1 = 0.0;
  var fiatValueToken2 = 0.0;
  var tvl = 0.0;
  fiatValueToken1 = await ref.watch(
    DexTokensProviders.estimateTokenInFiat(pool.pair.token1.address).future,
  );
  fiatValueToken2 = await ref.watch(
    DexTokensProviders.estimateTokenInFiat(pool.pair.token2.address).future,
  );

  if (fiatValueToken1 > 0 && fiatValueToken2 > 0) {
    tvl = pool.pair.token1.reserve * fiatValueToken1 +
        pool.pair.token2.reserve * fiatValueToken2;
  }

  if (fiatValueToken1 > 0 && fiatValueToken2 == 0) {
    tvl = pool.pair.token1.reserve * fiatValueToken1 * 2;
  }

  if (fiatValueToken1 == 0 && fiatValueToken2 > 0) {
    tvl = pool.pair.token2.reserve * fiatValueToken2 * 2;
  }
  return tvl;
}

@riverpod
Future<DexPool> _estimateStats(
  _EstimateStatsRef ref,
  DexPool pool,
) async {
  final apiService = ref.watch(apiServiceProvider);
  final session = ref.watch(sessionAESwapNotifierProvider);

  var volume24h = 0.0;
  var volume7d = 0.0;
  var fee24h = 0.0;
  var volumeAllTime = 0.0;
  var feeAllTime = 0.0;

  var priceToken1 = 0.0;
  var priceToken2 = 0.0;

  var token1TotalVolumeCurrentFiat = 0.0;
  var token2TotalVolumeCurrentFiat = 0.0;
  var token1TotalVolume24hFiat = 0.0;
  var token2TotalVolume24hFiat = 0.0;
  var token1TotalVolume7dFiat = 0.0;
  var token2TotalVolume7dFiat = 0.0;

  var token1TotalFeeCurrentFiat = 0.0;
  var token2TotalFeeCurrentFiat = 0.0;
  var token1TotalFee24hFiat = 0.0;
  var token2TotalFee24hFiat = 0.0;

  var token1TotalVolume24h = 0.0;
  var token2TotalVolume24h = 0.0;
  var token1TotalVolume7d = 0.0;
  var token2TotalVolume7d = 0.0;
  var token1TotalFee24h = 0.0;
  var token2TotalFee24h = 0.0;

  final fromCriteria24h =
      (DateTime.now().subtract(const Duration(days: 1)).millisecondsSinceEpoch /
              1000)
          .round();
  final fromCriteria7d =
      (DateTime.now().subtract(const Duration(days: 7)).millisecondsSinceEpoch /
              1000)
          .round();

  final transactionFuture24h = apiService.getTransactionChain(
    {pool.poolAddress: ''},
    request:
        ' address, previousAddress, validationStamp { ledgerOperations { unspentOutputs { state } } }',
    fromCriteria: fromCriteria24h,
  );

  final transactionFuture7d = apiService.getTransactionChain(
    {pool.poolAddress: ''},
    request:
        ' address, previousAddress, validationStamp { ledgerOperations { unspentOutputs { state } } }',
    fromCriteria: fromCriteria7d,
  );

  final results =
      await Future.wait([transactionFuture24h, transactionFuture7d]);

  final transactionChainResult24h = results[0];
  final transactionChainResult7d = results[1];

  String? previousAddressSearchCriteria24h;
  String? previousAddressSearchCriteria7d;
  final previousAddressSearchCriteria = <String>[];

  if (transactionChainResult24h[pool.poolAddress] != null &&
      transactionChainResult24h[pool.poolAddress]!.isNotEmpty) {
    previousAddressSearchCriteria24h =
        transactionChainResult24h[pool.poolAddress]!
            .first
            .previousAddress!
            .address;

    previousAddressSearchCriteria.add(previousAddressSearchCriteria24h!);
  }

  if (transactionChainResult7d[pool.poolAddress] != null &&
      transactionChainResult7d[pool.poolAddress]!.isNotEmpty) {
    previousAddressSearchCriteria7d =
        transactionChainResult7d[pool.poolAddress]!
            .first
            .previousAddress!
            .address;
    previousAddressSearchCriteria.add(previousAddressSearchCriteria7d!);
  }

  Transaction? transaction24h;
  Transaction? transaction7d;
  Map<String, Transaction>? transactionsPrevious;

  if (previousAddressSearchCriteria.isNotEmpty) {
    transactionsPrevious = await apiService.getTransaction(
      previousAddressSearchCriteria,
      request:
          ' address, previousAddress, validationStamp { ledgerOperations { unspentOutputs { state } } }',
    );
  }

  if (previousAddressSearchCriteria24h != null &&
      transactionsPrevious != null) {
    transaction24h = transactionsPrevious[previousAddressSearchCriteria24h];
  } else {
    if (transactionChainResult24h[pool.poolAddress]!.isNotEmpty) {
      transaction24h = transactionChainResult24h[pool.poolAddress]!.first;
    }
  }

  if (previousAddressSearchCriteria7d != null && transactionsPrevious != null) {
    transaction7d = transactionsPrevious[previousAddressSearchCriteria7d];
  } else {
    if (transactionChainResult7d[pool.poolAddress]!.isNotEmpty) {
      transaction7d = transactionChainResult7d[pool.poolAddress]!.first;
    }
  }

  bool? stateExists24h;
  if (transaction24h != null) {
    stateExists24h = false;
    if (transaction24h.validationStamp != null &&
        transaction24h.validationStamp!.ledgerOperations != null &&
        transaction24h
            .validationStamp!.ledgerOperations!.unspentOutputs.isNotEmpty) {
      for (final unspentOutput
          in transaction24h.validationStamp!.ledgerOperations!.unspentOutputs) {
        if (unspentOutput.state != null) {
          stateExists24h = true;
          final state = unspentOutput.state;
          token1TotalVolume24h = state!['stats'] == null ||
                  state['stats']['token1_total_volume'] == null
              ? 0
              : Decimal.parse(
                  state['stats']['token1_total_volume'].toString(),
                ).toDouble();
          token2TotalVolume24h = state['stats'] == null ||
                  state['stats']['token2_total_volume'] == null
              ? 0
              : Decimal.parse(
                  state['stats']['token2_total_volume'].toString(),
                ).toDouble();
          token1TotalFee24h = state['stats'] == null ||
                  state['stats']['token1_total_fee'] == null
              ? 0
              : Decimal.parse(state['stats']['token1_total_fee'].toString())
                  .toDouble();
          token2TotalFee24h = state['stats'] == null ||
                  state['stats']['token2_total_fee'] == null
              ? 0
              : Decimal.parse(state['stats']['token2_total_fee'].toString())
                  .toDouble();
        }
      }
    }
  }

  bool? stateExists7d;
  if (transaction7d != null) {
    stateExists7d = false;
    if (transaction7d.validationStamp != null &&
        transaction7d.validationStamp!.ledgerOperations != null &&
        transaction7d
            .validationStamp!.ledgerOperations!.unspentOutputs.isNotEmpty) {
      for (final unspentOutput
          in transaction7d.validationStamp!.ledgerOperations!.unspentOutputs) {
        if (unspentOutput.state != null) {
          stateExists7d = true;
          final state = unspentOutput.state;
          token1TotalVolume7d = state!['stats'] == null ||
                  state['stats']['token1_total_volume'] == null
              ? 0
              : Decimal.parse(
                  state['stats']['token1_total_volume'].toString(),
                ).toDouble();
          token2TotalVolume7d = state['stats'] == null ||
                  state['stats']['token2_total_volume'] == null
              ? 0
              : Decimal.parse(
                  state['stats']['token2_total_volume'].toString(),
                ).toDouble();
        }
      }
    }
  }

  final archethicOracleUCO =
      ref.watch(aedappfm.ArchethicOracleUCOProviders.archethicOracleUCO);

  if (pool.pair.token1.isUCO) {
    priceToken1 = archethicOracleUCO.usd;
  } else {
    priceToken1 = await ref.watch(
      aedappfm.CoinPriceProviders.coinPrice(
        address: pool.pair.token1.address,
        environment: session.environment,
      ).future,
    );
  }

  if (pool.pair.token2.isUCO) {
    priceToken2 = archethicOracleUCO.usd;
  } else {
    priceToken2 = await ref.watch(
      aedappfm.CoinPriceProviders.coinPrice(
        address: pool.pair.token2.address,
        environment: session.environment,
      ).future,
    );
  }

  if (priceToken1 == 0 && priceToken2 > 0) {
    priceToken1 = (Decimal.parse('${pool.infos!.ratioToken1Token2}') *
            Decimal.parse('$priceToken2'))
        .toDouble();
  }

  if (priceToken2 == 0 && priceToken1 > 0) {
    priceToken2 = (Decimal.parse('${pool.infos!.ratioToken2Token1}') *
            Decimal.parse('$priceToken1'))
        .toDouble();
  }

  final poolDetails = pool.infos;
  if (poolDetails != null) {
    token1TotalVolumeCurrentFiat = priceToken1 * poolDetails.token1TotalVolume;
    token2TotalVolumeCurrentFiat = priceToken2 * poolDetails.token2TotalVolume;

    token1TotalFeeCurrentFiat = priceToken1 * poolDetails.token1TotalFee;
    token2TotalFeeCurrentFiat = priceToken2 * poolDetails.token2TotalFee;

    token1TotalVolume24hFiat = priceToken1 * token1TotalVolume24h;
    token2TotalVolume24hFiat = priceToken2 * token2TotalVolume24h;

    token1TotalVolume7dFiat = priceToken1 * token1TotalVolume7d;
    token2TotalVolume7dFiat = priceToken2 * token2TotalVolume7d;

    token1TotalFee24hFiat = priceToken1 * token1TotalFee24h;
    token2TotalFee24hFiat = priceToken2 * token2TotalFee24h;
  }

  volumeAllTime = token1TotalVolumeCurrentFiat + token2TotalVolumeCurrentFiat;

  feeAllTime = token1TotalFeeCurrentFiat + token2TotalFeeCurrentFiat;

  if (stateExists24h != null) {
    if (stateExists24h == false) {
      volume24h = volumeAllTime;
      fee24h = feeAllTime;
    } else {
      if (token1TotalVolume24hFiat + token2TotalVolume24hFiat > 0) {
        volume24h = volumeAllTime -
            (token1TotalVolume24hFiat + token2TotalVolume24hFiat);
      }

      if (token1TotalFee24hFiat + token2TotalFee24hFiat > 0) {
        fee24h = feeAllTime - (token1TotalFee24hFiat + token2TotalFee24hFiat);
      }
    }
  }

  if (stateExists7d != null) {
    if (stateExists7d == false) {
      volume7d = volumeAllTime;
    } else {
      if (token1TotalVolume7dFiat + token2TotalVolume7dFiat > 0) {
        volume7d =
            volumeAllTime - (token1TotalVolume7dFiat + token2TotalVolume7dFiat);
      }
    }
  }

  var poolInfos = pool.infos!;
  poolInfos = poolInfos.copyWith(
    token1TotalVolume24h: token1TotalVolume24h,
    token2TotalVolume24h: token2TotalVolume24h,
    token1TotalFee24h: token1TotalFee24h,
    token2TotalFee24h: token2TotalFee24h,
    fee24h: fee24h,
    feeAllTime: feeAllTime,
    volume24h: volume24h,
    volume7d: volume7d,
    volumeAllTime: volumeAllTime,
  );
  return pool.copyWith(infos: poolInfos);
}
